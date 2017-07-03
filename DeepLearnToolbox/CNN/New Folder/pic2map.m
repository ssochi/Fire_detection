function map=pic2map(pic)
    [l,w]=size(pic);
    len=(l-27)*(w-27);
    map=zeros(28,28,len);
    t=1;
    for i=1:l
        for j=1:w
            map(:,:,t)=pic(i:i+27,j:j+27);
        end
    end
    
end