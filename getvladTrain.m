%%
% 此代码仅用于生成SIFT 训练样本数据
%

clear;
close all;
clc;
siftDim = 128
allFiles = dir('test images');

sift_path='.\test images\';
sift_path_list = dir(strcat(sift_path,'*.dsift'));
sift_num = length(sift_path_list)

siftDescriptorTrain = [];


 for i = 1:sift_num
        sift_name = sift_path_list(i).name;
        fprintf('%d  %s\n',i,sift_name);
        sift_path_name=strcat(sift_path,sift_name);
        fid = fopen(sift_path_name, 'rb');
        featNum = fread(fid, 1, 'int32'); % 文件中SIFT特征的数目
        SiftFeat = zeros(siftDim, featNum); 
        paraFeat = zeros(4, featNum);

        for j = 1 : featNum % 逐个读取SIFT特征
            SiftFeat(:, j) = fread(fid, siftDim, 'uchar'); %先读入128维描述子
            paraFeat(:, j) = fread(fid, 4, 'float32');     %再读入[x, y, scale, orientation]信息  
        end
        fclose(fid);
        siftDescriptorTrain = [siftDescriptorTrain, SiftFeat];
end

% P = randperm(size(siftDescriptorTrain, 2));
% siftTrain = siftDescriptorTrain(:, P(1:20000));
save('vladTrain.mat', 'siftDescriptorTrain'); 

