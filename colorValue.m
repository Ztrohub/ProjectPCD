function color = colorValue(rubik)
    color = 0;
    [x, y] = size(rubik);
    
    edgeI = edge(rgb2gray(rubik), 'Canny');
    corners = detectFASTFeatures(edgeI);
    figure;imshow(edgeI);
    
end