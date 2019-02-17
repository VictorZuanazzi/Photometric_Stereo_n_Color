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

% shadow trick
shadow_trick = false;
% number of images taked
k = 15;
if k ~= n
    rand_select = randperm(n, k);
    image_stack = image_stack(:,:,rand_select);
    scriptV = scriptV(rand_select,:);
end

% compute the surface gradient from the stack of imgs and light source mat
disp('Computing surface albedo and normal map...')
[albedo, normals] = estimate_alb_nrm(image_stack, scriptV, shadow_trick);

%% Display
figure
imshow(albedo);
if shadow_trick
    title(sprintf('Albedo %d images with shadow trick', k));
else
    title(sprintf('Albedo %d images', k));
end
