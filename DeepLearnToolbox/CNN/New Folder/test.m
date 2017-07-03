clc;
clear;
load 'net'
picPath='G:\forcoding\Program\matlab\fire detection\img\test\img\img';
gap=10;
pic = imread([picPath,sprintf('%d.jpg',13)]);
% [l,w,fuck]=size(pic);
% pic = imresize(pic,[1024,int32(w/(l/1024))]);
pic = rgb2gray(pic);
tmp=pic;
[l,w]=size(tmp);

pic=zeros(l,w,2);
pic(:,:,1)=tmp;
map=zeros(l,w);
for i=1:gap:l
    i/l
    for j=1:gap:w
        if i+27<l&&j+27<w
            d=detecte(cnn,pic(i:i+27,j:j+27,:)/255);
            if d(:,1)>0.1425
            map(i:i+27,j:j+27)=map(i:i+27,j:j+27)+1;
            end
        end
    end
end
image(map*15);