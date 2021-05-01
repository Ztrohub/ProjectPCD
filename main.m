clear all;
size = [240 240];

img = cropRubik('referensi.jpg', size);
figure; imshow(img);


%   1      2      3      4      5      6
% merah, orange, kuning, hijau, biru, putih
% hue (0, 40, 60, 120, 200), saturation 0%

% figure;
% for i=1:3
%     for j=1:3
%         rect = [(j-1)*(sizec(2)+toleration), (i-1)*(sizec(1)+toleration), sizec(2)-2*toleration, sizec(1)-2*toleration];
%         cropped = rgb2hsv(imcrop(img, rect));
%         domH = mode(mode(round(cropped(:,:,1) * 18.0) / 18.0));
%         domS = mode(mode(round(cropped(:,:,2) * 4.0) / 4.0));
%         domV = mode(mode(round(cropped(:,:,3) * 4.0) / 4.0));
%         
%         temp = zeros(1,1,3);
%         temp(1,1,1) = domH;
%         temp(1,1,2) = domS > 0.4;
%         temp(1,1,3) = domV > 0;
%         
%         subplot(3, 3, 3*(i-1)+j);
%         imshow(hsv2rgb(temp));
%     end
% end
% 
% function insertColor(color, collection)
%     
% end
