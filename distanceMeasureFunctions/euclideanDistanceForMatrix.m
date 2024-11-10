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

% Get the size of the matrix
[rows1, cols1] = size(arr1);
[rows2, cols2] = size(arr2);

% If not equal, find the minimum size
if rows1 ~= rows2 || cols1 ~= cols2
    minRows = min(rows1, rows2);
    minCols = min(cols1, cols2);
    % Crop the two matrices on the left top corner
    differ = arr1(1:minRows, 1:minCols) - arr2(1:minRows, 1:minCols);
else
    % If the size is the same, subtract directly
    differ = arr1 - arr2;
end

% Calculate the squared difference
numerator = sum(differ(:).^2);
% Calculate the squared sum of arr1
denominator = sum(arr1(:).^2);
% Calculate the similarity
similarity = 1 - (numerator / denominator);


end
