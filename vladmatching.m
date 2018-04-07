clear;clc;close all;

sift_path='.\test images\';
sift_path_list = dir(strcat(sift_path,'*.dsift'));
sift_num = length(sift_path_list);

img_code_path='.\';

%%  vladƥ��

 for i = 1:sift_num
         sift_name = sift_path_list(i).name;
         indlas=strfind(sift_name,'.');
         sift_head_name=sift_name(1:indlas-1);
%          fprintf('%d  %s\n',i,sift_head_name);
         img_code_name=strcat(img_code_path,sift_head_name);
         img_code_name=strcat(img_code_name,'vladcode.mat');
         img_code_temp=load(img_code_name);
         img_code_matrix(:,:,i)=img_code_temp.code;                        %%%����ÿ��ͼ�в���󣬲��Ϊ��ά����
         img_name_cell{i}=sift_head_name;                                        %%%����ͼƬ����
 end
 
 for j = 1:sift_num
     for k=1:j
         img_dist_matrix(j,k)=sum(sum((img_code_matrix(:,:,j)-img_code_matrix(:,:,k)).^2))^(1/2);    %%%����ŷʽ����
     end
 end
 
img_dist_matrix=img_dist_matrix+img_dist_matrix';                        %%%����ŷʽ�������

[B,IX] = sort(img_dist_matrix);                                                      %%%�������

for p = 1:4
     for q=1:sift_num
         img_name_temp=img_name_cell{IX(p,q)};                             %%%���ݾ���Զ������ͼƬ����
         img_neighbor_cell{p,q}=strcat(img_name_temp,'.jpg');
         img_neighbor_index(p,q)=str2num(img_name_temp(end-4:end));   %%%ȡͼƬ�����е�����
     end
end
 

%% ����ʹ�ӡƥ��׼ȷ��
search_accuracy_temp=floor(img_neighbor_index/4);                            
for m=1:sift_num
    search_accuracy(m)=length(find(search_accuracy_temp(:,m)==search_accuracy_temp(1,m)));              
    fprintf('%s    accuracy num  %d    accuracy ratio   %.2f%% \n',strcat(img_name_cell{m},'.jpg'),search_accuracy(m),search_accuracy(m)*100/4);
end
 


