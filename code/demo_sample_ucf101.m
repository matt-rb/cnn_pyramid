%% --Setting Configs
clear all;
option_all;
disp('Setting Up...');
% Set the root directory of video-feature mat files
options.input= fullfile(options.input,'ucf101sample');
disp('Load Data ...');
load (options.ucfClassIndexFile);

%% --Import Data
% Read mat feature files and convert to standard input cell format
% and Make the index of imported video features to "Dataall"
disp('Import/Convert Data ...');
[ Dataall, IndexDataall ] = Ucf101Import( options.input, classInd );

% --Feature Extraction
disp('Extract CNN Features ...');
cnn_feature = ComputeFeatures(Dataall,options);

%% --Indexing Test/Train Samples
% Index matrix of test and train samples in following order:
% [category_idx, sample_idx_in_Category, test(1)/train(0)]
test_train_idx = [3 1 0;...
                   2 3 0;...
                   2 1 0;...
                   1 1 0;...
                   1 3 0;...
                   2 2 1;...
                   1 2 1;...
                   3 2 1;...
                   3 3 1];

%% -- Run Spelitting/Train/Test
% Main body of method
apply_train_test;