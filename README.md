# Visual_Search_of_an_Image_Collection
The first course work for CVPR 

## Introduction
This project aims to explore different algorithms for visual searching of an image collection. For each algorithm, a feature database is constructed by computing descriptors, and a test image is used as a query to return a list of the top N images that best match the query by calculating similarity. The project tests and optimizes the performance of each algorithm by adjusting parameters and evaluates the search results using PR curve. Additionally, a comparative evaluation of the performance of different algorithms is conducted. Finally, this project also attempts to use a Support Vector Machine (SVM) to classify all image categories based on the descriptors data.


### Structure of the code
```
.
├── BoVWEstimation.m                                % Estimate the BoVW model
├── README.md
├── SVMwithToolbox.m                                % SVM with toolbox provided matlab
├── classifyBySVM.m                                 % Classify the image using SVM
├── conf                                            % Configuration file for all globale setting
│   └── GlobalSetting.m
├── distanceMeasureFunctions                        % Distance measure functions
│   ├── cosineSim.m
│   ├── euclideanDistance.m
│   ├── euclideanDistanceForMatrix.m
│   ├── mahalanobisDistance.m
│   ├── manhattanDistance.m
│   └── pearsonDistance.m
├── document
│   ├── Visual Search of an Image Collection.tex    % Report with Latex
│   ├── bibliography
│   └── refs.bib
├── modelEstimation
│   ├── computeConfusionMatrix.m
│   ├── computePrValue.m                            % Compute the precision and recall
│   └── plotPrCurve.m                               % Plot the PR curve
├── models
│   ├── BoVW                                        % BoVW model
│   │   ├── computeBoVW.m
│   │   ├── computeSIFT.m
│   │   ├── harris
│   │   ├── kmeans
│   │   ├── sift
│   │   └── testForLib
│   ├── computeDescriptors.m                        % main function for computing the descriptors
│   ├── pca                                         % PCA model
│   │   ├── Eigen_Build.m
│   │   ├── Eigen_Deflate.m
│   │   ├── Eigen_Mahalanobis.m
│   │   ├── Eigen_PCA.m
│   │   ├── Eigen_Plot2D.m
│   │   ├── Eigen_Project.m
│   │   └── Eigen_Test.m
│   ├── rgbHistogram                                % RGB histogram model
│   │   └── computeRGBHistogram.m
│   ├── searchFunction.m                            % main function for searching
│   ├── spacialGrid                                 % Spacial grid model
│   │   ├── computeEdgeOrientationHistogram.m
│   │   └── computeSpacialGrid.m
│   └── svm                                         % SVM model
│       ├── cout.m
│       ├── fileaccess.m
│       ├── monqp.m
│       ├── svmkernel.m
│       ├── svmmulticlass.m
│       ├── svmmultival.m
│       ├── svmval.m
│       ├── tensorwavkernel.m
│       ├── testsvm.m
│       └── waveletfunction.m
├── pcaSearchEstimation.m                          % Estimate the PCA model
├── preprocess
│   ├── makeTestForSearch.m                        % Generate the test data
│   └── statisticForAllClasses.m                   % Compute the statistic for all classes
├── rgbHistogramEstimation.m                       % Estimate the RGB histogram model
├── siftEstimation.m                               % Estimate the SIFT model
├── spacialGridEstimation.m                        % Estimate the spacial grid model
├── test                                           % Test functions
│   ├── test.m
│   ├── testComputeBoVW.m
│   ├── testComputeSpacialGrids.m
│   ├── testEuclideanDistanceForMatrix.m
│   ├── testLoadMat.m
│   ├── testPCA.m
│   └── testPlot.m
└── util                                           % Utility functions
    ├── imgshow.m
    ├── rgb2gray.m
    └── saveTopImages.m
```