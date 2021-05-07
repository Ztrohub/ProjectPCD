function processImage(dir, checked, tabGroup, fig)
    size = [240 240];
    
    % collect image
    d = uiprogressdlg(fig,'Title','Please Wait',...
        'Message','Start process');

    img = imread(dir); %-------------------------------------------------------- img
    d.Value = .25;
    d.Message = 'Load image';
    pause(.1);

    croppedImg = cropRubik(img, size); %-------------------------------- cropped img
    d.Value = .50;
    d.Message = 'Crop image';
    pause(.1);

    % Finish calculations
    [imgLines, corrValue, projectedImg, projectedColor, rebuildColor]...
        = colorValue(croppedImg); %----------------------------------- final process
    
    d.Value = .75;
    d.Message = 'Process your image';
    pause(.1);
    
    
    tabList = getappdata(tabGroup, 'tabList');
    
    if checked.oriCheckBox == 1
        Children = get(tabList.tabOri, 'children');
        h = (findobj(Children, 'Type', 'axes'));
        if ~isempty(h)
            for i=1:length(h), delete(h(i));end
        end
        tabList.tabOri.AutoResizeChildren = 'off';
        
        tabList.tabOri.Parent = tabGroup;
        ax = axes(tabList.tabOri);
        set(ax, 'Units', 'Pixels');
        imshow(img, 'Parent', ax);
        disableDefaultInteractivity(ax);
    else
        tabList.tabOri.Parent = [];
    end
    
    if checked.isometricCheckBox == 1
        Children = get(tabList.tabIso, 'children');
        h = (findobj(Children, 'Type', 'axes'));
        if ~isempty(h)
            for i=1:length(h), delete(h(i));end
        end
        tabList.tabIso.AutoResizeChildren = 'off';
        
        tabList.tabIso.Parent = tabGroup;
        ax = axes(tabList.tabIso);
        set(ax, 'Units', 'Pixels');
        imshow(croppedImg, 'Parent', ax);
        disableDefaultInteractivity(ax);
    else
        tabList.tabIso.Parent = [];
    end
    
    if checked.corrValueCheckBox == 1
        Children = get(tabList.tabCorrV, 'children');
        h = (findobj(Children, 'Type', 'axes'));
        if ~isempty(h)
            for i=1:length(h), delete(h(i));end
        end
        tabList.tabCorrV.AutoResizeChildren = 'off';
        
        tabList.tabCorrV.Parent = tabGroup;
        
        axP1 = axes(tabList.tabCorrV, 'Position', [0.02 0.77 0.21 0.21], 'Title', 'Pattern 1');
        set(axP1, 'Units', 'Pixels');
        patt1 = imread('pattern/patt1.jpg');
        imshow(patt1, 'Parent', axP1);
        disableDefaultInteractivity(axP1);
        
        axP2 = axes(tabList.tabCorrV, 'Position', [0.02 0.52 0.21 0.21], 'Title', 'Pattern 2');
        set(axP2, 'Units', 'Pixels');
        patt2 = imread('pattern/patt2.jpg');
        imshow(patt2, 'Parent', axP2);
        disableDefaultInteractivity(axP2);
        
        axP3 = axes(tabList.tabCorrV, 'Position', [0.02 0.27 0.21 0.21], 'Title', 'Pattern 3');
        set(axP3, 'Units', 'Pixels');
        patt3 = imread('pattern/patt3.jpg');
        imshow(patt3, 'Parent', axP3);
        disableDefaultInteractivity(axP3);
        
        axP4 = axes(tabList.tabCorrV, 'Position', [0.02 0.02 0.21 0.21], 'Title', 'Pattern 4');
        set(axP4, 'Units', 'Pixels');
        patt4 = imread('pattern/patt4.jpg');
        imshow(patt4, 'Parent', axP4);
        disableDefaultInteractivity(axP4);
        
        axS = axes(tabList.tabCorrV, 'Position', [0.33 0. 0.67 1]);
        set(axS, 'Units', 'Pixels');
        surf(axS, corrValue.C, 'EdgeColor', 'none', 'FaceColor', 'flat', 'FaceAlpha', 0.8);
    else
        tabList.tabCorrV.Parent = [];
    end
    
    if checked.imageLinesCheckBox == 1
        Children = get(tabList.tabImgLn, 'children');
        h = (findobj(Children, 'Type', 'axes'));
        if ~isempty(h)
            for i=1:length(h), delete(h(i));end
        end
        tabList.tabImgLn.AutoResizeChildren = 'off';
        
        tabList.tabImgLn.Parent = tabGroup;
        ax = axes(tabList.tabImgLn);
        set(ax, 'Units', 'Pixels');
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
        
        disableDefaultInteractivity(ax);
    else
        tabList.tabImgLn.Parent = [];
    end
    
    if checked.projectImgCheckBox == 1
        Children = get(tabList.tabPrjI, 'children');
        h = (findobj(Children, 'Type', 'axes'));
        if ~isempty(h)
            for i=1:length(h), delete(h(i));end
        end
        tabList.tabPrjI.AutoResizeChildren = 'off';
        
        tabList.tabPrjI.Parent = tabGroup;
        ax = axes(tabList.tabPrjI);
        set(ax, 'Units', 'Pixels');
        imshow(projectedImg, 'Parent', ax);
        disableDefaultInteractivity(ax);
    else
        tabList.tabPrjI.Parent = [];
    end
    
    if checked.projectColorCheckBox == 1
        Children = get(tabList.tabPrjC, 'children');
        h = (findobj(Children, 'Type', 'axes'));
        if ~isempty(h)
            for i=1:length(h), delete(h(i));end
        end
        tabList.tabPrjC.AutoResizeChildren = 'off';
        
        tabList.tabPrjC.Parent = tabGroup;
        ax = axes(tabList.tabPrjC);
        set(ax, 'Units', 'Pixels');
        imshow(projectedColor, 'Parent', ax);
        disableDefaultInteractivity(ax);
    else
        tabList.tabPrjC.Parent = [];
    end
    
    if checked.plot3dCheckBox == 1
        Children = get(tabList.tab3dPlt, 'children');
        h = (findobj(Children, 'Type', 'axes'));
        if ~isempty(h)
            for i=1:length(h), delete(h(i));end
        end
        tabList.tab3dPlt.AutoResizeChildren = 'off';
        
        tabList.tab3dPlt.Parent = tabGroup;
        ax = axes(tabList.tab3dPlt);
        %set(ax, 'Units', 'Pixels');
        hold(ax, 'on');
        surf(ax, rebuildColor.Top.x, rebuildColor.Top.y, rebuildColor.Top.z, rebuildColor.Top.img, 'facecolor', 'texturemap', 'edgecolor', 'none', 'FaceAlpha',0.8);
        surf(ax, rebuildColor.Left.x, rebuildColor.Left.y, rebuildColor.Left.z, rebuildColor.Left.img, 'facecolor', 'texturemap', 'edgecolor', 'none', 'FaceAlpha',0.8);
        surf(ax, rebuildColor.Right.x, rebuildColor.Right.y, rebuildColor.Right.z, rebuildColor.Right.img, 'facecolor', 'texturemap', 'edgecolor', 'none', 'FaceAlpha',0.8);
        hold(ax, 'off');
        xlim(ax, [-3 1]);
        ylim(ax, [-3 1]);
        zlim(ax, [-1 3]);
        view(ax, [-9 -9 4.5]);
    else
        tabList.tab3dPlt.Parent = [];
    end
    
%     if checked.imageLinesCheckBox == 1
%         Children = get(tabList.tabImgLn, 'children');
%         h = (findobj(Children, 'Type', 'axes'));
%         if ~isempty(h)
%             for i=1:length(h), delete(h(i));end
%         end
%         tabList.tabImgLn.AutoResizeChildren = 'off';
%         
%         tabList.tabImgLn.Parent = tabGroup;
%         ax = axes(tabList.tabImgLn);
%         set(ax, 'Units', 'Pixels');
%         imshow(croppedImg, 'Parent', ax);hold on;
%         imshow
%         disableDefaultInteractivity(ax);
%     else
%         tabList.tabIso.Parent = [];
%     end
    
%         imshow(img, 'Parent', ax);
%         title(ax, 'Original Image');
%         

    d.Value = 1;
    d.Message = 'Display result';
    pause(.1);

    % Close dialog box
    close(d);
end

