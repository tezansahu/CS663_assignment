function [im_denoised] = myPCADenoising2(im1, sig)
% tic;
group_len = 31;
padoffset = (group_len-1)/2;
im1 = padarray(im1, [padoffset padoffset]); % 31 x 31 neighbourhood centred at top left corner of patch
im2 = zeros(size(im1,1)); %Initialising

patch_len = 7;
img_len = size(im1, 1); % Assuming square image

freq_of_px = zeros(img_len); % To average out repetitions

wait = waitbar(0, "PCA Denoising in progress");
for j=(padoffset+1):(img_len-patch_len+1)-padoffset
%     tic;
    for i=(padoffset+1):(img_len-patch_len+1)-padoffset
        % (i,j) is the top left corner of desired patch
        N_group = (group_len - patch_len + 1)^2; % (31-7+1)^2 = 625
        P_group = zeros(patch_len^2, N_group); % 49 x 625

        mse_group = zeros(1,N_group);
        K = 200; % Number of patches after filtering
        % Q = zeros(patch_len^2, K); % Stores patches after filtering mse
        index_group = 1;
        patch = im1(i:i+patch_len-1, j:j+patch_len-1);
        % The lower two nested loops are constant time, so time complexity
        % is still of 2nd order
%         tic;
        for j_group=j-padoffset:j+padoffset
            for i_group=i-padoffset:i+padoffset
                patch_group = im1(i_group:i_group+patch_len-1, j_group:j_group+patch_len-1);
                P_group(:,index_group) = patch_group(:);
%                 mse_group(index_group) = immse(patch, patch_group);
                mse_group(index_group) = sum(sum((patch-patch_group).^2));
                index_group = index_group+1;
            end
        end
%         toc;
%         tic;
        [~,I] = sort(mse_group); % I-stores index of ascending sort
        Q = P_group(:, I(1:200)); % 49 x 200, first column is the original patch P_i
        
        L = Q*Q'; % 49 x 49
        [W, ~] = eig(L); % W-Right eigenvectors of L: 49 x 49
        alpha = W'*Q; % Alpha coefficients of P: 49 x 200, first column should correspond to P_i
        %{
        alpha_ij notation:
        i_th patch (meaning P_i)-horizontal iteration in 200
        j_th eigencoefficient-vertical iteration in 49 (=row variable)
        %}
        avg_sq_alpha = zeros(patch_len^2, 1);
        alpha_denoised = alpha(:,1);
        for row=1:patch_len^2
            sq_sum = sum(alpha(row,:).^2);
            avg_sq_alpha(row) = max(0, sq_sum/K - sig^2);
            alpha_denoised(row,1) = alpha(row,1)./(1 + sig^2/avg_sq_alpha(row));
        end
%         toc;
%         tic;
        im2(i:i+patch_len-1, j:j+patch_len-1) = im2(i:i+patch_len-1, j:j+patch_len-1) + reshape(W*alpha_denoised, [patch_len patch_len]); % 49 x 1
        freq_of_px(i:i+patch_len-1, j:j+patch_len-1) = freq_of_px(i:i+patch_len-1, j:j+patch_len-1) + 1;
        
        waitbar(double(j*(img_len-patch_len+1)+i)/double((img_len-patch_len+1)^2));
%         toc;
        % Iterates through entire row(i++)
    end
%     toc; (Takes around 1.4 sec)
    % Goes to next row(j++)
end
im2 = im2./freq_of_px;
im_denoised = im2(padoffset+1:img_len-padoffset,padoffset+1:img_len-padoffset);
close(wait);

% toc; % 341 sec for barbara 256 x 256; 83 sec for barbara 128 x 128
end