function noisy_img = corruptImgGaussian(img)
    % Assumes img to be in 'double' form, with range 0-1
    sigma = 0.05 * (max(max(img)) - min(min(img)));
    noise = normrnd(0, sigma, [size(img, 1), size(img, 2)]);
    noisy_img = img + noise;
end