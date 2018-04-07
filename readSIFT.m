function [SITF local]=readSIFT(fid)
siftDim = 128;
featNum = fread(fid, 1, 'int32'); % 文件中SIFT特征的数目
SiftFeat = zeros(siftDim, featNum); 
paraFeat = zeros(4, featNum);
for j = 1 : featNum % 逐个读取SIFT特征
    SITF(:, j) = fread(fid, siftDim, 'uchar'); %先读入128维描述子
    local(:, j) = fread(fid, 4, 'float32');     %再读入[x, y, scale, orientation]信息
end
