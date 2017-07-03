%  get training data for training BP Network 
clear;
clc;
Rt=100;
St=115;
Image2=imread('dst13\h10001.jpg');
Image2=imresize(Image2,[240,320]);
h=initObj(Image2,0.01);

oldsize=0;
newsize=0;
time=1;
OldOutImage=zeros(123,163);
OldOutImage1=zeros(240,320);
OldDif=0;
Dif=0;
OldX=0;
OldY=0;
newX=0;
newY=0;
isfire=false;
newcosb=0;
oldcosb=0;
%%
tempfeature=[0;0;0];
Fire_Feature=[];
%%
for i=1:150
if i<10
  str=strcat('dst13\h1000',int2str(i),'.jpg');
elseif i<100 && i>=10
    str=strcat('dst13\h100',int2str(i),'.jpg');
else
    str=strcat('dst13\h10',int2str(i),'.jpg');
end
    
Outimg=zeros(size(Image2(:,:,1)));
Image1=imread(str);
Image1=imresize(Image1,[240,320]);
Image1(:,:,1) = medfilt2(Image1(:,:,1),[3 3]);
Image1(:,:,2) = medfilt2(Image1(:,:,2),[3 3]);
Image1(:,:,3) = medfilt2(Image1(:,:,3),[3 3]);
outimg=getObj(Image1,h);
outimg=~outimg;
outimg=~outimg;
se = strel('disk',2);
outimg=imerode(outimg,se);
ImageR=double(Image1(:,:,1));
ImageG=double(Image1(:,:,2));
ImageB=double(Image1(:,:,3));
HSVimg=double(rgb2hsv(Image1))*255;
YCBCRimg=double(rgb2ycbcr(Image1));
oldsize=newsize;
newsize=0;
for m=1:size(ImageR,1)
    for n=1:size(ImageR,2)
        if outimg(m,n)==1
            if ImageR(m,n)>Rt && YCBCRimg(m,n,3)>YCBCRimg(m,n,2) %&&  ImageR(m,n)>Image2(m,n,1)
                if ImageR(m,n)>ImageG(m,n) && ImageG(m,n)>ImageB(m,n)
                    if HSVimg(m,n,2)>=((255-ImageR(m,n))*St/Rt) %&& HSVimg(m,n,2)>=St
                        Outimg(m,n)=255;
                        newsize=newsize+1;
                    end
                end
            end
        end
    end
end
%% Í¼Ïñ´¦Àí
se = strel('disk',4,0);
Outimg = imdilate(Outimg,se);
se = strel('disk',4,0);
Outimg = imerode(Outimg,se);
Label=bwlabel(Outimg);             
area_num=regionprops(Label,'Area');
if isempty(area_num)
    continue;
end
 len_area=length(area_num);
 area_bounding=regionprops(Label,'BoundingBox');
 areasize=0;
 largest=1;
 for oo=1:len_area
     if area_bounding(oo).BoundingBox(3)*area_bounding(oo).BoundingBox(3)>areasize
         areasize=area_bounding(oo).BoundingBox(3)*area_bounding(oo).BoundingBox(4);
         largest=oo;
     end
 end
area_bounding(largest).BoundingBox(2)=round(area_bounding(largest).BoundingBox(2));
area_bounding(largest).BoundingBox(4)=round(area_bounding(largest).BoundingBox(4));
area_bounding(largest).BoundingBox(1)=round(area_bounding(largest).BoundingBox(1));
area_bounding(largest).BoundingBox(3)=round(area_bounding(largest).BoundingBox(3));
 tempimg=zeros(size(Outimg));
 tempimg(area_bounding(largest).BoundingBox(2)+1:area_bounding(largest).BoundingBox(2)+area_bounding(largest).BoundingBox(4)-1,area_bounding(largest).BoundingBox(1)+1:area_bounding(largest).BoundingBox(1)+area_bounding(largest).BoundingBox(3)-1)= tempimg(area_bounding(largest).BoundingBox(2)+1:area_bounding(largest).BoundingBox(2)+area_bounding(largest).BoundingBox(4)-1,area_bounding(largest).BoundingBox(1)+1:area_bounding(largest).BoundingBox(1)+area_bounding(largest).BoundingBox(3)-1)+1;
 Outimg=Outimg.*tempimg;
%% ÑÌÎí¼ì²â
[AY,BY,CY,DY]=dwt2(Image2(:,:,1),'db4');
AY=BY+CY+DY;
[AN,BN,CN,DN]=dwt2(Image1(:,:,1),'db4');
AN=BN+CN+DN;
DIN=AN-AY;
Smok=zeros(size(DIN));
for k2=1:size(DIN,1)
    for k3=1:size(DIN,2)
        if DIN(k2,k3)<0
        Smok(k2,k3)=255;
        else
            Smok(k2,k3)=0;
        end
    end
