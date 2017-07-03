% BP 神经网络用于模式分类
% 使用平台 - Matlab6.5
% 作者：陆振波，海军工程大学
% 欢迎同行来信交流与合作，更多文章与程序下载请访问我的个人主页
% 电子邮件：luzhenbo@sina.com
% 个人主页：luzhenbo.88uu.com.cn

clc
clear
close all
load firefeature1
load firefeature2
load nonfirefeature1
%---------------------------------------------------
% 产生训练样本与测试样本，每一列为一个样本
n1=[Fire_Feature1, Fire_Feature2, nonFire_Feature, nonFire_Feature];
%n1 = [rand(4,5),rand(4,5)+1,rand(4,5)+2];
x1 = [repmat([1;0],1,42),repmat([0;1],1,42)];

n2 = [Fire_Feature1, Fire_Feature2, nonFire_Feature, nonFire_Feature];
x2 = [repmat([1;0],1,42),repmat([0;1],1,42)];

xn_train = n1;          % 训练样本
dn_train = x1;          % 训练目标

xn_test = n2;           % 测试样本
dn_test = x2;           % 测试目标

%---------------------------------------------------
% 函数接口赋值

NodeNum = 20;           % 隐层节点数 
TypeNum = 2;            % 输出维数
p1 = xn_train;          % 训练输入
t1 = dn_train;          % 训练输出
Epochs = 1000;          % 训练次数

P = xn_test;            % 测试输入 
T = dn_test;            % 测试输出(真实值)

%---------------------------------------------------
% 设置网络参数

%TF1 = 'tansig';TF2 = 'purelin'; % 缺省值
%TF1 = 'tansig';TF2 = 'logsig';
TF1 = 'logsig';TF2 = 'purelin';
%TF1 = 'tansig';TF2 = 'tansig';
%TF1 = 'logsig';TF2 = 'logsig';
%TF1 = 'purelin';TF2 = 'purelin';

net = newff(minmax(p1),[NodeNum TypeNum],{TF1 TF2},'trainlm');

% 指定训练参数
%net.trainFcn = 'trainlm';  % 内存使用最多（快）
%net.trainFcn = 'trainbfg';
%net.trainFcn = 'trainrp';  % 内存使用最少（慢）
%net.trainFcn = 'traingda'; % 变学习率
%net.trainFcn = 'traingdx';

net.trainParam.epochs = Epochs;     % 最大训练次数
net.trainParam.goal = 1e-8;         % 最小均方误差
net.trainParam.min_grad = 1e-20;    % 最小梯度
net.trainParam.show = 200;          % 训练显示间隔
net.trainParam.time = inf;          % 最大训练时间

%---------------------------------------------------
% 训练与测试

net = train(net,p1,t1);             % 训练
%load Net
%X = sim(net,P(:,1));                     % 测试 - 输出为预测值
%X = full(compet(X));                 % 竞争输出

%---------------------------------------------------
% 结果统计

%Result = ~sum(abs(X-x2));               % 正确分类显示为1
%Percent = sum(Result)/length(Result);   % 正确分类率

