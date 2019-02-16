close all
clear all
clc
 
disp('Part 1: Photometric Stereo')

% obtain many images in a fixed view under different illumination
disp('Loading images...')
image_dir = './photometrics_images/SphereGray5/';
%image_ext = '*.png';

[image_stack, scriptV] = load_syn_images(image_dir);
[h, w, n] = size(image_stack);
fprintf('Finish loading %d images.\n\n', n);

% compute the surface gradient from the stack of imgs and light source mat

label = ["Sphere", "Face"];
sum_path = ["column", "row", "average"];
use_trick = [true, false];

for i = 1:length(label)
    for j = 1:length(sum_path)
        for k = 1:length(use_trick)
            if (label(i) == "Face")
                [image_stack, scriptV] = load_face_images('./photometrics_images/yaleB02/');
            else
                [image_stack, scriptV] = load_syn_images(image_dir);
            end
            [h, w, n] = size(image_stack);
            fprintf('Finish loading %d images.\n\n', n);

            disp('Computing surface albedo and normal map...')
            [albedo, normals] = estimate_alb_nrm(image_stack, scriptV, use_trick(k));

            %% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
            disp('Integrability checking')
            [p, q, SE] = check_integrability(normals);

            %% compute the surface height
            height_map = construct_surface( p, q, sum_path(j));

            name = label(i) + "_" + sum_path(j) + "_" + use_trick(k) + ".png";
            show_and_save_model(albedo, height_map, name);

        end
    end
end


