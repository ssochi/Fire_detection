clc;
clear;
load 'rgb_map';
load 'rgb_times'
arr=zeros(256,256);
for i=1:256
    for j=1:256
        if rgb_times(i,j,2)~=0
            arr(i,j)=1-rgb_map(i,j,2)/rgb_times(i,j,2);
        else
            arr(i,j)=0;
        end
    end
end
