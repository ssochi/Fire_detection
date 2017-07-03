function re=detecte(net,x)
    net = cnnff(net, x);
    re=net.o;
end