function [im2] = myPCADenoising1(im1, sig)
% tic;
% im1 = im2double(im1);
im2 = zeros(size(im1,1)); %Initialising

patch_len = 7;
img_len = size(im1, 1); % Assuming square image
N = (img_len - patch_len + 1)^2; % (256-7+1)^2 = 62500
P = zeros(patch_len^2, N); % 49 x 62500
index = 1;

% P is collection of all N patches

for j=1:(img_len-patch_len+1)
    for i=1:(img_len-patch_len+1)
        patch = im1(i:i+patch_len-1, j:j+patch_len-1);
        P(:,index) = patch(:); 
        % Iterates through entire row(i++)        
        index = index+1;
    end
    % And then goes to next row(j++)
end

L = P*P'; % 49 x 49
[W, ~] = eig(L); % W-Right eigenvectors of L: 49 x 49
alpha = W'*P; % Alpha coefficients of P: 49 x 62500
%{
alpha_ij notation:
i_th patch (meaning P_i)-horizontal iteration in 62500
j_th eigencoefficient-vertical iteration in 49
%}
avg_sq_alpha = zeros(patch_len^2, 1);
alpha_denoised = alpha;
for j=1:patch_len^2
    sq_sum = sum(alpha(j,:).^2);
    avg_sq_alpha(j) = max(0, sq_sum/N - sig^2);
    alpha_denoised(j,:) = alpha(j,:)./(1 + sig^2/avg_sq_alpha(j));
end

P_denoised = W*alpha_denoised; % 49 x 62500

index = 1;
freq_of_px = zeros(img_len);
for j=1:(img_len-patch_len+1)
    for i=1:(img_len-patch_len+1)
        patch = reshape(P_denoised(:, index),[patch_len patch_len]);
        im2(i:i+patch_len-1, j:j+patch_len-1) = im2(i:i+patch_len-1, j:j+patch_len-1) + patch;
        freq_of_px(i:i+patch_len-1, j:j+patch_len-1) = freq_of_px(i:i+patch_len-1, j:j+patch_len-1) + 1;
        % Iterates through entire row(i++)
        index = index+1;
    end
    % And then goes to next row(j++)
end
im2 = im2./freq_of_px;
% toc;
end

