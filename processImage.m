function processImage(dir, checked, tabGroup, tabList)
    size = [240 240];
    
%     collect image
    img = imread(dir);
    croppedImg = cropRubik(img, size);
    [imgLines, corrValue, projectedImg, projectedColor, rebuildColor]...
        = colorValue(croppedImg);
%     while tabGroup.Children ~= 
%         tabGroup.Children(1).delete;
%     end
%     for i=1:size(tabList)
%         tabList(1) = false;
%     end
    tabGroup.Children
%     tabList = [];
%     tabList(end + 1) = uitab(tabGroup, 'Title', 'duar');
    t = uitab(tabGroup, 'Title', 'duar');
    ax = axes('Parent', t, 'Units', 'Pixels');
    imshow(img, 'Parent', ax);
    
    
%     Children = get(panel,'children');
%     h = (findobj(Children,'Type','axes'));
%     if ~isempty(h)
%         for i=1:length(h),delete(h(i));end
%     end
%     panel.AutoResizeChildren = 'off';
% 

% 
%     %apply image
%     axN = 1;
%     if isOri
%         if cnt < 3
%             ax = subplot(ceil(cnt/2), 2, axN, 'Parent', panel);
%         else
%             ax = subplot(2, ceil(cnt/2), axN, 'Parent', panel);
%         end
%         imshow(img, 'Parent', ax);
%         title(ax, 'Original Image');
%         disableDefaultInteractivity(ax);
%         axN = axN + 1;
%     end
%     if isIso
%         if cnt < 3
%             ax = subplot(ceil(cnt/2), 2, axN, 'Parent', panel);
%         else
%             ax = subplot(2, ceil(cnt/2), axN, 'Parent', panel);
%         end
%         imshow(croppedImg, 'Parent', ax);
%         title(ax, 'Isometric Color Segmentation');
%         disableDefaultInteractivity(ax);
%         axN = axN + 1;
%     end
end

