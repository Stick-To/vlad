clear;clc;close all;


sift_path='.\test images\';
sift_path_list = dir(strcat(sift_path,'*.dsift'));
sift_num = length(sift_path_list)

codebook_=load('vladcodebook.mat');
codebook=codebook_.codebook;

index=load('vladindex.mat');
index=index.km_index;


%% 计算vlad编码，保存为code
 split_feat=1;
 
 for i = 1:sift_num
         sift_name = sift_path_list(i).name;
         indlas=strfind(sift_name,'.');
         sift_head_name=sift_name(1:indlas-1);
         fprintf('%d  %s\n',i,sift_head_name);
         sift_path_name=strcat(sift_path,sift_name);
         fid = fopen(sift_path_name, 'rb');
         [sift local]=readSIFT(fid);                                        %%%读取SIFT特征和SIFT对应的坐标
         siftT=sift';
         fclose(fid);
         sz=size(sift);
         index_temp=index(split_feat:split_feat+sz(2)-1);
         code_temp=codebook(index_temp,:);
         residual=siftT-code_temp;                                                            %%%计算每幅图残差
         for j=1:16
             index_find=find(index_temp==j);
             residual_temp=residual(index_find,:);
             code(:,j)=sum(residual_temp);                                                    %计算残差和
         end
         code = code ./ repmat(sqrt(sum(code.^2)), size(code, 1), 1);             %%% 二范数归一化
         save(strcat(sift_head_name,'vladcode.mat'),'code'); 
        split_feat=split_feat+sz(2);
 end

