function [newImg] = myHE(img, mask)
  %% For all images except (7), the mask is an all ones matrix of the same size as img
%   imshow(img);
%   pause(2);
  img = uint8(img);
  chan = size(img,3);
  newImg = img;
  for i=1:1:chan
    img_chan = img(:,:,i);
    hist = imhist(img_chan(mask ==1));
    cdf = round(cumsum(hist)/sum(hist)*256);
    newImg(:,:,i) = mask .* cdf(img(:,:,i) + 1);
  end
%   imshow(newImg);
end