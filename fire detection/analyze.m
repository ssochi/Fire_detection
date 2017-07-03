function analyze(Ft)
    global feature;
    [l,w]=size(feature);
    for i=1:l
        for j=1:w
            if(feature(i,j)>Ft)
                paint(i,j,l,w,Ft);
            end
        end
    end
    for i=1:l
        for j=1:w
            if(feature(i,j)<Ft)
                feature(i,j) = 0;
            else
                feature(i,j) = 1;
            end
        end
    end
end