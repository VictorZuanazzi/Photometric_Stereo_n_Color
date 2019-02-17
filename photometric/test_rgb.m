close all
clear all
clc
 
disp('Part 1: Photometric Stereo')

% obtain many images in a fixed view under different illumination
disp('Loading images...')
image_dir = './photometrics_images/SphereColor/';
%image_ext = '*.png';

% shadow trick
shadow_trick = false;

stacks = [];
scriptV = [];

for channel = 1:3 
    [image_stack, scriptV] = load_syn_images(image_dir, channel);
    stacks = cat(4, stacks, image_stack);
end 

[h, w, n] = size(image_stack);
fprintf('Finish loading %d images.\n\n', n);

    
rgb_albedo = [];
rgb_normals = [];
for channel = 1:3 
    image_stack = stacks(:,:,:,channel);

    % compute the surface gradient from the stack of imgs and light source mat
    disp('Computing surface albedo and normal map...')
    [albedo, ~] = estimate_alb_nrm(image_stack, scriptV, shadow_trick);
    
    rgb_albedo = cat(3, rgb_albedo,albedo);
end

stacks(isnan(stacks)) = 0;
grayScale = 0.2989 * stacks(:,:,:,1) + 0.5870 * stacks(:,:,:,2) + 0.1140 * stacks(:,:,:,3);
[~, normals] = estimate_alb_nrm(grayScale, scriptV, shadow_trick);

%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
disp('Integrability checking')
[p, q, SE] = check_integrability(normals);

threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));

%% compute the surface height
height_map = construct_surface( p, q );

% show_results(rgb_albedo(:,:,1), rgb_normals(:,:,:,1), SE);
% show_results(rgb_albedo(:,:,2), rgb_normals(:,:,:,2), SE);
% show_results(rgb_albedo(:,:,3), rgb_normals(:,:,:,3), SE);
show_results(rgb_albedo, normals, SE);
show_model(rgb_albedo, height_map);
