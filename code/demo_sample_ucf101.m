%% --Setting Configs
clear all;
clc;
option_all;
options.numClusters = 40;
disp('Setting Up...');
% Set the root directory of video-feature mat files
options.demo_alias = 'sample_ucf101';
options.mode = 'cnn';
options.pyramidType = 'max';
options.pcaType='npca';
options.input= fullfile(options.input,'ucf101sample');
disp('Load Data ...');
load (options.ucfClassIndexFile);
classInd(4:end,:)=[];

%% --Import Data
% Read mat feature files and convert to standard input cell format
% and Make the index of imported video features to "Dataall"
disp('Import/Convert Data ...');
[ Dataall, IndexDataall ] = Ucf101Import( options.input, classInd );

% --Feature Extraction
disp('Extract CNN Features ...');
tic;
%cnn_feature = ComputeFeatures(Dataall,options);
[cnn_feature_size] = ComputeFeaturesForPca(Dataall,options,options.mode);
ff = toc;
fprintf('Extract Features done in %f min\n',ff/60);

%% --Indexing Test/Train Samples
% Index matrix of test and train samples in following order:
% [category_idx, sample_idx_in_Category, test(1)/train(0)]
test_train_idx = [3 1 0;...
                   %2 3 0;...
                   2 1 0;...
                   1 1 0;...
                   1 3 0;...
                   2 2 1;...
                   1 2 1;...
                   3 2 1;...
                   3 3 1];

%% -- Run Spelitting/Train/Test
tic;
[pca_sample] = PcaSampleData(Dataall,test_train_idx,options);
[v_pca] = PcaData_sample(pca_sample,options);
ff = toc;
fprintf('PCA Sampling done in %f min\n',ff/60);
% Main body of method
Apply_test_train_pca;
save_report;