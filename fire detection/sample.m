% 
% [X, map] = imread('G:\forcoding\Program\matlab\fire detection\img\img12.bmp');
% [X, map] = imread('G:\forcoding\Program\matlab\fire detection\img\img14.jpg');
[X, map] = imread('G:\forcoding\Program\matlab\fire detection\img\test\img\img24.jpg');
[l,w]=size(X(:,:,1));
Rt = 75;
St = 125;
R_bt=60;
tmp=X;
hsv = rgb2hsv(X);

seg=zeros(l,w);
for i=1:l
    for j=1:w
        r = X(i,j,1);
        g = X(i,j,2);
        b = X(i,j,3);
        v=hsv(i,j,3)*255;
        
        if r>g&&g>b&&r>210&&s>(255-r)*20/210
            X(i,j,:)=1;
            seg(i,j)=255;
        else
             X(i,j,:)=0;
             seg(i,j)=0;
        end
       
    end
end
imshow(X.*tmp);
% imwrite(tmp,'img26.jpg');
imwrite(seg,'G:\forcoding\Program\matlab\fire detection\img\test\img24_seg.bmp');
fprintf('done\n')