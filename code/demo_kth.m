
%% --Setting Configs
%clear all;
option_all;
disp('Setting Up...');
% Set the root directory of video-feature mat files
options.input= fullfile('..','data', 'kth' );
disp('Load Data ...');
load (options.kthClassIndexFile);

%% --Import Data
% Read mat feature files and convert to standard input cell format
% and Make the index of imported video features to "Dataall"
disp('Import/Convert Data ...');
[ Dataall, indexDataall ] = KthImport( options.input, classInd );

%% --Indexing Test/Train Samples
% Index matrix of test and train samples in following order:
% [category_idx, sample_idx_in_Category, test(1)/train(0)]
disp('Make Test/Train index ...');
test_train_idx = KthMakeTestTrainIndex( options.kthTestSubjects, indexDataall );


% --Feature Extraction
disp('Extract CNN Features ...');
cnn_feature = ComputeFeatures(Dataall,options);

%% -- Run Spelitting/Train/Test

% Main body of method
apply_train_test;