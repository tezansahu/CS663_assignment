function [newImg] = myAHE(img)
%MYCLAHE Summary of this function goes here
%   Detailed explanation goes here
windowsize = [4 4];
%   cliplevel = 3;
chan = size(img,3);
newImg = double(img);
for i=1:1:chan
    hist = imhist(img(:,:,i));
    cdf = cumsum(hist)/sum(hist);
    newImg(:,:,i) = cdf(img(:,:,i) + 1);
end
end