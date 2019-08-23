function [newImg] = myHM(img, imgMask, ref, refMask)
  num_chan = size(img, 3);
  newImg = zeros([size(img,1), size(img,2), size(img,3)]);
  for i=1:1:num_chan
    img_chan = img(:, :, i);
    ref_chan = ref(:, :, i);
    img_chan_hist = imhist(img_chan(imgMask ~= 0));
    img_chan_cdf = cumsum(img_chan_hist)/sum(img_chan_hist);
    ref_chan_hist = imhist(ref_chan(refMask ~= 0));
    ref_chan_cdf = cumsum(ref_chan_hist)/sum(ref_chan_hist);
    new_chan = interp1(ref_chan_cdf, [0:1:255], interp1([0:1:255], img_chan_cdf, double(img_chan)))/255;
    newImg(:, :, i) = new_chan;
  end
  newImg(imgMask == 0) = 0;
endfunction