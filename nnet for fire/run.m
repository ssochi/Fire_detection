clc;
clear;
%加载bp神经网络为net
load 'bp_net'
picPath='G:\forcoding\Program\matlab\fire detection\img\test\img\img';
pic = imread([picPath,sprintf('%d.jpg',24)]);
[l,w,fu]=size(pic);
in=zeros(l*w,3);
index=1;
%处理数据为2维数据
for i=1:l
    for j=1:w
        in(index,1)=pic(i,j,1);
        in(index,2)=pic(i,j,2);
        in(index,3)=pic(i,j,3);
        index=index+1;
    end
end
%带入神经网络
re=sim(net,in');
%将2维结果转成3维
index=1;
for i=1:l
    for j=1:w
        if re(index)>0.45
            pic(i,j,:)=255;
        else
            pic(i,j,:)=0;
        end
        index=index+1;
    end
end
imshow(pic);