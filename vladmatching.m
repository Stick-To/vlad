clear;clc;close all;

sift_path='.\test images\';
sift_path_list = dir(strcat(sift_path,'*.dsift'));
sift_num = length(sift_path_list);

img_code_path='.\';

%%  vlad匹配

 for i = 1:sift_num
         sift_name = sift_path_list(i).name;
         indlas=strfind(sift_name,'.');
         sift_head_name=sift_name(1:indlas-1);
%          fprintf('%d  %s\n',i,sift_head_name);
         img_code_name=strcat(img_code_path,sift_head_name);
         img_code_name=strcat(img_code_name,'vladcode.mat');
         img_code_temp=load(img_code_name);
         img_code_matrix(:,:,i)=img_code_temp.code;                        %%%读入每幅图残差矩阵，层叠为高维矩阵
         img_name_cell{i}=sift_head_name;                                        %%%保存图片名字
 end
 
 for j = 1:sift_num
     for k=1:j
         img_dist_matrix(j,k)=sum(sum((img_code_matrix(:,:,j)-img_code_matrix(:,:,k)).^2))^(1/2);    %%%计算欧式距离
     end
 end
 
img_dist_matrix=img_dist_matrix+img_dist_matrix';                        %%%计算欧式距离矩阵

[B,IX] = sort(img_dist_matrix);                                                      %%%排序距离

for p = 1:4
     for q=1:sift_num
         img_name_temp=img_name_cell{IX(p,q)};                             %%%根据距离远近排序图片名字
         img_neighbor_cell{p,q}=strcat(img_name_temp,'.jpg');
         img_neighbor_index(p,q)=str2num(img_name_temp(end-4:end));   %%%取图片名字中的数字
     end
end
 

%% 计算和打印匹配准确率
search_accuracy_temp=floor(img_neighbor_index/4);                            
for m=1:sift_num
    search_accuracy(m)=length(find(search_accuracy_temp(:,m)==search_accuracy_temp(1,m)));              
    fprintf('%s    accuracy num  %d    accuracy ratio   %.2f%% \n',strcat(img_name_cell{m},'.jpg'),search_accuracy(m),search_accuracy(m)*100/4);
end
 


