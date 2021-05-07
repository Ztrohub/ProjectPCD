function compareItems(dir, cmpItems)
    siz = [240, 240];
    img = imread(dir);
    croppedImg = cropRubik(img, siz);
    [imgLines, corrValue, projectedImg, projectedColor, rebuildColor]...
        = colorValue(croppedImg);
    
    [x, y] = size(cmpItems.Items);
    cnt = x * y;
    for i=floor(sqrt(cnt)):-1:1
        if mod(cnt, i) == 0
            f1 = i;
            f2 = cnt / i;
            break;
        end
    end
    while f1 == 1 && cnt > 2
        cnt = cnt + 1;
        for i=floor(sqrt(cnt)):-1:1
            if mod(cnt, i) == 0
                f1 = i;
                f2 = cnt / i;
                break;
            end
        end
    end

    f = figure('Name', 'Compare result');
    idx = 1;

    for i=1:x
        for j=1:y
            ax = subplot(f1, f2, idx, 'Parent', f);
            id = cmpItems.ItemsData{i,j};
            switch id
                case 2
                    imshow(img, 'Parent', ax);
                case 3
                    imshow(croppedImg, 'Parent', ax);
                case 5
                    surf(ax, corrValue.C, 'EdgeColor', 'none', 'FaceColor', 'flat', 'FaceAlpha', 0.8);
                case 4
                    hold(ax, 'on');
                    imshow(croppedImg, 'Parent', ax);
                    plot(ax, imgLines.x, imgLines.y, 'bo',...
                        'LineWidth',4,...
                        'MarkerSize',20,...
                        'MarkerEdgeColor','b',...
                        'MarkerFaceColor',[0.5,0.5,0.5]);
                    line(ax, imgLines.x, imgLines.y,...
                        'LineWidth',4,...
                        'MarkerSize',20,...
                        'MarkerEdgeColor','b',...
                        'MarkerFaceColor',[0.5,0.5,0.5]);
                    hold(ax, 'off');
                case 6
                    imshow(projectedImg, 'Parent', ax);
                case 7
                    imshow(projectedColor, 'Parent', ax);
                case 8
                    hold(ax, 'on');
                    surf(ax, rebuildColor.Top.x, rebuildColor.Top.y, rebuildColor.Top.z, rebuildColor.Top.img, 'facecolor', 'texturemap', 'edgecolor', 'none', 'FaceAlpha',0.8);
                    surf(ax, rebuildColor.Left.x, rebuildColor.Left.y, rebuildColor.Left.z, rebuildColor.Left.img, 'facecolor', 'texturemap', 'edgecolor', 'none', 'FaceAlpha',0.8);
                    surf(ax, rebuildColor.Right.x, rebuildColor.Right.y, rebuildColor.Right.z, rebuildColor.Right.img, 'facecolor', 'texturemap', 'edgecolor', 'none', 'FaceAlpha',0.8);
                    hold(ax, 'off');
                    xlim(ax, [-3 1]);
                    ylim(ax, [-3 1]);
                    zlim(ax, [-1 3]);
                    view(ax, [-9 -9 4.5]);
                otherwise
                    warning('Unexpected plot type. No plot created.')
            end
            idx = idx + 1;
        end
    end
end

