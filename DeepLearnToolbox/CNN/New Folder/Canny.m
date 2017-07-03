img=imread('G:\forcoding\Program\matlab\fire detection\img\test\img13.jpg');  
[m n]=size(img);  
img=double(img);  
w=fspecial('gaussian',[5 5]);  
img=imfilter(img,w,'replicate');  
figure;  
%%sobel边缘检测  
w=fspecial('sobel');  
img_w=imfilter(img,w,'replicate');      %求横边缘  
w=w';                                   %转置矩阵  
img_h=imfilter(img,w,'replicate');      %求竖边缘  
img=sqrt(img_w.^2+img_h.^2);        %平方和再开方   .^表示每一位都和自己乘，不清楚的自己百度  
% figure;  
image((uint8(img)))  