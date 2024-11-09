classdef GlobalSetting
    %GLOBAL_SETTING Summary of this class goes here
    %   Detailed explanation goes here

    properties(Constant=true)
        % SHOW = 591 % The number of the search result 
        SHOW = 21
        filePathInfo = GlobalSetting
    end
    properties
        DATASET_FOLDER
        allFiles
        DESCRIPTOR_FOLDER
        DESCRIPTOR_SUBFOLDER
        TEST_DATA
        PR_GRAPH_PATH
        CM_GRAPH_PATH
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
            obj.PR_GRAPH_PATH='data/pr_graphs';
            obj.CM_GRAPH_PATH='data/cm_graphs';
        end

    end
end

