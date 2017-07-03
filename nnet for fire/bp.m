clear  
clc   
load 'train_x'
load 'train_y'
alphabet=train_x';
targets = train_y;
S1=10;  % S1，第一层的神经元个数为10  
[R,Q]=size(alphabet);  
[S2,Q]=size(targets); % S2，第二层的神经元个数为S2  
P=alphabet;  

% 构建BP网络  
net=newff(minmax(P),[S1,S2],{'logsig','logsig'},'traingdx');  
net.LW{2,1}=net.LW{2,1}*0.01; % 调整第二层的权值  
net.b{2}=net.b{2}+0.01;       % 调整第二层的阈值  
  
  
% 无噪声训练  
T=targets;  
net.performFcn='sse';       % 性能函数，误差平方和  
net.trainParam.goal=0.1;  
net.trainParam.show=20;  
net.trainParam.epochs=5000; % 训练次数  
net.trainParam.mc=0.95;     % 附加动量   
[net,tr]=train(net,P,T);  
  
  
% 有噪声训练，两组没有噪的输入，两组有噪声的输入  
netn=net;  
netn.trainParam.goal=0.6;% 性能目标值  
netn.trainParam.epochs=300;% 训练的最大次数  
T=[targets targets targets targets];  
for pass=1:10   %重复10次训练  
        P=[alphabet,alphabet,(alphabet+randn(R,Q)*0.1),(alphabet+randn(R,Q)*0.2)];  
        [netn,tr]=train(netn,P,T);  
end  
  
  
% 再次无噪声训练  
netn.trainParam.goal=0.1;  % 性能目标值  
netn.trainParam.epochs=500;% 训练的最大次数  
netn.trainParam.show=5;  
P=alphabet;  
T=targets;  
[netn,tr]=train(netn,P,T);  
  
  
% 系统性能,绘制网络识别错误与噪声信号关系曲线  
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
        A=sim(net,P);   %经过无噪声训练的网络  
        AA=compet(A);  
        errors1=errors1+sum(sum(abs(AA-T)))/2;  
        An=sim(netn,P); %经过有噪声训练的网络  
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