%%
clc;
clear;
list=6:13;
picPath='G:\forcoding\Program\matlab\fire detection\img\test\img';
segPath='G:\forcoding\Program\matlab\fire detection\img\test\img';
rgb_map=zeros(256,256,3);
rgb_times=zeros(256,256,3);
[fuck,len]=size(list);
for times=1:len
    pic = imread([picPath,sprintf('%d.jpg',list(times))]);
    seg = imread([segPath,sprintf('%d_seg.bmp',list(times))]);
    [l,w]=size(seg);
    for i=1:l
        for j=1:w
            r = pic(i,j,1)+1;
            g = pic(i,j,2)+1;
            b = pic(i,j,3)+1;
            rgb_times(r,g,1)=rgb_times(r,g,1)+1;
            rgb_times(r,b,2)=rgb_times(r,b,2)+1;
            rgb_times(g,b,3)=rgb_times(g,b,3)+1;
            rgb_map(r,g,1)=rgb_map(r,g,1)+int32(seg(i,j)/255);
            rgb_map(r,b,2)=rgb_map(r,b,2)+int32(seg(i,j)/255);
            rgb_map(g,b,3)=rgb_map(g,b,3)+int32(seg(i,j)/255);
        end
            
    end
end
list=14:25;
picPath='G:\forcoding\Program\matlab\fire detection\img\test\img';
segPath='G:\forcoding\Program\matlab\fire detection\img\test\img';
[fuck,len]=size(list);
for times=1:len
    pic = imread([picPath,sprintf('%d.jpg',list(times))]);
    seg = imread([segPath,sprintf('%d_seg.jpg',list(times))]);
    [l,w,fuck]=size(seg);
    for i=1:l
        for j=1:w
            r = pic(i,j,1)+1;
            g = pic(i,j,2)+1;
            b = pic(i,j,3)+1;
            rgb_times(r,g,1)=rgb_times(r,g,1)+1;
            rgb_times(r,b,2)=rgb_times(r,b,2)+1;
            rgb_times(g,b,3)=rgb_times(g,b,3)+1;
            if seg(i,j,1)~=0||seg(i,j,2)~=0||seg(i,j,3)~=0
            rgb_map(r,g,1)=rgb_map(r,g,1)+int32(seg(i,j)/255);
            rgb_map(r,b,2)=rgb_map(r,b,2)+int32(seg(i,j)/255);
            rgb_map(g,b,3)=rgb_map(g,b,3)+int32(seg(i,j)/255);
            end
        end
            
    end
end
list=14:25;
picPath='G:\forcoding\Program\matlab\fire detection\img\test\img';
segPath='G:\forcoding\Program\matlab\fire detection\img\test\img';
[fuck,len]=size(list);
for times=1:len
    pic = imread([picPath,sprintf('%d.jpg',24)]);
    seg = imread([segPath,sprintf('%d_seg.jpg',24)]);
    [l,w,fuck]=size(seg);
    for i=1:l
        for j=1:w
            r = pic(i,j,1)+1;
            g = pic(i,j,2)+1;
            b = pic(i,j,3)+1;
            rgb_times(r,g,1)=rgb_times(r,g,1)+1;
            rgb_times(r,b,2)=rgb_times(r,b,2)+1;
            rgb_times(g,b,3)=rgb_times(g,b,3)+1;
            if seg(i,j,1)~=0||seg(i,j,2)~=0||seg(i,j,3)~=0
            rgb_map(r,g,1)=rgb_map(r,g,1)+int32(seg(i,j)/255);
            rgb_map(r,b,2)=rgb_map(r,b,2)+int32(seg(i,j)/255);
            rgb_map(g,b,3)=rgb_map(g,b,3)+int32(seg(i,j)/255);
            end
        end
            
    end
end
save 'rgb_map' rgb_map
save 'rgb_times' rgb_times
%%
path='G:\forcoding\Program\matlab\fire detection\img\test\img';
for t=6:25
    X = imread([path,sprintf('%d.jpg',t)]);
    imshow(X)
[l,w,z]=size(X);
for i=1:l
    for j=1:w
        r = X(i,j,1)+1;
        g = X(i,j,2)+1;
        b = X(i,j,3)+1;
        if(rgb_map(r,g,b)/rgb_times(r,g,b)>0.5)
            X(i,j,:)=255;
        else
            X(i,j,:)=0;
        end
    end
end
tmp=X;

X=tmp;
D=[0,1,0
    1,1,1
    0,1,0];
for i=1:2
    X=imerode(X,D);
end
for i=1:10
    X=imdilate(X,D);
end
for i=1:8
    X=imerode(X,D);
end
imshow(X)

end
%%
load('rgb_map.mat');
load('rgb_times.mat');
path='G:\forcoding\Program\matlab\fire detection\img\test\img18.jpg';
X = imread(path);
[l,w,z]=size(X);
for i=1:l
    for j=1:w
        r = X(i,j,1)+1;
        g = X(i,j,2)+1;
        b = X(i,j,3)+1;
        if(rgb_map(r,g,b)/rgb_times(r,g,b)>0.5)
            X(i,j,:)=255;
        else
            X(i,j,:)=0;
        end
    end
end
tmp=X;

X=tmp;
D=[0,1,0
    1,1,1
    0,1,0];

for i=1:2
    X=imdilate(X,D);
end
for i=1:2
    X=imerode(X,D);
end
imshow(X);

imshow(X/255.*imread(path));
% rgb_map=rgb_map./rgb_times;