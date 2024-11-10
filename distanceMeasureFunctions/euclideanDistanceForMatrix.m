function similarity = euclideanDistanceForMatrix(arr1, arr2)
% EUCLIDEANDISTANCEFORMATRIX Summary of this function goes here
%
% [OUTPUTARGS] = EUCLIDEANDISTANCEFORMATRIX(INPUTARGS) Explain usage here
%
% Examples:
%
% Provide sample usage code here
%
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey
% Date: 2024/11/10 12:54:33
% Revision: 0.1

% 获取矩阵的大小
[rows1, cols1] = size(arr1);
[rows2, cols2] = size(arr2);

% 如果矩阵大小不一样，截取二者最小的相交范围
if rows1 ~= rows2 || cols1 ~= cols2
    minRows = min(rows1, rows2);
    minCols = min(cols1, cols2);
    % 截取两个矩阵的左上角区域
    differ = arr1(1:minRows, 1:minCols) - arr2(1:minRows, 1:minCols);
else
    % 如果大小相同，直接相减
    differ = arr1 - arr2;
end

% 计算差异平方和
numerator = sum(differ(:).^2);
% 计算 arr1 的平方和
denominator = sum(arr1(:).^2);
% 计算相似度
similarity = 1 - (numerator / denominator);


end
