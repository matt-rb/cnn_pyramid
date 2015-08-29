
%% --Setting Configs
clear all;
clc;

disp('Setting Up...');
% Set the root directory of video-feature mat files
option_all;
options.input= fullfile(options.input,'ucflimited');
diary on;
options.no_class = 10;
options.demo_alias = 'ucf101_max_10Categories';
options.apply_PCA = 0;
%% PCA TYPE
% 'fsvd' : to apply random pca with fsvd
% 'npca' : to apply normal pca
options.pcaType = 'npca';

report_end = ['maxFeatures_NOPCA' options.pcaType];
disp('Load Data ...');
load (options.ucfClassIndexFile);
if options.no_class > 0
    classInd(options.no_class+1:end,:) = [];
end

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
disp('Extract max Features ...');
max_feature = ComputeFeatures_max(Dataall,options);

%% --output results setup
no_iterations = 3;
accResults = zeros(no_iterations,1);
resultsS= zeros(no_iterations,1);
allKCenters = cell(no_iterations,1);
allPcaData = cell(no_iterations,1);
allConf_line = cell(no_iterations,1);
allConf_lib = cell(no_iterations,1);


%% -- Run Spelitting/Train/Test
for run_no=1:3
    
    test_train_idx = test_train_idxs{1,run_no};
    test_train_idx = (test_train_idx((test_train_idx(:,1)>0),:));
    % Main body of method
    apply_train_test_max;
    
    % save results for current iteration
    accResults(run_no)=acc_orginal;
    allConf_line{run_no} = confusion_linear;
    
end

%% Report
save_report;

