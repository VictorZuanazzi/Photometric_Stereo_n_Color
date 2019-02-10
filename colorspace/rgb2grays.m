function [output_image] = rgb2grays(input_image)
% converts an RGB into grayscale by using 4 different methods
[R, G, B] = imsplit(input_image);

% lightness method
g1 = (max(input_image,[],3) + min(input_image,[],3))/2;

% average method
g2 = (R + G + B)/3;

% luminosity method
g3 = 0.21*R + 0.72*G + 0.07*B;

% built-in MATLAB function 
g4 = rgb2gray(input_image);

% stack all 4 grayscales together
output_image = cat(4, g1, g2, g3, g4);
end

