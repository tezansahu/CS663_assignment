function [newImg] = myHE(img)
  chan = size(img,3);
  newImg = double(img);
  for i=1:1:chan 
    hist = imhist(img(:,:,i));
    cdf = cumsum(hist)/sum(hist);
    newImg(:,:,i) = cdf(img(:,:,i) + 1);
  endfor
endfunction