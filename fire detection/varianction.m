function var = varianction(array)
    [l,w]=size(array);
    var=0.0;
    for i=1:l
        for j=1:w
            d=0;
            count=0;
            current=double(array(i,j));
            if i+1<l
                d=d+double(array(i+1,j))-current;
                count=count+1;
            end
            if i-1>0
                d=d+double(array(i-1,j))-current;
                count=count+1;
            end
            if j+1<w
                d=d+double(array(i,j+1))-current;
                count=count+1;
            end
            if j-1>0
                d=d+double(array(i,j-1))-current;
                count=count+1;
            end
            var=var+abs(d/count);
        end
    end
    var=var/(l*w);
end