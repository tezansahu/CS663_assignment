function showImage(img, head, myNumOfColors)
  myColorScale = [ [0:1/(myNumOfColors-1):1]' ,[0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]'];
  cmap = colormap(myColorScale);
  colormap gray;
  imshow(img, cmap);
  daspect ([1 1 1]);
  axis on;
  colorbar;
  title(head);
end
