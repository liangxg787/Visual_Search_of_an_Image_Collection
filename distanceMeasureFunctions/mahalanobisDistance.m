function dst = mahalanobisDistance(v1, v2)
% MAHALANOBISDISTANCE Summary of this function goes here
% 
% [OUTPUTARGS] = MAHALANOBISDISTANCE(INPUTARGS) Explain usage here
% 
% Examples: 
% 
% Provide sample usage code here
% 
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey 
% Date: 2024/11/09 16:36:03 
% Revision: 0.1 

% Compute the inner product
inner_product = v1' * v2; 

% Compute the length product
len_product = norm(v1) * norm(v2);

% Compute the Mahalanobis distance
mahalanobis_distance = abs(1 - inner_product / len_product);
dst = sqrt(mahalanobis_distance);


end
