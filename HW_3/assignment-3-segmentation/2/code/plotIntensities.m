function plotIntensities(img)
    r = reshape(img(:,:,1), [1, size(img,1)*size(img,2)]);
    g = reshape(img(:,:,2), [1, size(img,1)*size(img,2)]);
    b = reshape(img(:,:,3), [1, size(img,1)*size(img,2)]);
    
    scatter3(r,g,b,'.');
    axis([0,1,0,1,0,1]);
    xlabel("Red");
    ylabel("Green");
    zlabel("Blue");
    
end