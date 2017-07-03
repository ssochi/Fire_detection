load('rgb_map.mat');
load('rgb_times.mat');
path='G:\forcoding\Program\matlab\fire detection\img\test\img\img';
 X = imread([path,sprintf('%d.jpg',13)]);
 [l,w,z]=size(X);
 map=zeros(l,w);
for i=1:l
    for j=1:w
        r = X(i,j,1)+1;
        g = X(i,j,2)+1;
        b = X(i,j,3)+1;
        rg=rgb_map(r,g,1)/rgb_times(r,g,1);
        rb=rgb_map(r,b,2)/rgb_times(r,b,2);
        gb=rgb_map(g,b,3)/rgb_times(g,b,3);
        acc=0;
        if rg>0.5
           acc=acc+1;
        end
        if rb>0.5
           acc=acc+1;
        end
        if gb>0.5
           acc=acc+1;
        end
        if rg*rb*gb>(1-rg)*(1-rb)*(1-gb)
            acc=acc+1;
        end
        if rg+rb+gb>(1-rg)+(1-rb)+(1-gb)
            acc=acc+1;
        end
        if r-b>75
            acc=acc+1;
        end
        if g-b>26
            acc=acc+1;
        end
        if r+b-2*g>105
            acc=acc+1;
        end
        if r>155
            acc=acc+1;
        end
        map(i,j)=acc;
        if acc>=6
            X(i,j,:)=255;
        else
            X(i,j,:)=0;
        end
        
    end
end
image(X);