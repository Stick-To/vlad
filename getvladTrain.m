%%
% �˴������������SIFT ѵ����������
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
        featNum = fread(fid, 1, 'int32'); % �ļ���SIFT��������Ŀ
        SiftFeat = zeros(siftDim, featNum); 
        paraFeat = zeros(4, featNum);

        for j = 1 : featNum % �����ȡSIFT����
            SiftFeat(:, j) = fread(fid, siftDim, 'uchar'); %�ȶ���128ά������
            paraFeat(:, j) = fread(fid, 4, 'float32');     %�ٶ���[x, y, scale, orientation]��Ϣ  
        end
        fclose(fid);
        siftDescriptorTrain = [siftDescriptorTrain, SiftFeat];
end

% P = randperm(size(siftDescriptorTrain, 2));
% siftTrain = siftDescriptorTrain(:, P(1:20000));
save('vladTrain.mat', 'siftDescriptorTrain'); 

