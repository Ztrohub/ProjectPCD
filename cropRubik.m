function ff = cropRubik(dir, resize)
    tempSize = [512 512];

    img = imread(dir);
    img = im2double(img);
    hsv = rgb2hsv(img);
    
    hsv(:,:,2) = medfilt2(hsv(:,:,2), [10, 10]);
    imr = hsv(:,:,2) > 0.17 & hsv(:,:,3) > 0.1;
    stl = strel('disk', 8);
    imr = imerode(imr, stl);
    imf = bwconvhull(imr);
    cdat = regionprops(imf, 'BoundingBox');
    
    imcr = img.*repmat(imf, [1,1,3]);
    imcr = imcrop(imcr, cdat(1).BoundingBox);
    imcr = imresize(imcr, tempSize);
    
    %ff = imr;
    
    hsv = rgb2hsv(imcr);
    orangeSelect = hsv(:,:,1) > 0.01 & hsv(:,:,1) < 0.1 & hsv(:,:,2) > 0.4 & hsv(:,:,3) > 0.4;
    orangeSelect = medfilt2(orangeSelect, [10 10]);
    
    %imcr = histeq(imcr);
    hsv = rgb2hsv(imcr);
    hsv(hsv < 0) = 0;
    %figure;imshow(imcr);
    hsv(:,:,2) = hsv(:,:,2) * 1.1;
    hsv(hsv > 1) = 0.5;
    hsv(:,:,3) = hsv(:,:,3) > 0.3;
    for i=1:tempSize(1)
        for j=1:tempSize(2)
            if (hsv(i,j,1) < 0.1 | hsv(i,j,1) > 0.9) & hsv(i,j,3) > 0.2
                hsv(i,j,2) = 1;
                hsv(i,j,3) = 1;
            end
        end
    end
    imcr = hsv2rgb(hsv);
    %ff = imcr;
    
    [imnd, map] = rgb2ind(imcr,7,'nodither');
    imnd = ind2rgb(imnd, map);
    
    stl = strel('disk', 8);
    %dilI = imdilate(imnd, stl);
    erodedI = imerode(imnd, stl);
    
    hsvErodedI = rgb2hsv(erodedI);
    for i=1:tempSize(1)
        for j=1:tempSize(2)
            if orangeSelect(i,j) > 0.5 & hsvErodedI(i,j,3) > 0.1
                hsvErodedI(i,j,1) = 0.1;
            end
            if hsvErodedI(i,j,2) < 0.3
                hsvErodedI(i,j,2) = 0;
            elseif hsvErodedI(i,j,1) > 0.11 & hsvErodedI(i,j,1) < 0.7
                hsvErodedI(i,j,2) = 1;
            end
        end
    end
    erodedI = hsv2rgb(hsvErodedI);
    
    ff = erodedI;
    
    %ff = imresize(erodedI, resize);
end