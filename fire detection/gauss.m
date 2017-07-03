function re=gauss(arr)
    originimg = arr;
    [ori_row,ori_col]=size(originimg);  
    sigma = 5;      %sigma��ֵ  
    N = 7;            %��С�ǣ�2N+1������2N+1��  
    N_row = 2*N+1;    
    OriImage_noise = imnoise(originimg,'gaussian'); %����    
    gausFilter = fspecial('gaussian',[N_row N_row],sigma);      %matlab �Դ���˹ģ���˲�  
    blur=imfilter(OriImage_noise,gausFilter,'conv');    
    H = [];                                        %���˹ģ��H  
    for i=1:N_row  
        for j=1:N_row  
            fenzi=double((i-N-1)^2+(j-N-1)^2);  
            H(i,j)=exp(-fenzi/(2*sigma*sigma))/(2*pi*sigma);  
        end  
    end  
    H=H/sum(H(:));              %��һ��  

    desimg=zeros(ori_row,ori_col);            %�˲���ͼ��  
    midimg=zeros(ori_row+2*N,ori_col+2*N);    %�м�ͼ��  
    for i=1:ori_row                           %ԭͼ��ֵ���м�ͼ�����ܱ�Ե����Ϊ0  
        for j=1:ori_col  
            midimg(i+N,j+N)=OriImage_noise(i,j);  
        end  
    end  
    temp=[];  
    for ai=N+1:ori_row+N  
        for aj=N+1:ori_col+N  
            temp_row=ai-N;  
            temp_col=aj-N;  
            temp=0;  
            for bi=1:N_row  
                for bj=1:N_row  
                    temp= temp+(midimg(temp_row+bi-1,temp_col+bj-1)*H(bi,bj));  
                end  
            end  
            desimg(temp_row,temp_col)=temp;  
        end  
    end    
    re=desimg;
  
end
  