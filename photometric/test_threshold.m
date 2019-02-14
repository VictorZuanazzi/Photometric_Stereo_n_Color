close all
clear all
clc
 
disp('Part 1: Photometric Stereo')

% obtain many images in a fixed view under different illumination
disp('Loading images...')
image_dir = ["./photometrics_images/SphereGray5/", "./photometrics_images/yaleB02/"]; 
label = ["Sphere", "Face"];
%image_ext = '*.png';

for k = 1:length(label)
    
    if (label(k) == "Face")
        [image_stack, scriptV] = load_face_images('./photometrics_images/yaleB02/');
        use_trick = false;
    else
        [image_stack, scriptV] = load_syn_images(image_dir(k));
        use_trick = true;
    end
    
    [h, w, n] = size(image_stack);
    fprintf('Finish loading %d images.\n\n', n);

    % compute the surface gradient from the stack of imgs and light source mat
    disp('Computing surface albedo and normal map...')
    [albedo, normals] = estimate_alb_nrm(image_stack, scriptV, use_trick);


    %% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
    disp('Integrability checking')
    [p, q, SE] = check_integrability(normals);

    for t = 1:5
        threshold = (2^t)/1000; %0.005;
        SE_t{t} = SE;
        SE_t{t}(SE <= threshold) = NaN; % for good visualization
        fprintf('Image: %s Threshold: %d Number of outliers: %d\n\n',label(k), threshold, sum(sum(SE_t{t} > threshold)))

        %% Display
        name = label(k)+"_"+threshold+".png";
        display_SE( name, normals, SE_t{t});
    end
end
