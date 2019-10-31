%% Solution to A5 - Q4
clear;
close all;

tic;
%% Your code here
cd ../data;
Z = imread('barbara256.png');

figure(1); imshow(Z, [min(Z(:)) max(Z(:))]); 
title('Original Image');
pause(1);

Z = padarray(Z,[128 128],0);
FZ = fftshift(fft2(Z));
% lFZ = log(abs(FZ)+1);
% figure(2); imshow(lFZ, [min(lFZ(:)) max(lFZ(:))]); colormap('jet'); colorbar;
% title('Original Fourier Transform (Log Magnitude)');
% pause(1);

% Cutoff frequencies/Standard deviations
r = [40, 80];
H1 = zeros(512); % Ideal with cutoff=40
H2 = zeros(512); % Ideal with cutoff=80
H3 = zeros(512); % Gaussian with sd=40
H4 = zeros(512); % Gaussian with sd=80

center = size(H1,1)/2;
for i=1:size(H1,1)
    for j=1:size(H1,2)
        if ((i-center)^2+(j-center)^2) <= r(1)^2
            H1(i, j) = 1;
        end
        if ((i-center)^2+(j-center)^2) <= r(2)^2
            H2(i, j) = 1;
        end
        H3(i, j) = exp(-((i-center)^2+(j-center)^2)/(2*r(1)^2));
        H4(i, j) = exp(-((i-center)^2+(j-center)^2)/(2*r(2)^2));
    end
end

figure(3); 
subplot(2,2,1); imshow(H1, [min(H1(:)) max(H1(:))]); colormap('jet'); colorbar;
title('Ideal (r=40)');
subplot(2,2,2); imshow(H2, [min(H2(:)) max(H2(:))]); colormap('jet'); colorbar;
title('Ideal (r=80)');
subplot(2,2,3); imshow(H3, [min(H3(:)) max(H3(:))]); colormap('jet'); colorbar;
title('Gaussian (sd=40)');
subplot(2,2,4); imshow(H4, [min(H4(:)) max(H4(:))]); colormap('jet'); colorbar;
title('Gaussian (sd=80)');
pause(1.5);

figure(5);
new_FZ = FZ.*H1;
new_Z = ifft2(ifftshift(new_FZ));
final_img = new_Z(129:384, 129:384); % Removed padding
subplot(2,2,1); imshow(final_img, [ min(abs(final_img(:))) max(abs(final_img(:))) ]);
title('Ideal (r=40)');

new_FZ = FZ.*H2;
new_Z = ifft2(ifftshift(new_FZ));
final_img = new_Z(129:384, 129:384); % Removed padding
subplot(2,2,2); imshow(final_img, [ min(abs(final_img(:))) max(abs(final_img(:))) ]);
title('Ideal (r=80)');

new_FZ = FZ.*H3;
new_Z = ifft2(ifftshift(new_FZ));
final_img = new_Z(129:384, 129:384); % Removed padding
subplot(2,2,3); imshow(final_img, [ min(abs(final_img(:))) max(abs(final_img(:))) ]);
title('Gaussian (sd=40)');

new_FZ = FZ.*H4;
new_Z = ifft2(ifftshift(new_FZ));
final_img = new_Z(129:384, 129:384); % Removed padding
subplot(2,2,4); imshow(final_img, [ min(abs(final_img(:))) max(abs(final_img(:))) ]);
title('Gaussian (sd=80)');

toc;
