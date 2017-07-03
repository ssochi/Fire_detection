%%
clc;
clear;
%%
% load mnist_uint8;
% train_x = double(reshape(traub.x',28,28,60000))/255;
% test_x = double(reshape(test_x',28,28,10000))/255;
load 'train_x.mat'
load 'train_y.mat'
test_x=double(train_x(:,:,1:1000))/255;
train_x=double(train_x(:,:,1:60000))/255;
test_y = double(train_y(:,1:1000));
train_y = double(train_y(:,1:60000));

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
save 'net' cnn;
%%
clc;
clear;
load 'train_x'
load 'train_y'
load 'net'
len=5000;
figure(1);
image(train_y(:,1:1+len)*255)
figure(2);
d=detecte(cnn,double(train_x(:,:,1:1+len))/255);
for i=1:len
    if d(:,i)>0.3
        d(:,i)=1;
    else
        d(:,i)=0;
        
    end
end
image(d*255);