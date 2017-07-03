tmp = imread('G:\forcoding\Program\matlab\fire detection\img\img6.jpg');

imshow(rgb2gray(tmp));
fcoef = fft2(tmp);
spectrum = fftshift(abs(fcoef));
colormap(gray);
spectrum = 255*spectrum/max(spectrum(:));
imshow(spectrum);