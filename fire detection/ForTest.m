% demo=imread('G:\forcoding\Program\matlab\fire deteection\img\img2.jpg');
%读入图像
Rt=65;
Gt=50;
St=135;
len_x=10;
len_y=10;
[X, map] = imread('G:\forcoding\Program\matlab\fire detection\img\img1.bmp');
[l,w]=size(X(:,:,1));
l_x=floor(l/len_x);
len_x=floor(l/l_x);
l_y=floor(w/len_y);
len_y=floor(w/l_y);
hsv = rgb2hsv(X);
fire = false;
for i=1:len_x
    for j=1:len_y
        tmp = X(l_x*(i-1)+1:l_x*i,l_y*(j-1)+1:l_y*j,:);
        hsv = rgb2hsv(tmp);
        s=aver_v(hsv(:,:,2))*255;
        r=aver_v(tmp(:,:,1));
        g=aver_v(tmp(:,:,2));
        b=aver_v(tmp(:,:,3));
        
        if (s>=(255-r)*St/Rt)&&((r>=g)&&(g>Gt)&&(g>b))&&(r>Rt)&&varianction(tmp(:,:,1))>3
              fire = true;
%             fprintf('area (%d,%d) is on fire!!! \n',i,j);
%             fprintf('variance is : %d \n',varianction(tmp(:,:,1)));
        else
            X(l_x*(i-1)+1:l_x*i,l_y*(j-1)+1:l_y*j,:)=0;
        end
        
    end
    
end
if fire
    fprintf('on fire!!!');
else
    fprintf('no fire!!!');
end
imshow(X);
% imshow(X);
% %做fft变换，同时将零点移到中心
% fcoef = fft2(X);
% spectrum = fftshift(abs(fcoef));
% %为了显示图像，需要对幅值做归一化处理
% figure;
% colormap(gray);
% spectrum = 255*spectrum/max(spectrum(:));
% %显示频谱，同时保存图像。
% imshow(spectrum);

