[seg, map] = imread('G:\forcoding\Program\matlab\fire detection\img\test\img1_seg.bmp');
[in,map]=imread('G:\forcoding\Program\matlab\fire detection\img\test\img1.jpg');
seg=seg/255;
for i=1:3
    in(:,:,i)=in(:,:,i).*seg;
end
[l,w]=size(seg);
sum = 0;
r=zeros(10000);
g=zeros(10000);
b=zeros(10000);

for i=1:l
    for j=1:w
        if in(i,j,1)~=0&&sum<10000
            sum=sum+1;
            r(sum)=in(i,j,1);
            g(sum)=in(i,j,2);
            b(sum)=in(i,j,3);
        end
    end
end
imshow(in);


