function FeatData = computeBoVW(FeatData)
% COMPUTEBOVW Summary of this function goes here
%
% [OUTPUTARGS] = COMPUTEBOVW(INPUTARGS) Explain usage here
%
% Examples:
%
% Provide sample usage code here
%
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey
% Date: 2024/11/11 19:33:57
% Revision: 0.1

% number of codewords (i.e. K for the k-means algorithm)
nwordsCodebook = 1000;
% nfeatCodebook = 75000;

normBofHist = 0;

%% 1: quantize pre-computed image features with SIFT

Desc = {FeatData.feature};

% Concatenate all the data
alldata=[];
for i=1:length(Desc)
    alldata=[alldata Desc{i}];
end
alldata = double(alldata);

NCLUSTERS = 591;
DIMENSION = 128;

fprintf('Running KMeans over %d points (of dimension %d)\n',size(alldata,2),DIMENSION);
startingcentres=rand(NCLUSTERS,DIMENSION);
centres=Kmeans(startingcentres,alldata',zeros(1,14));
centres = centres';


fprintf('\nFeature quantization...\n');
for i=1:length(FeatData)
    % fprintf('>>>> %d \n', i);
    sift = FeatData(i).feature(:,:);
    if isempty(sift)
        FeatData(i).visword = 0;
        FeatData(i).quantdist = 0;
    else

        sift = double(sift);
        % siftResized = imresize(sift, size(centres));
        centresResized = imresize(centres, size(sift));
        dmat = euclideanDistance(sift,centresResized);
        [quantdist,visword] = min(dmat,[],2);
        % save feature labels
        FeatData(i).visword = visword;
        FeatData(i).quantdist = quantdist;
    end
end

%% 2: represent images with BOF histograms

% N = size(centres,1); % number of visual words

for i=1:length(FeatData) 
    visword = FeatData(i).visword;
    H = histc(visword,[1:nwordsCodebook]);
    % normalize bow-hist (L1 norm)
    if normBofHist
        H = H/sum(H);
    end
    % save histograms
    % FeatData(i).bof=H(:)';
    FeatData(i).feature=H(:)';
end

% Concatenate bof-histograms into training and test matrices 
% bofData=cat(1,FeatData.bof);

end
