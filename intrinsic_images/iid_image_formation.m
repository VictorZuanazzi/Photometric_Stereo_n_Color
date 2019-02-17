im_albedo = imread('ball_albedo.png');
im_albedo=im2double(im_albedo);

im_shading= imread('ball_shading.png');
im_shading=im2double(im_shading);

im= imread('ball.png');
im=im2double(im);

figure(1);
imshow(im_albedo);
title('Albedo image');

figure(2);
imshow(im_shading);
title('Shading image');

figure(3);
imshow(im);
title('Original image');

im_reconstr(:,:,1)=im_albedo(:,:,1).*im_shading(:,:);
im_reconstr(:,:,2)=im_albedo(:,:,2).*im_shading(:,:);
im_reconstr(:,:,3)=im_albedo(:,:,3).*im_shading(:,:);

figure(4);
imshow(im_reconstr)
title('Reconstructed image');

imwrite(im_reconstr, 'ball_reconstructed.png'); 
