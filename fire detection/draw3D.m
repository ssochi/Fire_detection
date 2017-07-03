function draw3D(arr)
    [l,w]=size(arr);
    xa = 1:l;
    ya = 1:w;
    [x,y] = meshgrid(xa,ya);
    z = zeros(size(x,1));
    for i = 1:size(x,1)
        z(i,:) = arr(x(i,:),y(i,:));
    end

    mesh(x,y,z);
end