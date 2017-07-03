clear  
clc   
load 'train_x'
load 'train_y'
alphabet=train_x';
targets = train_y;
S1=10;  % S1����һ�����Ԫ����Ϊ10  
[R,Q]=size(alphabet);  
[S2,Q]=size(targets); % S2���ڶ������Ԫ����ΪS2  
P=alphabet;  

% ����BP����  
net=newff(minmax(P),[S1,S2],{'logsig','logsig'},'traingdx');  
net.LW{2,1}=net.LW{2,1}*0.01; % �����ڶ����Ȩֵ  
net.b{2}=net.b{2}+0.01;       % �����ڶ������ֵ  
  
  
% ������ѵ��  
T=targets;  
net.performFcn='sse';       % ���ܺ��������ƽ����  
net.trainParam.goal=0.1;  
net.trainParam.show=20;  
net.trainParam.epochs=5000; % ѵ������  
net.trainParam.mc=0.95;     % ���Ӷ���   
[net,tr]=train(net,P,T);  
  
  
% ������ѵ��������û��������룬����������������  
netn=net;  
netn.trainParam.goal=0.6;% ����Ŀ��ֵ  
netn.trainParam.epochs=300;% ѵ����������  
T=[targets targets targets targets];  
for pass=1:10   %�ظ�10��ѵ��  
        P=[alphabet,alphabet,(alphabet+randn(R,Q)*0.1),(alphabet+randn(R,Q)*0.2)];  
        [netn,tr]=train(netn,P,T);  
end  
  
  
% �ٴ�������ѵ��  
netn.trainParam.goal=0.1;  % ����Ŀ��ֵ  
netn.trainParam.epochs=500;% ѵ����������  
netn.trainParam.show=5;  
P=alphabet;  
T=targets;  
[netn,tr]=train(netn,P,T);  
  
  
% ϵͳ����,��������ʶ������������źŹ�ϵ����  
noise_range=0:0.05:.5;  
max_test=100;  
network1=[];  
network2=[];  
T=targets;  
for noiselevel=noise_range  
    errors1=0;  
    errors2=0;  
    for i=1:max_test  
        P=alphabet+randn(35,26)*noiselevel;  
        A=sim(net,P);   %����������ѵ��������  
        AA=compet(A);  
        errors1=errors1+sum(sum(abs(AA-T)))/2;  
        An=sim(netn,P); %����������ѵ��������  
        AAn=compet(An);  
        errors2=errors2+sum(sum(abs(AAn-T)))/2;  
    end  
    network1=[network1 errors1/26/100];  
    network2=[network2 errors2/26/100];  
end  
plot(noise_range,network1*100,'--',noise_range,network2*100);  
xlabel('noise indecator');  
ylabel('no-noise net -- noise net-');  
legend('no-noise net','noise net'); 
%%
re=sim(net,train_x');
[l,w]=size(re);
for i=1:w
    if re(i)>0.45
        re(i)=1;
    else
        re(i)=0;
    end
end
figure(1);
image(train_y*64);
figure(2);
image(re*64)