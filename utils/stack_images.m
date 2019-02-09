function [imageStack] = stack_images(imagesCell)
%Stacks up gray images on the third dimention.
%imagesCell: A Cell containg the images.
%imageStack: A stack (3 order matrix) of the images using the 3rd dimention
%as stacking index.

n = length(imagesCell);
[h, w] = size(imagesCell{1});
imageStack = zeros(h, w, n);

for i = 1:n
    imageStack(:,:,i) = imagesCell{i};
end
end

