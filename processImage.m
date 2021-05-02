function processImage(dir, isOri, isIso, isFinal, panel)
    size = [240 240];
    
    cnt = 0;
    if isOri
        cnt = cnt + 1;
    end
    if isIso
        cnt = cnt + 1;
    end
    if isFinal
        cnt = cnt + 3;
    end
    try
        Children=get(panel,'children');
        h=(findobj(Children,'Type','axes'));
        if ~isempty(h)
        for i=1:length(h),delete(h(i));end
        end
        panel.AutoResizeChildren = 'off';
        
        %collect image
        img = imread(dir);
        croppedImg = cropRubik(img, size);
        sidebyside = colorValue(croppedImg);
        
        %apply image
        axN = 1;
        if isOri
            if cnt < 3
                ax = subplot(ceil(cnt/2), 2, axN, 'Parent', panel);
            else
                ax = subplot(2, ceil(cnt/2), axN, 'Parent', panel);
            end
            imshow(img, 'Parent', ax);
            title(ax, 'Original Image');
            disableDefaultInteractivity(ax);
            axN = axN + 1;
        end
        if isIso
            if cnt < 3
                ax = subplot(ceil(cnt/2), 2, axN, 'Parent', panel);
            else
                ax = subplot(2, ceil(cnt/2), axN, 'Parent', panel);
            end
            imshow(croppedImg, 'Parent', ax);
            title(ax, 'Isometric Color Segmentation');
            disableDefaultInteractivity(ax);
            axN = axN + 1;
        end
    catch ME
        msgbox(ME.message);
    end
end

%Gambar/V1/(1).jpg

