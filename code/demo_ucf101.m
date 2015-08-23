
%% --Setting Configs
%clear all;
option_all;
options.overlap = 10;
disp('Setting Up...');
% Set the root directory of video-feature mat files
options.input= fullfile(options.input,'ucf101');
disp('Load Data ...');
load (options.ucfClassIndexFile);

%% --Import Data
% Read mat feature files and convert to standard input cell format
% and Make the index of imported video features to "Dataall"
disp('Import/Convert Data ...');
[ Dataall, indexDataall ] = Ucf101Import( options.input, classInd );

%% --Indexing Test/Train Samples
% Index matrix of test and train samples in following order:
% [category_idx, sample_idx_in_Category, test(1)/train(0)]
disp('Make Test/Train index ...');
test_train_idxs = Ucf101MakeTestTrainIndex( options.ucfAnnotationFile, indexDataall );

% --Feature Extraction
disp('Extract CNN Features ...');
cnn_feature = ComputeFeatures(Dataall,options);
clear Dataall

results = zeros(3,1);
resultsS= zeros(3,1);
%% -- Run Spelitting/Train/Test
for run_no=1:3
    
    test_train_idx = test_train_idxs{1,run_no};
    % Main body of method
    apply_train_test;
    results(run_no)=acc_orginal;
    resultsS(run_no)=s;
    
end