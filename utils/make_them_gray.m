function [grayImages] = make_them_gray(colorImages)
%converts a stack of RGB images into a stack of gray images.
num_images =  length(colorImages);
for i = 1:num_images
    grayImages{i} = rgb2gray(im2double(colorImages{i}));
end
end

    