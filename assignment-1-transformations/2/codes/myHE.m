function [newImg] = myHE(img, mask)
  %% For all images except (7), the mask is an all ones matrix of the same size as img
  %% imshow(img);
  pause(2);
  chan = size(img,3);
  newImg = double(img);
  for i=1:1:chan
    img_chan = img(:,:,i);
    hist = imhist(img_chan(mask ==1));
    pause(1);
    cdf = cumsum(hist)/sum(hist);
    newImg(:,:,i) = mask .* cdf(img(:,:,i) + 1);
    % newImg_chan = newImg(:,:,i);
    % hist2 = imhist(newImg_chan(mask == 1));
    % subplot(1,2,1), bar(hist);
    % subplot(1,2,2), bar(hist2);
    % pause(1);
  end
  imshow(newImg);
end