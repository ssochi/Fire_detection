function aver =  aver_v(arr)
    [l,w]=size(arr);
    aver=0.0;
    for i=1:l
        for j=1:w
            aver=aver+double(arr(i,j));
        end
    end
    aver=aver/(l*w);
end