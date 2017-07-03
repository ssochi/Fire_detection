%%
%清除数据
clc;
clear;
list=6:25;
picPath='G:\forcoding\Program\matlab\fire detection\img\test\img\img';
segPath='G:\forcoding\Program\matlab\fire detection\img\test\img\img';
%颜色表
rgb_map=zeros(256,256,256);
%出现次数表
rgb_times=zeros(256,256,256);
[fuck,len]=size(list);
for times=1:len
    %样本图片
    pic = imread([picPath,sprintf('%d.jpg',list(times))]);
    %样本图片的识别后的二值图像
    seg = imread([segPath,sprintf('%d_seg.bmp',list(times))]);
    [l,w]=size(seg);
    %填充map
    for i=1:l
        for j=1:w
            r = pic(i,j,1)+1;
            g = pic(i,j,2)+1;
            b = pic(i,j,3)+1;
            rgb_times(r,g,b)=rgb_times(r,g,b)+1;
            rgb_map(r,g,b)=rgb_map(r,g,b)+int32(seg(i,j)/255);
        end  
    end
end
%%
%data_x训练输入样本
data_x=zeros(256*256*256,3);
%data_y训练输入样本
data_y=zeros(1,256*256*256);
%%
%填充样本
index=1;
for r=1:256
    for g=1:256
        for b=1:256
            data_x(index,1)=r;
            data_x(index,2)=g;
            data_x(index,3)=b;
            if(rgb_times(r,g,b)==0)
                data_y(index)=-1;
            else
                if rgb_map(r,g,b)/rgb_times(r,g,b)>0.5
                    data_y(index)=1;
                else
                    data_y(index)=0;
                end
                    
            end
            index=index+1;
        end
    end
end
%%
%计算data有效值
index=1;
for i=1:256*256*256
    if data_y(i)~=-1
        index=index+1;
    end
end
index
%%
%填充有效data为train
train_x=zeros(518729,3);
train_y=zeros(1,518729);
index=1;
for i=1:256*256*256
    if data_y(i)~=-1
        train_x(index,:)=data_x(i,:);
        train_y(index)=data_y(i);
        index=index+1;
    end
end
save 'train_x' train_x;
save 'train_y' train_y;