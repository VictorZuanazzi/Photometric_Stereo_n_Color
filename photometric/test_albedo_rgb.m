close all
clear all
clc
 
disp('Part 1: Photometric Stereo')

% obtain many images in a fixed view under different illumination
disp('Loading images...')
image_dir = './photometrics_images/MonkeyColor/';
%image_ext = '*.png';

% shadow trick
shadow_trick = false;

rbg_albedo = [];

for channel = 1:3 
    [image_stack, scriptV] = load_syn_images(image_dir, channel);
    [h, w, n] = size(image_stack);
    fprintf('Finish loading %d images.\n\n', n);


    % compute the surface gradient from the stack of imgs and light source mat
    disp('Computing surface albedo and normal map...')
    [albedo, normals] = estimate_alb_nrm(image_stack, scriptV, shadow_trick);
    
    rbg_albedo = cat(3, rbg_albedo,albedo);
end

%% Display
figure
imshow(rbg_albedo);
if shadow_trick
    title('Albedo with shadow trick');
else
    title('Albedo');
end
