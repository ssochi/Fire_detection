% demo=imread('G:\forcoding\Program\matlab\fire deteection\img\img2.jpg');
%����ͼ��
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
% %��fft�任��ͬʱ������Ƶ�����
% fcoef = fft2(X);
% spectrum = fftshift(abs(fcoef));
% %Ϊ����ʾͼ����Ҫ�Է�ֵ����һ������
% figure;
% colormap(gray);
% spectrum = 255*spectrum/max(spectrum(:));
% %��ʾƵ�ף�ͬʱ����ͼ��
% imshow(spectrum);

