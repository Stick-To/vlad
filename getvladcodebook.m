clear;clc;close all;
%%%%%��kmeans���������������б��ļ�����
%%%     ����ѵ������
data_=load('vladTrain.mat');
data=data_.siftDescriptorTrain;
dataT=data';

opts=statset('MaxIter',1000);

%%     ѵ������
[km_index km_centorid]=kmeans(dataT,16,'Options',opts);
codebook=km_centorid;
save('vladcodebook.mat', 'codebook'); % �����뱾
save('vladindex.mat', 'km_index'); % �����뱾

   
   

