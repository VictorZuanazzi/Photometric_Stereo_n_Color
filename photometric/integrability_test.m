close all
clear all
clc
 
disp('Part 1: Photometric Stereo')

% obtain many images in a fixed view under different illumination
disp('Loading images...')
%image_dir = './photometrics_images/SphereGray25/';
%image_dir = './photometrics_images/MonkeyGray/';
%image_ext = '*.png';

image_dir = ["./photometrics_images/SphereGray25/"; "./photometrics_images/yaleB02/"; "./photometrics_images/MonkeyGray/"];
label = ["Sphere"; "Face"; "Monkey"];


num_runs = 5;

w_bar = waitbar(0, 'work hard, play hard'); %progress bar
fig1 = figure();
for k = 1:length(label)
    if (label(k) == "Face")
        [image_stack, scriptV] = load_face_images('./photometrics_images/yaleB02/');
    else
        [image_stack, scriptV] = load_syn_images(image_dir(k));
    end
    
    [h, w, n] = size(image_stack);
    fprintf('Finish loading %d images.\n\n', n);   

    count = 1;
    for k = 5:n
        se_i = zeros([h,w,num_runs]);
        for idx = 1:num_runs
            %randomly selects k images
            rand_select = randperm(n, k);
            image_samples = image_stack(:,:, rand_select);
            scriptV_sample = scriptV(rand_select,:);

            % compute the surface gradient from the stack of imgs and light source mat
            disp('Computing surface albedo and normal map...')
            [albedo, normals] = estimate_alb_nrm(image_samples, scriptV_sample, false);

            %% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
            disp('Integrability checking')
            [p, q, se_i(:,:,idx)] = check_integrability(normals);
            waitbar(count/(n*num_runs*length(label)), w_bar); 
            count = count +1;
        end
        SE{k} = mean(se_i, 3);
        threshold = 0.005;
        SE{k}(SE{k} <= threshold) = NaN; % for good visualization
        total_SE(k) = sum(sum(SE{k} > threshold));
        fprintf('Number of outliers: %d\n\n', total_SE(k));
    end
    
    plt(k) = plot(total_SE/(h * w))
    hold on;
end

legend(label);
title('normalized number of SE outliers', 'FontSize', 10);
xlabel('Number of images (batch)', 'FontSize', 10);
ylabel('Number of outliers per pixel', 'FontSize', 10);
hold off;

close(w_bar)
%% compute the surface height
height_map = construct_surface( p, q );


%% Display
show_results(albedo, normals, SE{25});
show_model(albedo, height_map);