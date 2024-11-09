function dst = mahalanobisDistance(F1, F2)
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

% Subtract each element of feature F1 from feature F2
x=F1-F2;
% Square these differences and divid with eigenvalues (for all row elements)
x=x.^2./v(1:size(v,2));
% Sum up the square differences
x=sum(x);
% Take the square root
dst=sqrt(x);


end
