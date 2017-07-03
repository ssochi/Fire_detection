picPath='G:\forcoding\Program\matlab\fire detection\img\test\img';
segPath='G:\forcoding\Program\matlab\fire detection\img\test\img';
for times=14:25
    seg = imread([segPath,sprintf('%d_seg.jpg',times)]);
    [l,w,f]=size(seg);
    map=zeros(l,w);
    for i=1:l
        for j=1:w
            if seg(i,j,1)~=0||seg(i,j,2)~=0||seg(i,j,3)~=0
                map(i,j)=255;
            else
                map(i,j)=0;
            end 
        end
    end
    imwrite(map,[segPath,sprintf('%d_seg.bmp',times)]);
end