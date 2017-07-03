function paint(i,j,l,w,Ft)
    global feature;
    if i>l||j>w||i<1||j<1||feature(i,j)<=0||feature(i,j)==Ft
    else
        feature(i,j)=Ft;
        paint(i+1,j,l,w,Ft);
        paint(i-1,j,l,w,Ft);
        paint(i,j+1,l,w,Ft);
        paint(i,j-1,l,w,Ft);
    end
end