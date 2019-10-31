%% Solution to A5 - Q3
clear;
close all;

tic;
%% Your code here
cd ../data;
load("image_low_frequency_noise.mat");

figure(1); imshow(Z, [min(Z(:)) max(Z(:))]); 
title('Original Image');
pause(1);

Z = padarray(Z,[128 128],0);
FZ = fftshift(fft2(Z));
lFZ = log(abs(FZ)+1);
figure(2); imshow(lFZ, [min(lFZ(:)) max(lFZ(:))]); colormap('jet'); colorbar;
title('Original Fourier Transform (Log Magnitude)');
impixelinfo;
pause(1);

% Interfering frequencies
f1 = [237 247];
f2 = [278 267];
r = 10; % radius
H = ones(512);
% Constructing ideal notch reject filter
for i=1:size(H,1)
    for j=1:size(H,2)
        if ((f1(1)-i)^2+(f1(2)-j)^2) <= r^2
            H(i, j) = 0;
        end
        if ((f2(1)-i)^2+(f2(2)-j)^2) <= r^2
            H(i, j) = 0;
        end
    end
end
% H(f1(1)-r:f1(1)+r, f1(2)-r:f1(2)+r) = 0;
% H(f2(1)-r:f2(1)+r, f2(2)-r:f2(2)+r) = 0;

new_FZ = FZ.*H;
% figure(3); imshow(new_FZ, [min(abs(FZ(:))) max(abs(FZ(:)))]); colormap('jet'); colorbar;
new_lFZ = log(abs(new_FZ)+1);
figure(4); imshow(new_lFZ, [min(lFZ(:)) max(lFZ(:))]); colormap('jet'); colorbar;
title('Fourier Transform after applying Notch Filter');
pause(1);

new_Z = ifft2(ifftshift(new_FZ));
final_img = new_Z(129:384, 129:384); % Removed padding
figure(5); imshow(final_img, [ min(abs(final_img(:))) max(abs(final_img(:))) ]);
title('Restored Image');

toc;
