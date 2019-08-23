function [newImg] = myCLAHE(img, cliplimit, windowsize)
%MYCLAHE Summary of this function goes here
%   Detailed explanation goes here

% imshow(img);
% pause(1);

newImg = double(img);
x = img(:,:,1);
fun = @(x) centerInt(x,cliplimit);
newImg(:,:,1) = nlfilter(x, windowsize, fun);

% subplot(1,2,1)
% imshow(newImg);
% subplot(1,2,2)
% imshow(adapthisteq(img));
end

function intensity = centerInt(img, cliplimit)
    clipped = 0;
    newImg = double(img);
    chan = size(img,3);
    for i=1:1:chan
        hist = imhist(img(:,:,i));
        for intensity=1:length(hist)
            if hist(intensity) > cliplimit
                clipped = clipped + hist(intensity) - cliplimit;
                hist(intensity) = cliplimit;
            end
        end
        redist = clipped/length(hist);
        for intensity=1:length(hist)
            hist(intensity) = hist(intensity) + redist;
        end
        cdf = cumsum(hist)/sum(hist);
        newImg(:,:,i) = cdf(img(:,:,i) + 1);
    end
    intensity = newImg(round(size(img, 1)/2+.5), 1); % intensity at center pixel of window
end