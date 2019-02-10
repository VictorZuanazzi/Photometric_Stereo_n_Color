function [output_image] = rgb2opponent(input_image)
% converts an RGB image into opponent color space
[R, G , B] = imsplit(input_image);
O1 = (R - G)/sqrt(2);
O2 = (R + G - 2*B)/sqrt(6);
O3 = (R+G+B)/sqrt(3);
output_image = cat(3, O1, O2, O3);
end

