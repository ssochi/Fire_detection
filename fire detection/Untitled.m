% 
% [X, map] = imread('G:\forcoding\Program\matlab\fire detection\img\img12.bmp');
% [X, map] = imread('G:\forcoding\Program\matlab\fire detection\img\img9.jpg');
% [X, map] = imread('G:\forcoding\Program\matlab\fire detection\img\test\img11.jpg');
[l,w]=size(X(:,:,1));
Rt = 75;
St = 125;
R_bt=60;
hsv = rgb2hsv(X);
tmp=X;
for i=1:l
    for j=1:w
        r = X(i,j,1);
        g = X(i,j,2);
        b = X(i,j,3);
        v = hsv(i,j,3)*255;
        s = hsv(i,j,2)*255;
        h = hsv(i,j,1)*255;
        if r-b>75
            acc=acc+1;
        end
        if r+b-2*g>105
            acc=acc+1;
        end
        if s>(255-r)*1.5
            acc=acc+1;
        end
        if r>155
            acc=acc+1;
        end 
        if v>240
            acc=acc+1;
        end
        if g-b>27
            acc=acc+1;
        end
        if r>g&&g>=b
            acc=acc+1;
        end
        
        if r-b>75
            X(i,j,:)=1;
        else
             X(i,j,:)=0;
        end
       
    end
end
imshow(X.*tmp);

fprintf('done\n')
