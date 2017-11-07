% clc;
% clear;

%input image
% imgname = './data/iCubWorld1.0/human/test/octopus/00001500.jpg';
imgname = '/home/vvasco/dev/data/iCub/ATIS/bounding_box/test/00000048.jpg';

%models
model = './models/icub_alexnet/deploy.prototxt';
weights = './models/icub_alexnet/neuroicubdnet.caffemodel';

%use only cpu
caffe.set_mode_cpu();

%create net and load weights
net = caffe.Net(model, weights, 'test');

%load an image and test
image = imread(imgname);
res =  net.forward({image});
prob = res{1};