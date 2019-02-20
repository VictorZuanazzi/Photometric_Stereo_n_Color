function [corrected]= GrayWorld(filename)

im = imread(filename);

im=im2double(im);

figure(1);
imshow(im);
title('Original Image');

avg_dim1=mean(im(:,:,1),'all');

avg_dim2=mean(im(:,:,2),'all');

avg_dim3=mean(im(:,:,3),'all');

%128/255 = 0.5019607843

im_awb(:,:,1)=128/255.*im(:,:,1)/avg_dim1;
im_awb(:,:,2)=128/255.*im(:,:,2)/avg_dim2;
im_awb(:,:,3)=128/255.*im(:,:,3)/avg_dim3;

figure(2);
imshow(im_awb);
title('Gray World Corrected Image');

imwrite(im_awb,strcat('corrected_',filename));

end

