clear;clc;close all;
%%%%%若kmeans迭代出错重新运行本文件即可
%%%     载入训练数据
data_=load('vladTrain.mat');
data=data_.siftDescriptorTrain;
dataT=data';

opts=statset('MaxIter',1000);

%%     训练数据
[km_index km_centorid]=kmeans(dataT,16,'Options',opts);
codebook=km_centorid;
save('vladcodebook.mat', 'codebook'); % 保存码本
save('vladindex.mat', 'km_index'); % 保存码本

   
   

