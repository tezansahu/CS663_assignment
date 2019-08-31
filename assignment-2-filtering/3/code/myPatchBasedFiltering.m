function filtered_img = myPatchBasedFiltering(img, sigma_i)
    filtered_img = double(zeros(size(img,1), size(img,2)));
    % disp(filtered_img);
    window = 25;
    patch_size = 9; 
    wait = waitbar(0, "Patch-Based Filtering in Progress");
    
    % define the gaussian mask to make patches isotropic
    sigma = 0.5;
    [x,y] = meshgrid(-floor(patch_size/2):floor(patch_size/2), -floor(patch_size/2):floor(patch_size/2));
    G_p = exp(-(x.^2 + y.^2)/(2*sigma^2));
    
    % define the spatial gaussian mask to be used on the window
    sigma_s = 0.5;
    [x,y] = meshgrid(-floor(window/2):floor(window/2), -floor(window/2):floor(window/2));
    G_s = exp(-(x.^2 + y.^2)/(2*sigma_s^2));
    
    % Pass over the image
    for i = 1:size(img,1)
        % disp(i);
        % max & min used to account for edge pixels
        % i_min = max(i - floor(window/2), 1);    
        % i_max = min(i + floor(window/2), size(img,1));
        
        % select row indices to form window around the chosen pixel
        % (implementing wraparound)
        rows = mod((i - floor(window/2) - 1):(i + floor(window/2) - 1), size(img,1)) + 1;
        
        for j = 1:size(img,2)

            % max & min used to account for edge pixels
            % j_min = max(j - floor(window/2), 1);
            % j_max = min(j + floor(window/2), size(img,2));
            % disp(strcat("Window: i=", num2str(i), ", j=", num2str(j)))
            
            % select column indices to form window around the chosen pixel
            % (implementing wraparound)
            cols = mod((j - floor(window/2) - 1):(j + floor(window/2) - 1), size(img,2)) + 1;
            % disp(rows);
            % disp(cols);
            % disp(size(img(rows, cols)));
            % imshow(img(rows, cols));
            
            filtered_img(i,j) = getPatchBasedIntensity(img(rows, cols), G_p, G_s, sigma_i, patch_size);
            
        end
        waitbar(i/size(img,1));
    end
    close(wait);
end


function pixel_intensity = getPatchBasedIntensity(window, G_p, G_s, sigma_i, patch_size)
    % curr_patch_i_min = max(i - floor(patch_size/2), 1);
    % curr_patch_i_max = min(i + floor(patch_size/2), window_lims(2));
    % curr_patch_j_min = max(j - floor(patch_size/2), 1);
    % curr_patch_j_max = min(j + floor(patch_size/2), window_lims(4));
    % curr_patch = img(curr_patch_i_min:curr_patch_i_max, curr_patch_j_min:curr_patch_j_max);
    % curr_patch_vector = reshape(curr_patch, [1, (curr_patch_i_max - curr_patch_i_min) * (curr_patch_j_max - curr_patch_j_min)]);
    
    window_size = size(window,1);
    weights = zeros([window_size, window_size]);
    % disp(strcat("Weights size:", num2str(size(weights,1)), " * ", num2str(size(weights,2))));
    
    % Get patch around center pixel & convert it into vector
    curr_patch_rows = mod((ceil(window_size/2) - floor(patch_size/2) - 1): (ceil(window_size/2) + floor(patch_size/2) - 1), window_size);
    curr_patch_cols = mod((ceil(window_size/2) - floor(patch_size/2) - 1): (ceil(window_size/2) + floor(patch_size/2) - 1), window_size);
    curr_patch = window(curr_patch_rows, curr_patch_cols);
    % Use the mask to make patches isotropic
    curr_patch_vec = reshape(curr_patch, [1, patch_size^2]);
    
    for p_i = 1:1:window_size
        % patch_i_min = max(p_i - floor(patch_size/2), 1);    
        % patch_i_max = min(p_i + floor(patch_size/2), window_lims(2));
        
        % select row indices to form patch around the chosen pixel in the
        % window (implementing wraparound)
        patch_rows = mod((p_i - floor(patch_size/2) - 1):(p_i + floor(patch_size/2) - 1), window_size) + 1;
        for p_j = 1:1:window_size
            % select column indices to form patch around the chosen pixel in the
            % window (implementing wraparound)
            patch_cols = mod((p_i - floor(patch_size/2) - 1):(p_i + floor(patch_size/2) - 1), window_size) + 1; 
            patch = window(patch_rows, patch_cols);
            % Use the mask to make patch isotropic
            patch_vec = reshape(patch, [1, patch_size^2]);
            
            % Compute weight of a patch for the center pixel
            weights(p_i,p_j) = G_s(p_i, p_j) * exp(-sum((curr_patch_vec - patch_vec) .^ 2)/sigma_i^2);
            % disp(strcat("Patch: i=", num2str(p_i), ", j=", num2str(p_j)));
        end
    end
    % disp(size(weights));
    % disp(size(window)); 
    
    % Compute actual intensity of center pixel of the window using weights
    % of patches
    pixel_intensity = sum(sum(weights .* window))/sum(sum(weights));
end