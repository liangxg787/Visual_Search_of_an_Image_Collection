function AllFeatures = computeDescriptors(ModelType,varargin)
% COMPUTEDESCRIPTORS Summary of this function goes here
%
% [OUTPUTARGS] = COMPUTEDESCRIPTORS(INPUTARGS) Explain usage here
%
% Examples:
%
% Provide sample usage code here
%
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey
% Date: 2024/11/2 18:08:44
% Revision: 0.1

% If save_one_file is 1, save all the
% feature data into one file, otherwise save the feature
% data by the file names
save_one_file=1;

%% Path for the MSRCv2 dataset
DATASET_FOLDER = GlobalSetting.filePathInfo.DATASET_FOLDER;

%% and within that folder, create another folder to hold these descriptors
%% the idea is all your descriptors are in individual folders - within
%% the folder specified as 'OUT_FOLDER'.
OUT_FOLDER=GlobalSetting.filePathInfo.DESCRIPTOR_FOLDER;
OUT_SUBFOLDER=GlobalSetting.filePathInfo.DESCRIPTOR_SUBFOLDER;
allFiles=GlobalSetting.filePathInfo.allFiles;

% Define the Stuct for all features
AllFeatures=struct('name', {}, 'class', {}, 'path', {}, 'imgData', {}, 'feature', {}, 'obs', {});

allFilesLen = length(allFiles);
for filenum=1:allFilesLen
    fname=allFiles(filenum).name;
    % fprintf('Processing file %d/%d - %s\n',filenum,allFilesLen,fname);
    % Get the image's class number
    className = split(fname, "_");
    className = className{1};
    % tic;
    imgfname_full=([DATASET_FOLDER,'/Images/',fname]);
    img=double(imread(imgfname_full))./255;

    % Extract feature
    switch ModelType
        case 'RGBHist'
            % Parse the input arguments: varargin
            Q = varargin{1};
            F=computeRGBHistogram(img, Q);
        case 'spacialGrid'
            % Parse the input arguments: varargin
            featureType = varargin{1};
            grids = varargin{2};
            Q = varargin{3};
            F=computeSpacialGrid(img,featureType,grids,Q);
        case 'PCA'
            obs=[reshape(img(:,:,1),1,[]); reshape(img(:,:,2),1,[]); reshape(img(:,:,3),1,[])];
            method='keepf';
            energyRate=1;
            % method='keepn';
            % eigen-vector keep 1 dimension, so that the distance is a number instead of a matrix
            % dimensions=1;
            [~, F]=Eigen_PCA(obs,method,energyRate);
        case 'SIFT'
            % Parse the input arguments: varargin
            NumOctaves = varargin{1};
            NumLevels = varargin{2};
            F=computeSIFT(img,NumOctaves,NumLevels);
        otherwise
            error(['Unknown parameter: ' ModelType]) ;
    end

    % Save feature data
    if save_one_file == 1
        % Store all the feature data into the struct allFeatures
        AllFeatures(end+1).name = fname;
        AllFeatures(end).class = className;
        AllFeatures(end).path = imgfname_full;
        AllFeatures(end).imgData = img;
        AllFeatures(end).feature = F;

        if strcmp(ModelType, 'PCA')
            AllFeatures(end).obs = obs;
        end

        % Save all the feature data at the end of for loop
        if filenum == allFilesLen
            % all_features=allFeatures;
            fout=[OUT_FOLDER,'/AllFeatures', ModelType, '.mat'];
            save(fout,'AllFeatures');
        end
    else
        % Save feature data
        fout=[OUT_SUBFOLDER,'/',fname(1:end-4),'.mat'];%replace .bmp with .mat
        save(fout,'F');
    end
    % toc
end

end
