
%% --Setting Configs
clear all;
clc;
option_all;
if exist (fullfile(options.output,options.run_name),'dir')
    rmdir(fullfile(options.output,options.run_name),'s');
end

disp('Setting Up...');
diary on;
report_end = 'cnn_max_fsvd';
%% Expriment Exclusive Setup
options.overlap = 19;
options.numClusters =4000;
% options.mode param for ComputeFeaturesForPca
% to compute CNN descriptor use 'cnn'
% to compute FTT descriptor use 'ftt'
options.mode = 'cnn';
% options.pyramidType param for ComputeFeaturesForPca
% to compute subtracted CNN-pyramid descriptor use 'sub'
% to compute max CNN-pyramid descriptor use 'max'
options.pyramidType = 'max';
options.demo_alias = 'ucf101_selected_10Categories';
options.no_class = 10; % number of selected categories ('0' for select all)
% Set the root directory of video-feature mat files
options.input= fullfile(options.input,'ucflimited');
% options.pcaType for applying PCA
% 'fsvd' : to apply random pca with fsvd
% 'npca' : to apply normal pca
options.pcaType = 'fsvd';

disp('Load Data ...');
load(options.ucfClassIndexFile);
if options.no_class > 0
    classInd(options.no_class+1:end,:) = [];
end

%% --Import Data
% Read mat feature files and convert to standard input cell format
% and Make the index of imported video features to "Dataall"
disp('Import/Convert Data ...');
tic;
[ Dataall, indexDataall ] = Ucf101Import( options.input, classInd );
ff = toc;
fprintf('Import/Convert Data done in %f min\n',ff/60);
%% --Indexing Test/Train Samples
% Index matrix of test and train samples in following order:
% [category_idx, sample_idx_in_Category, test(1)/train(0)]
disp('Make Test/Train index ...');
test_train_idxs = Ucf101MakeTestTrainIndex( options.ucfAnnotationFile, indexDataall );

%% --Feature Extraction
disp('Extract CNN Features ...');
tic
[cnn_feature_size] = ComputeFeaturesForPca(Dataall,options,options.mode);
ff = toc;
fprintf('Extract Features done in %f min\n',ff/60);

%% --output results setup
no_iterations = 3;
accResults = zeros(no_iterations,1);
resultsS= zeros(no_iterations,1);
allKCenters = cell(no_iterations,1);
allPcaData = cell(no_iterations,1);
allConf_line = cell(no_iterations,1);
allConf_lib = cell(no_iterations,1);

%% -- Run Spelitting/Train/Test
for run_no=1:no_iterations
    
    disp('Sampling PCA...');
    test_train_idx = test_train_idxs{1,run_no};
    test_train_idx = (test_train_idx((test_train_idx(:,1)>0),:));
    [pca_sample] = PcaSampleData(Dataall,test_train_idx,options);
    [v_pca] = PcaData_sample(pca_sample,options);
    ff = toc;
    fprintf('Sampling PCA done in %f min\n',ff/60);
    % Main body of method
    Apply_test_train_pca;
    
    % save results for current iteration
    accResults(run_no)=acc_orginal;
    allKCenters{run_no} = center;
    allPcaData{run_no} = v_pca;
    allConf_line{run_no} = confusion_linear;
    %allConf_lib{run_no} = confusion_lib;
end

%% Report
save_report;