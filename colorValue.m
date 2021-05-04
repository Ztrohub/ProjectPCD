function color = colorValue(rubik)
    color = 0;
    imgray = rgb2gray(rubik);
    BW = imbinarize(imgray, 0.01);
    [x, y] = size(BW);
    patt = imread('pattern/patt1.jpg');
    
    c = normxcorr2(patt, BW);
%     figure;surf(c);
%     shading flat;
    
    flattenedC = reshape(c.',1,[]);
    %get 0.4% percentile from maximum values
    lim = prctile(flattenedC, 99.6);
    
    cuttedC = zeros(size(BW));
    for i=1:x
        for j=1:y
            cuttedC(i,j) = c(size(patt,1)/2 + i,size(patt,2)/2 + j) > lim;
        end
    end
    
    stl = strel('disk', 8);
    cuttedC = imdilate(cuttedC, stl);
    stl = strel('disk', 7);
    cuttedC = imerode(cuttedC, stl);
    
    CC = bwconncomp(cuttedC);
    stats = regionprops(CC, 'centroid');
    pts = cat(1, stats.Centroid);
    
    left2 = pts(1,:);
    right2 = pts(1,:);
    bottom2 = pts(1,:);
    for i=2:size(pts, 1)
        if left2(1) > pts(i,1)
            left2 = pts(i,:);
        end
        if right2(1) < pts(i,1)
            right2 = pts(i,:);
        end
        if bottom2(2) < pts(i,2)
            bottom2 = pts(i,:);
        end
    end
    
    idx = 1;
    while idx <= size(pts, 1)
        if isequal(pts(idx,:), left2) || isequal(pts(idx,:), right2) || isequal(pts(idx,:), bottom2)
            pts(idx,:) = [];
        else
            idx = idx + 1;
        end
    end
    
    left1 = pts(1,:);
    right1 = pts(1,:);
    bottom1 = pts(1,:);
    for i=2:size(pts, 1)
        if left1(1) > pts(i,1)
            left1 = pts(i,:);
        end
        if right1(1) < pts(i,1)
            right1 = pts(i,:);
        end
        if bottom1(2) < pts(i,2)
            bottom1 = pts(i,:);
        end
    end
    
    idx = 1;
    while idx <= size(pts, 1)
        if isequal(pts(idx,:), left1) || isequal(pts(idx,:), right1) || isequal(pts(idx,:), bottom1)
            pts(idx,:) = [];
        else
            idx = idx + 1;
        end
    end
    
    middleC = pts(1,:);
    
    %right most
    v1 = sqrt(sum((left1 - middleC).^2));
    v2 = sqrt(sum((left2 - left1).^2));
    v3 = v2^2 / v1;
    left3 = (left2 .* (v3 + v2 + v1) - middleC .* v3) ./ (v2 + v1);
    left3(1) = max(min(left3(1), x), 1);
    left3(2) = max(min(left3(2), y), 1);
    
    %left most
    v1 = sqrt(sum((right1 - middleC).^2));
    v2 = sqrt(sum((right2 - right1).^2));
    v3 = v2^2 / v1;
    right3 = (right2 .* (v3 + v2 + v1) - middleC .* v3) ./ (v2 + v1);
    right3(1) = max(min(right3(1), x), 1);
    right3(2) = max(min(right3(2), y), 1);
    
    %bottom most
    v1 = sqrt(sum((bottom1 - middleC).^2));
    v2 = sqrt(sum((bottom2 - bottom1).^2));
    v3 = v2^2 / v1;
    bottom3 = (bottom2 .* (v3 + v2 + v1) - middleC .* v3) ./ (v2 + v1);
    bottom3(1) = max(min(bottom3(1), x), 1);
    bottom3(2) = max(min(bottom3(2), y), 1);
    
    %top point
    midLR = (right3 + left3) / 2;
    LRcor = midLR .* 2 - middleC;
    LRcor(1) = max(min(LRcor(1), x), 1);
    LRcor(2) = max(min(LRcor(2), y), 1);
    
    %bottom left point and bottom right point
    LBcor = left3 - middleC + bottom3;
    LBcor(1) = max(min(LBcor(1), x), 1);
    LBcor(2) = max(min(LBcor(2), y), 1);
    RBcor = right3 - middleC + bottom3;
    RBcor(1) = max(min(RBcor(1), x), 1);
    RBcor(2) = max(min(RBcor(2), y), 1);
    
    figure;imshow(rubik);hold on;
    line([LRcor(1) left3(1)], [LRcor(2) left3(2)]);
    line([LRcor(1) right3(1)], [LRcor(2) right3(2)]);
    line([middleC(1) left3(1)], [middleC(2) left3(2)]);
    line([middleC(1) right3(1)], [middleC(2) right3(2)]);
    line([middleC(1) bottom3(1)], [middleC(2) bottom3(2)]);
    line([RBcor(1) right3(1)], [RBcor(2) right3(2)]);
    line([RBcor(1) bottom3(1)], [RBcor(2) bottom3(2)]);
    line([LBcor(1) left3(1)], [LBcor(2) left3(2)]);
    line([LBcor(1) bottom3(1)], [LBcor(2) bottom3(2)]);
    
    %mask side by side
    maskTop = zeros([x, y]);
    maskTop(round(LRcor(2)), round(LRcor(1))) = 1;
    maskTop(round(left3(2)), round(left3(1))) = 1;
    maskTop(round(right3(2)), round(right3(1))) = 1;
    maskTop(round(middleC(2)), round(middleC(1))) = 1;
    maskTop = bwconvhull(maskTop);
    maskLeft = zeros([x, y]);
    maskLeft(round(LBcor(2)), round(LBcor(1))) = 1;
    maskLeft(round(left3(2)), round(left3(1))) = 1;
    maskLeft(round(bottom3(2)), round(bottom3(1))) = 1;
    maskLeft(round(middleC(2)), round(middleC(1))) = 1;
    maskLeft = bwconvhull(maskLeft);
    maskRight = zeros([x, y]);
    maskRight(round(RBcor(2)), round(RBcor(1))) = 1;
    maskRight(round(bottom3(2)), round(bottom3(1))) = 1;
    maskRight(round(right3(2)), round(right3(1))) = 1;
    maskRight(round(middleC(2)), round(middleC(1))) = 1;
    maskRight = bwconvhull(maskRight);
    
    Top = rubik .* repmat(maskTop, [1,1,3]);
    Left = rubik .* repmat(maskLeft, [1,1,3]);
    Right = rubik .* repmat(maskRight, [1,1,3]);
    
    %image projection
    %left
    mattL1 = [
        LBcor(1) bottom3(1) middleC(1);
        LBcor(2) bottom3(2) middleC(2);
        1 1 1
        ];
    mattL2 = [
        0 x x;
        y y 0;
        1 1 1
        ];
    mattrix = mattL2 / mattL1;
    tform = affine2d(mattrix');
    Left = imwarp(Left, tform);
    
    
    
    %work done
    figure;
    subplot(1,3,1);imshow(Top);
    subplot(1,3,2);imshow(Left);
    subplot(1,3,3);imshow(Right);
end