%% Author: Xiaoguang Liang (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: xl01339@surrey.ac.uk
%% Time: 09/11/2024 22:43

clc;
close all;
clear;

%% 1) Load feature data and class data

% DESCRIPTOR_SUBFOLDER=GlobalSetting.filePathInfo.DESCRIPTOR_SUBFOLDER;
% Define the output file path for feature data
OUT_FOLDER=GlobalSetting.filePathInfo.DESCRIPTOR_FOLDER;
allFeatFile=[OUT_FOLDER,'/AllFeaturesRGBHist.mat'];
AllFeatures=load(allFeatFile, 'AllFeatures').AllFeatures;


%% 2) Separate the data in training and test
FeatLen = length(AllFeatures);

% Set the test ratio
testRatio = 0.2;
numTest = round(testRatio*FeatLen);

% Get the train data and test data
randIndex = randperm(FeatLen);
testData = AllFeatures(randIndex(1:numTest));
trainData = AllFeatures(randIndex(numTest+1:FeatLen));

trainObs = {trainData.feature};
trainClass = {trainData.class};
trainClassUnique = unique(trainClass);
trainClass = cellfun(@(x) str2num(x), {trainData.class}, 'UniformOutput',0);
testObs = {testData.feature};
testClass = {testData.class};
testClassUnique = unique(testClass);
testClass = cellfun(@(x) str2num(x), {testData.class}, 'UniformOutput',0);

trainObs = trainObs';
testObs = testObs';
trainClass = trainClass';
testClass = testClass';

trainObs = cell2mat(trainObs);
trainClass = cell2mat(trainClass);
testObs = cell2mat(testObs);
testClass = cell2mat(testClass);

%% 3) Setup SVM parameters
kernel='gaussian';
kerneloption=20;
C=10000000;
verbose=1;
lambda=1e-7;
nbclass=20;

%% 4) Train the SVM with training data
% [xsup,w,b,nbsv,pos,alpha]=svmmulticlass(trainObs,trainClass,nbclass,C,lambda,kernel,kerneloption,verbose);
% [ypred] = svmmultival(trainObs,xsup,w,b,nbsv,kernel,kerneloption);
% fprintf( '\nClassification correct on training data : %2.2f \n',100*sum(ypred==trainClass)/length(trainClass)); 
% 
% %% 5) Test the classifier on test data
% [ypred,maxi] = svmmultival(testObs,xsup,w,b,nbsv,kernel,kerneloption);
% fprintf( '\nClassification correct on test data : %2.2f \n',100*sum(ypred==testClass)/length(testClass)); 

Kernel_Cell={'linear';'ploynomial';'RBF';'Sigmoid'};

% Step 1: Load the data
% X is the matrix of input data with dimension of N-by-p
% where N is the number of instances and p is the number of features
% For the convenience of visualization, we define p=2 here;
data_fisheriris;
X=trainObs;
Y=trainClass;

% Step 2: Define parameters
% poly_con is the parameter for Polynomial Kernel 
% gamma is the parameter for Gaussian Kernel 
% kappa1 & kappa2 are the parameters for Sigmoid Kernel 
% precision is the tolerance of precision
% Cost is the hyperparameter for SVM
define_parameters;

% Step 3: Fit the model
% Choose the kernel
kernel=char(Kernel_Cell(1));
%
[alpha,Ker,beta0]=SVM(X,Y,kernel);

% Step 4: Visualize the 2D plot
SVM_plot(X,Y,alpha,beta0,kernel);
