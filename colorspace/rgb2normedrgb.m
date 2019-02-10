function [output_image] = rgb2normedrgb(input_image)
% converts an RGB image into normalized rgb
[R, G, B] = imsplit(input_image);
sum = R + G + B;
r = R./sum;
g = G./sum;
b = B./sum;
output_image = cat(3, r, g, b);
end

