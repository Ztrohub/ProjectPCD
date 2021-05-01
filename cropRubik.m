function ff = cropRubik(dir, resize)
    img = imread(dir);
    img = im2double(img);
    hsv = rgb2hsv(img);
    hsv = imgaussfilt(hsv, 5);
    imr = hsv(:,:,2) > 0.17 & hsv(:,:,3) > 0.17;
    imf = bwconvhull(imr);
    cdat = regionprops(imf, 'BoundingBox');

    imcr = img.*repmat(imf, [1,1,3]);
    imcr = imcrop(imcr, cdat(1).BoundingBox);
    
    %imcr = histeq(imcr);
    hsv = rgb2hsv(imcr);
    hsv(:,:,2) = hsv(:,:,2) * 1.2;
    hsv(:,:,3) = hsv(:,:,3) > 0.3;
    for i=1:size(hsv,1)
        for j=1:size(hsv,2)
            if (hsv(i,j,1) < 0.05 | hsv(i,j,1) > 0.95) & hsv(i,j,3) > 0.5
                hsv(i,j,2) = hsv(i,j,2) * 2;
                hsv(i,j,3) = 1;
            end
        end
    end
    imcr = hsv2rgb(hsv);
    ff = imcr;
    
    [imnd, map] = rgb2ind(imcr,16,'nodither');
    imnd = ind2rgb(imnd, map);
    
    stl = strel('disk', 8);
    erodedI = imerode(imnd, stl);
    
    erodedIgray = rgb2gray(erodedI);
    edgeI = edge(erodedIgray, 'Canny');
    
    %ff = erodedI;
    
    %ff = imresize(erodedI, resize);
end