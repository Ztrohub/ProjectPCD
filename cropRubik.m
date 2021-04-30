function ff = cropRubik(dir, resize)
    rubik = imread(dir);
    rubik = im2double(rubik);
    
    rubikgray = rgb2gray(rubik);
    rubikgray = fftshift(fft2(rubikgray));

    [x, y] = size(rubikgray);
    [X, Y] = meshgrid(1:x,1:y);
    Min = min(x, y) / 3;
    mesh = transpose((X - x/2).^2 + (Y - y/2).^2 < Min^2);
    rubikgray = rubikgray .* mesh;

    filtered = abs(ifft2(fftshift(rubikgray)));

    bw = imbinarize(filtered, 0.18);
    bw = 1 - bw;
    figure;imshow(bw);

    CC = bwconncomp(bw);
    cData = regionprops(CC, 'BoundingBox');

    ff = imcrop(rubik, cData(1).BoundingBox);
    ff = imresize(ff, resize);
end