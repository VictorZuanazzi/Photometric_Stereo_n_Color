im_albedo = imread('ball_albedo.png');
im_albedo=im2double(im_albedo);

im_shading= imread('ball_shading.png');
im_shading=im2double(im_shading);

im= imread('ball.png');
im=im2double(im);

% get unique values in first color component 
unique(im_albedo(:,:,1))
%  0
%  184 

% get unique values in 2nd color component 
unique(im_albedo(:,:,2))
%  0
%  141

% get unique values in 3rd color component 
unique(im_albedo(:,:,3))
%  0
%  108

% = > true color is (184,141,108)

% take 2nd component color component and replace values not equal zero with
% 255

tmp= im_albedo(:,:,2);
tmp(tmp~=0)=1;

% and overwrite colors of 2nd component in original matrix 
im_albedo(:,:,2)=tmp;

% replace 1st and 3rd color component with 0's
im_albedo(:,:,1)=0;
im_albedo(:,:,3)=0;

% figure(1);
% imshow(im_albedo);
% title('New colored albedo');

im_new_color(:,:,1)=im_albedo(:,:,1).*im_shading(:,:);
im_new_color(:,:,2)=im_albedo(:,:,2).*im_shading(:,:);
im_new_color(:,:,3)=im_albedo(:,:,3).*im_shading(:,:);

figure(2);
imshow(im_new_color);
title('New color image');

imwrite(im_new_color, 'ball_green.png'); % writes image data I to the file


