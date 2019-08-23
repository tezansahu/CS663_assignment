function [mask, masked_img] = myForegroundMask(img)
%MYFOREGROUNDMASK Binary mask for foreground region of image
%   Detailed explanation goes here
% imshow(img)
chan = size(img, 3);
mask = double(img);
masked_img = double(img);
for i=1:1:chan
    mask(:,:,i) = (img(:,:,i)>10)*255;
    % immultiply- multiplies each element in array X by the corresponding element in array Y
    masked_img(:,:,i) = immultiply((mask(:,:,i)~=0),img(:,:,i));
% imshow(masked_img);
end