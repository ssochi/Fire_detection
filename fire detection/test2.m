% 
% [X, map] = imread('G:\forcoding\Program\matlab\fire detection\img\img12.bmp');
% [X, map] = imread('G:\forcoding\Program\matlab\fire detection\img\img1.jpg');
[X, map] = imread('G:\forcoding\Program\matlab\fire detection\img\test\img1.jpg');
[l,w]=size(X(:,:,1));
Rt = 75;
St = 125;
R_bt=60;
hsv = rgb2hsv(X);
tmp=X;
area_x=int32(l/10);
area_y=int32(w/10);
value_map=zeros(l,w);
for i=1:l
    for j=1:w
        r = X(i,j,1);
        g = X(i,j,2);
        b = X(i,j,3);
        v = hsv(i,j,3)*255;
        s = hsv(i,j,2)*255;
        if v>250
            acc=0;
            for ii=i-area_x:i+area_x
                for jj=j-area_y:j+area_y
                    if(ii>0&&jj>0&&ii<l&&jj<w&&tmp(ii,jj,1)+tmp(ii,jj,2)-2*tmp(ii,jj,3)>105)
                        value_map(ii,jj)=value_map(ii,jj)+1;
                        acc=acc+1;
                    end
                end
            end
             value_map(i,j)=acc;
             X(i,j,:)=1;
        else
             X(i,j,:)=0;
        end
       
    end
end
% image(value_map);
for i=1:l
    for j=1:w
        if value_map(i,j)>900
            X(i,j,:)=1;
        else
            X(i,j,:)=0;
        end
    end
end
B=[0 1 0
   1 1 1
   0 1 0];
value_map=imdilate(X,B);
imshow(X.*tmp);
% imshow(hsv(:,:,3));
fprintf('done\n')