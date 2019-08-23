function [newImg] = myLinearContrastStretching(img, mask)
  %% For all images except (7), the mask is an all ones matrix of the same size as img
  chan = size(img,3);
  newImg = img;
  for i=1:1:chan 
    img_chan = img(:,:,i);
    minI = min(min(img_chan(mask ==1)));
    maxI = max(max(img_chan(mask ==1)));
    newImg(:,:,i) = mask .* (img_chan - minI) * ((255 - 0) / (maxI - minI));
  end
endfunction;