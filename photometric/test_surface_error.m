close all
clear all
clc
 
disp('Part 1: Photometric Stereo')

% obtain many images in a fixed view under different illumination
disp('Loading images...')
image_dir = './photometrics_images/MonkeyGray/';
%image_ext = '*.png';

[image_stack, scriptV] = load_syn_images(image_dir);
[h, w, n] = size(image_stack);
fprintf('Finish loading %d images.\n\n', n);

w_bar = waitbar(0, 'time is passing'); %progress bar

for k =4:13:n
    rand_select = randperm(n, k);
    image_samples = image_stack(:,:, rand_select);
    scriptV_sample = scriptV(rand_select,:);

    % compute the surface gradient from the stack of imgs and light source mat
    disp('Computing surface albedo and normal map...')
    [albedo, normals] = estimate_alb_nrm(image_samples, scriptV_sample, false);

    %% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
    disp('Integrability checking')
    [p, q, SE] = check_integrability(normals);

    threshold = 0.005;
    SE(SE <= threshold) = NaN; % for good visualization
    fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));

    %% compute the surface height
    height_map_ave{k} = construct_surface( p, q, 'average' );

    %% Display
    show_results(albedo, normals, SE);
    show_model(albedo, height_map_ave{k});
    
    waitbar(k/n, w_bar); 
end

close(w_bar)




