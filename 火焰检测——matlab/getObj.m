function [ imMask6] = getObj(img2,h)
    boxwidth=20;
    boxheight=40;
    imMask0=mexCvBSLib(img2,h);
    imMask = medfilt2(imMask0,[3 3]);
    [Height Width null] = size(img2);
    for j=1:4:Height
        for k=1:4:Width
            we=0;
            for ti=j:j+3
                for tj=k:k+3
                    if(imMask(ti,tj)>254)
                        we=we+1;
                    end
                    if(imMask(ti,tj)<255)
                        imMask(ti,tj)=0;
                    end
                end
            end
            if(we<5)
                for ti=j:j+3
                    for tj=k:k+3
                        imMask(ti,tj)=0;
                    end
                end
            end
            if(we>12)
                for ti=j:j+3
                    for tj=k:k+3
                        imMask(ti,tj)=255;
                    end
                end
            end
        end
    end
    
    se = strel('disk',2,0);
    imMask6 = imdilate(imMask,se);
    
   

  