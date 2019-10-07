function filtered_img = myPatchBasedFiltering(img, sigma_i)
    filtered_img = double(zeros(size(img,1), size(img,2)));
    window = 25;
    patch_size = 9; 
    
    pad_size = floor(window/2) + floor(patch_size/2);
    
    % Use Neumann Boundary Condition for padding around the image
    img_padded = padarray(img, [pad_size, pad_size], 'replicate');
    wait = waitbar(0, "Patch-Based Filtering in Progress");
    
    % define the gaussian mask to make patches isotropic
    sigma = 4/3;
    [x,y] = meshgrid(-floor(patch_size/2):floor(patch_size/2), -floor(patch_size/2):floor(patch_size/2));
    G_p = exp(-(x.^2 + y.^2)/(2*sigma^2));
    
    % Pass over the image
    for i = 1+pad_size:size(img,1)+pad_size
        % disp(i);
        % max & min used to account for edge pixels
        i_min = max(i - floor(window/2), 1);    
        i_max = min(i + floor(window/2), size(img_padded,1));
        
        for j = 1+pad_size:size(img,2)+pad_size

            % max & min used to account for edge pixels
            j_min = max(j - floor(window/2), 1);
            j_max = min(j + floor(window/2), size(img_padded,2));
            % disp(strcat("Window: i=", num2str(i), ", j=", num2str(j)))
            
            filtered_img(i - pad_size,j - pad_size) = getPatchBasedIntensity(img_padded, [i_min, i_max, j_min, j_max], G_p, sigma_i, patch_size);
            
        end
        waitbar(i/size(img,1));
    end
    close(wait);
end


function pixel_intensity = getPatchBasedIntensity(img_padded, window_limits, G_p, sigma_i, patch_size)
    center_indices = [(window_limits(1)+window_limits(2))/2, (window_limits(3)+window_limits(4))/2];
    
    curr_patch_i_min = max(center_indices(1) - floor(patch_size/2), 1);
    curr_patch_i_max = min(center_indices(1) + floor(patch_size/2), size(img_padded,1));
    curr_patch_j_min = max(center_indices(2) - floor(patch_size/2), 1);
    curr_patch_j_max = min(center_indices(2) + floor(patch_size/2), size(img_padded,2));
    curr_patch = img_padded(curr_patch_i_min:curr_patch_i_max, curr_patch_j_min:curr_patch_j_max);
    curr_patch = curr_patch .* G_p;
    
    weights = zeros([window_limits(2) - window_limits(1) + 1, window_limits(4) - window_limits(3) + 1]);
    % disp(strcat("Weights size:", num2str(size(weights,1)), " * ", num2str(size(weights,2))));
    
    for p_i = window_limits(1):1:window_limits(2)
        patch_i_min = max(p_i - floor(patch_size/2), 1);    
        patch_i_max = min(p_i + floor(patch_size/2), size(img_padded,1));
        
        for p_j = window_limits(3):1:window_limits(4)
            patch_j_min = max(p_j - floor(patch_size/2), 1);    
            patch_j_max = min(p_j + floor(patch_size/2), size(img_padded,2));
            
            patch = img_padded(patch_i_min:patch_i_max, patch_j_min:patch_j_max);
            patch = patch .* G_p; 
            
            % Compute weight of a patch for the center pixel
            weights(p_i - window_limits(1) + 1, p_j - window_limits(3) + 1) = exp(-sum(sum((curr_patch - patch) .^ 2))/sigma_i^2);
            % disp(strcat("Patch: i=", num2str(p_i), ", j=", num2str(p_j)));
        end
    end
  
    % Compute actual intensity of center pixel of the window using weights
    % of patches
    pixel_intensity = sum(sum(weights .* img_padded(window_limits(1):window_limits(2), window_limits(3):window_limits(4))))/sum(sum(weights));
end