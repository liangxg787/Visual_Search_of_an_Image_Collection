classdef GlobalSetting
    %GLOBAL_SETTING Summary of this class goes here
    %   Detailed explanation goes here

    properties(Constant=true)
        topN=591 % The number of the search result 
        % topN=21
        SHOW = 10 % The number of showing the search result 
        filePathInfo = GlobalSetting

        % Parameters for SIFT
        nCorners=100
    end
    properties
        DATASET_FOLDER
        allFiles
        DESCRIPTOR_FOLDER
        DESCRIPTOR_SUBFOLDER
        TEST_DATA
        CLASS_DICT
        PR_GRAPH_PATH
        CM_GRAPH_PATH
        SEARCH_RESULTS
        SIFT_TEST_IMAGES
    end

    methods
        function obj = GlobalSetting()
            %GLOBAL_SETTING Construct an instance of this class
            %   Detailed explanation goes here
            obj.DATASET_FOLDER = 'data/MSRC_ObjCategImageDatabase_v2';
            obj.allFiles = dir (fullfile([obj.DATASET_FOLDER,'/Images/*.bmp']));
            obj.DESCRIPTOR_FOLDER = 'data/descriptors';
            obj.DESCRIPTOR_SUBFOLDER=[obj.DESCRIPTOR_FOLDER,'/globalRGBhisto'];
            obj.TEST_DATA='data/testData.mat';
            obj.CLASS_DICT='data/ClassDict.mat';
            obj.PR_GRAPH_PATH='data/pr_graphs';
            obj.CM_GRAPH_PATH='data/cm_graphs';
            obj.SEARCH_RESULTS='data/search_results';
            obj.SIFT_TEST_IMAGES='data/testimages';
        end

    end
end

