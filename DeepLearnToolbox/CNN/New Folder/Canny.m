img=imread('G:\forcoding\Program\matlab\fire detection\img\test\img13.jpg');  
[m n]=size(img);  
img=double(img);  
w=fspecial('gaussian',[5 5]);  
img=imfilter(img,w,'replicate');  
figure;  
%%sobel��Ե���  
w=fspecial('sobel');  
img_w=imfilter(img,w,'replicate');      %����Ե  
w=w';                                   %ת�þ���  
img_h=imfilter(img,w,'replicate');      %������Ե  
img=sqrt(img_w.^2+img_h.^2);        %ƽ�����ٿ���   .^��ʾÿһλ�����Լ��ˣ���������Լ��ٶ�  
% figure;  
image((uint8(img)))  