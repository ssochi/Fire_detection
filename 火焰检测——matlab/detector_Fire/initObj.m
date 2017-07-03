function [h] = initObj(img,x)

h=mexCvBSLib(img);%Initialize
mexCvBSLib(img,h,[x 4*4 1 0.5]);%set parameters