end


%%
ImageW=double(Image1(:,:,1)).*(Outimg(:,:,1)/255);
[A,B,C,D]=dwt2(ImageW,'db4');
A=B+C+D;
%newsize=size(find(A),1);
%Dif=abs(A-OldOutImage(:,:,1));
Dif=xor(A,OldOutImage(:,:,1));
OldOutImage(:,:,1)=A;
%Dif=xor(Outimg(:,:,1),OldOutImage(:,:,1));
%% »ðÔÖÏàËÆ¶È¼ÆËã
jiao=Outimg & OldOutImage1;
bing=Outimg | OldOutImage1;
jiao=size(find(jiao),1);
bing=size(find(bing),1);
if bing~=0;
sim=jiao/bing;
else
    sim=0;
end

OldOutImage1(:,:,1)=Outimg(:,:,1);
Dif=size(find(Dif),1);
diff=abs(Dif-OldDif)/(OldDif+1);
OldDif=Dif;
%if abs(newsize-oldsize)/(oldsize+1)>0.2 && diff>0.2
%% ¼ÆËã»ðÑæ¶¯Ì¬ÌØÕ÷
fireX=0;
fireY=0;
sumX=0;
sumY=0;
for k2=1:size(ImageR,1)
    for k3=1:size(ImageR,2)
         fireX=Outimg(k2,k3)*HSVimg(k2,k3,3)*k3+fireX;
         fireY=Outimg(k2,k3)*HSVimg(k2,k3,3)*k2+fireY;
         sumX=sumX+Outimg(k2,k3)*HSVimg(k2,k3,3);
         sumY=sumY+Outimg(k2,k3)*HSVimg(k2,k3,3);
    end
end
if sumX~=0 && sumY~=0
fireX=fireX/sumX;
fireY=fireY/sumY;
else
    fireX=0;
    fireY=0;
end

newX=fireX;
newY=fireY;
% if abs(newY-OldY)/size(ImageR,1)>0.01 &&  abs(newY-OldY)/size(ImageR,1)<0.04 &&  abs(newX-OldX)/size(ImageR,2)>0.009 && abs(newX-OldX)/size(ImageR,2)<0.06
%     isfire=true;
% else
%     isfire=false;
% end
OldX=newX;
OldY=newY;
%% »ðÑæ½Ç¶È¼ì²â
[Y2,X2]=find(Outimg(:,:,1));
[C,I]=min(X2);
opintleft=[0+Y2(I),0+X2(I)];
[C,I]=max(X2);
opintright=[Y2(I), X2(I)];
[C,I]=min(Y2);
opinttop=[Y2(I),X2(I)];
[C,I]=max(Y2);
opintdown=[Y2(I),X2(I)];

if ~isempty(opinttop) && ~isempty(opintdown) && ~isempty(opintright)
AE=sqrt((opinttop(1)-opintright(1))^2+(opintright(2)-opinttop(2))^2);
BE=sqrt((opintdown(1)-opintright(1))^2+(opintdown(2)-opintright(2))^2);
CE=sqrt((opinttop(1)-opintdown(1))^2+(opintdown(2)-opinttop(2))^2);
newcosb=-(AE^2+BE^2-CE^2)/(2*AE*BE);
end
cosb=acos(abs(newcosb-oldcosb))*180/pi; 
cosb=90-cosb;
if cosb>30
    isfire=true;
end
%% »ðÔÖ±¥ºÍÌØÕ÷
if ~isempty(opinttop) && ~isempty(opintdown) && ~isempty(opintright)
bao=Outimg(opinttop(1):opintdown(1),opintleft(2):opintright(2),1);
sizare=size(find(bao),1);
sizeare=sizare/((opintdown(1)-opinttop(1))*(opintright(2)-opintleft(2)));
else
sizeare=0;    
end
%% ¼ÇÂ¼ÌØÕ÷
tempfeature=tempfeature+[diff;sim;sizeare];
if mod(i,5)==0
    Fire_Feature=[Fire_Feature tempfeature./5];
    tempfeature=[0;0;0];
end




%%
oldcosb=newcosb;

figure(1);            
imshow(uint8(Image1));
drawnow; 
figure(2);
imshow(uint8(Outimg));
drawnow; 
end

Fire_Feature=Fire_Feature(:,10:30);