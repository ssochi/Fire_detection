% BP ����������ģʽ����
% ʹ��ƽ̨ - Matlab6.5
% ���ߣ�½�񲨣��������̴�ѧ
% ��ӭͬ�����Ž���������������������������������ҵĸ�����ҳ
% �����ʼ���luzhenbo@sina.com
% ������ҳ��luzhenbo.88uu.com.cn

clc
clear
close all
load firefeature1
load firefeature2
load nonfirefeature1
%---------------------------------------------------
% ����ѵ�����������������ÿһ��Ϊһ������
n1=[Fire_Feature1, Fire_Feature2, nonFire_Feature, nonFire_Feature];
%n1 = [rand(4,5),rand(4,5)+1,rand(4,5)+2];
x1 = [repmat([1;0],1,42),repmat([0;1],1,42)];

n2 = [Fire_Feature1, Fire_Feature2, nonFire_Feature, nonFire_Feature];
x2 = [repmat([1;0],1,42),repmat([0;1],1,42)];

xn_train = n1;          % ѵ������
dn_train = x1;          % ѵ��Ŀ��

xn_test = n2;           % ��������
dn_test = x2;           % ����Ŀ��

%---------------------------------------------------
% �����ӿڸ�ֵ

NodeNum = 20;           % ����ڵ��� 
TypeNum = 2;            % ���ά��
p1 = xn_train;          % ѵ������
t1 = dn_train;          % ѵ�����
Epochs = 1000;          % ѵ������

P = xn_test;            % �������� 
T = dn_test;            % �������(��ʵֵ)

%---------------------------------------------------
% �����������

%TF1 = 'tansig';TF2 = 'purelin'; % ȱʡֵ
%TF1 = 'tansig';TF2 = 'logsig';
TF1 = 'logsig';TF2 = 'purelin';
%TF1 = 'tansig';TF2 = 'tansig';
%TF1 = 'logsig';TF2 = 'logsig';
%TF1 = 'purelin';TF2 = 'purelin';

net = newff(minmax(p1),[NodeNum TypeNum],{TF1 TF2},'trainlm');

% ָ��ѵ������
%net.trainFcn = 'trainlm';  % �ڴ�ʹ����ࣨ�죩
%net.trainFcn = 'trainbfg';
%net.trainFcn = 'trainrp';  % �ڴ�ʹ�����٣�����
%net.trainFcn = 'traingda'; % ��ѧϰ��
%net.trainFcn = 'traingdx';

net.trainParam.epochs = Epochs;     % ���ѵ������
net.trainParam.goal = 1e-8;         % ��С�������
net.trainParam.min_grad = 1e-20;    % ��С�ݶ�
net.trainParam.show = 200;          % ѵ����ʾ���
net.trainParam.time = inf;          % ���ѵ��ʱ��

%---------------------------------------------------
% ѵ�������

net = train(net,p1,t1);             % ѵ��
%load Net
%X = sim(net,P(:,1));                     % ���� - ���ΪԤ��ֵ
%X = full(compet(X));                 % �������

%---------------------------------------------------
% ���ͳ��

%Result = ~sum(abs(X-x2));               % ��ȷ������ʾΪ1
%Percent = sum(Result)/length(Result);   % ��ȷ������

