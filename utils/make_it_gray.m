function [grayImage] = make_it_gray(collorfulImage)
% converts RGB image to grayscale.
grayImage = rgb2gray(im2double(collorfulImage));
end