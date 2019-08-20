function [newImg] = myLinearContrastStretching(img)
  chan = size(img,3);
  newImg = img;
  for i=1:1:chan 
    minI = min(min(img(:,:,i)));
    maxI = max(max(img(:,:,i)));
    newImg(:,:,i) = (img(:,:,i) - minI) * ((255 - 0) / (maxI - minI));
  endfor;
endfunction;