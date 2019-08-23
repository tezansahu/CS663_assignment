function [mask, masked_img] = myForegroundMask(img, threshold)
% Assuming img has only 1 channel (since it is used only for image (7))
% chan = size(img, 3);
orig_img = img;
img(img < threshold) = 0;
img(img >= threshold) = 255;
mask = logical(medfilt2(medfilt2(img)));

% immultiply- multiplies each element in array X by the corresponding element in array Y
% masked_img(:,:,i) = immultiply((mask(:,:,i)~=0),img(:,:,i));
masked_img = mask .* orig_img;
% imshow(masked_img);
end