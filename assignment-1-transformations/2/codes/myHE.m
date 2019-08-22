function [newImg] = myHE(img)
  imshow(img);
  pause(2);
  chan = size(img,3);
  newImg = double(img);
  for i=1:1:chan
    hist = imhist(img(:,:,i));
    bar(hist);
    pause(1);
    cdf = cumsum(hist)/sum(hist);
    newImg(:,:,i) = cdf(img(:,:,i) + 1);
  end
  imshow(newImg);
end