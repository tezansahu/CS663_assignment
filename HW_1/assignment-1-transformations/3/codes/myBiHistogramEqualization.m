function [newImg] = myBiHistogramEqualization(img)
  img_flat = reshape(img, 1, []);
  med = double(median(img_flat));
  
  img_low_elim = img > med;
  img_high_elim = img <= med;
  
  img_low = img;
  img_low(img_low_elim)=0;
  img_high = img;
  img_high(img_high_elim)=0;
  
  [~, lowMap] = histeq(img_low,med);
  [~, highMap] = histeq(img_high,256-med);
  lookupTable = uint8([med*lowMap(1:med), 256*highMap(med+1:end)]);
  newImg = intlut(img, lookupTable);