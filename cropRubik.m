function ff = cropRubik(dir, resize)
    img = imread(dir);
    img = im2double(img);
    hsv = rgb2hsv(img);
    hsv = imgaussfilt(hsv, 2);
    imr = hsv(:,:,2) > 0.17 & hsv(:,:,3) > 0.17;
    imf = bwconvhull(imr);
    cdat = regionprops(imf, 'BoundingBox');

    imcr = img.*repmat(imf, [1,1,3]);
    imcr = imcrop(imcr, cdat(1).BoundingBox);

    hsv = rgb2hsv(imcr);
    hsv(:,:,3) = hsv(:,:,3) > 0.3;
    hsv(:,:,2) = hsv(:,:,2) > 0.7;
    imcr = hsv2rgb(hsv);
    
    [imnd, map] = rgb2ind(imcr,12,'nodither');
    imnd = ind2rgb(imnd, map);
    
    stl = strel('disk', 8);
    erodedI = imerode(imnd, stl);
    
    erodedIgray = rgb2gray(erodedI);
    edgeI = edge(erodedIgray, 'Canny');
    
    ff = erodedI;
    %ff = imresize(erodedI, resize);
end