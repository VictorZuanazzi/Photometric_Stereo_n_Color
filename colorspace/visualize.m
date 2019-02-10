function visualize(input_image)
% makes a 2x2 montage of the image along with its channels or
% the 4 different types of grayscale
if size(input_image,3)==3
    [c1, c2, c3] = imsplit(input_image); 
    montage({input_image, c1, c2, c3})
else
    g1 = input_image(:,:,1);
    g2 = input_image(:,:,2);
    g3 = input_image(:,:,3);
    g4 = input_image(:,:,4); 
    montage({g1, g2, g3, g4})
end

