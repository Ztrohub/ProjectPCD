dir = 'Gambar/V1/(3).jpg';
img = imread(dir);
croppedImg = cropRubik(img, [240 240]);
[imgLines, corrValue, projectedImg, projectedColor, rebuildColor]...
        = colorValue(croppedImg);