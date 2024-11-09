function AllFeatures=rgbHistogramDescriptors(Q,save_one_file)
arguments
    % Set the default value for Q
    Q=4
    % If save_one_file is 1, save all the
    % feature data into one file, otherwise save the feature
    % data by the file names
    save_one_file=1
end
% rgbHistogramDescriptors Summary of this function goes here
%
% [OUTPUTARGS] = COMPUTER_DESCRIPTORS(INPUTARGS) Explain usage here
%
% Examples:
%
% Provide sample usage code here
%
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey
% Date: 2024/10/22 10:06:56
% Revision: 0.1

%% Edit the following line to the folder you unzipped the MSRCv2 dataset to
DATASET_FOLDER = GlobalSetting.filePathInfo.DATASET_FOLDER;

%% and within that folder, create another folder to hold these descriptors
%% the idea is all your descriptors are in individual folders - within
%% the folder specified as 'OUT_FOLDER'.
OUT_FOLDER=GlobalSetting.filePathInfo.DESCRIPTOR_FOLDER;
OUT_SUBFOLDER=GlobalSetting.filePathInfo.DESCRIPTOR_SUBFOLDER;
allFiles=GlobalSetting.filePathInfo.allFiles;

% Define the Stuct for all features
AllFeatures=struct('name', {}, 'class', {}, 'path', {}, 'imgData', {}, 'feature', {});

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
    F=computeRGBHistogram(img, Q);

    % Save feature data
    if save_one_file == 1
        % Store all the feature data into the struct allFeatures
        AllFeatures(end+1).name = fname;
        AllFeatures(end).class = className;
        AllFeatures(end).path = imgfname_full;
        AllFeatures(end).imgData = img;
        AllFeatures(end).feature = F;

        % Save all the feature data at the end of for loop
        if filenum == allFilesLen
            % all_features=allFeatures;
            fout=[OUT_FOLDER,'/AllFeatures.mat'];
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
