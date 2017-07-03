%%
clc;
clear;
%%
% load mnist_uint8;
% train_x = double(reshape(traub.x',28,28,60000))/255;
% test_x = double(reshape(test_x',28,28,10000))/255;
train_x=zeros(28,28,600);
for i=1:600;
    train_x(:,:,i)=double(zeros(28,28));
end
test_x=zeros(28,28,100);
for i=1:100
    test_x(:,:,i)=double(zeros(28,28));
end
train_y = double(ones(1,600));
test_y = double(ones(1,100));
%%
rand('state',0);
cnn.layers = {
    struct('type','i') %input layer
    struct('type','c','outputmaps',6,'kernelsize',5) % convolution layer
    struct('type','s','scale',2) %sub sampling layer
    struct('type','c','outputmaps',12,'kernelsize',5) % convolutional layer
    struct('type','s','scale',2) % sub sampling layer
    };
%% 训练选项，alpha学习效率（不用），batchsiaze批训练总样本的数量，numepoches迭代次数
cnn = cnnsetup(cnn, train_x, train_y);
opts.batchsize = 50;
opts.numepochs = 1;
opts.alpha = 1;
cnn = cnntrain(cnn,train_x,train_y, opts);
[er, bad] = cnntest(cnn, test_x, test_y);
%plot mean squared error
figure; plot(cnn.rL);
