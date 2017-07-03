function [IR,IG,IB] = getRGB(img,x,y,w,h)

% img = rgb2hsv(img);
img = double(img);
x = ceil(x-w/2);
y = ceil(y-h/2);
w = round(w);
h = round(h);
IR = zeros(h,w);
IG = zeros(h,w);
IB = zeros(h,w);
for i = 1:h - 1
    for j = 1:w - 1
        IR(i,j) = img(y+i,x+j,3);
        IG(i,j) = img(y+i,x+j,2);
        IB(i,j) = img(y+i,x+j,1);
        if x + j + 2 > size(img,2)
            break;
        end
    end
    if y + i + 2 > size(img,1)
        break;
    end
end