clc;
clear;

%models
solverin = './models/icub_alexnet/solver.prototxt';
solver = caffe.Solver(solverin);

%train
solver.solve();
% solver.step(100);

%get the network
train_net = solver.net;

%save network
train_net.save('/models/icub_alexnet/neuroicubnet.caffemodel');