function smallImage = myShrinkImageByFactorD(img, d)
  smallImage = img(1:d:size(img,1), 1:d:size(img, 2));
end
