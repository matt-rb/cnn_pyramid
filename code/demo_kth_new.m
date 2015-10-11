
%% --Setting Configs
clear all;
clc;
option_all;
if exist (fullfile(options.output,options.run_name),'dir')
    rmdir(fullfile(options.output,options.run_name),'s');
end

disp('Setting Up...');
diary on;
%% Expriment Exclusive Setup
options.overlap = 1;
options.trackletlength =16;
options.numClusters =2000;
% options.mode param for ComputeFeaturesForPca
% to compute CNN descriptor use 'cnn'
% to compute FTT descriptor use 'ftt'
options.mode = 'cnn';
% options.pyramidType param for ComputeFeaturesForPca
% to compute subtracted CNN-pyramid descriptor use 'sub'
% to compute max CNN-pyramid descriptor use 'max'
% to compute mean CNN-pyramid descriptor use 'avg'
% to compute sum CNN-pyramid descriptor use 'sum'
% to compute maximum over all CNN-pyramid descriptor use 'maxall'
options.pyramidType = 'sub';

% Set the root directory of video-feature mat files
options.input= fullfile('..','data', 'kth' );
options.output= fullfile(options.output,strrep(datestr(now), ':', '-'));
% options.pcaType for applying PCA
% 'fsvd' : to apply random pca with fsvd
% 'npca' : to apply normal pca
options.pcaType = 'npca';

options.demo_alias = 'kth_new_exp';
report_end = [options.mode '_' options.pyramidType '_' options.pcaType];

disp('Load Data ...');
load (options.kthClassIndexFile);

%% --Import Data
% Read mat feature files and convert to standard input cell format
% and Make the index of imported video features to "Dataall"
disp('Import/Convert Data ...');
tic;
[ Dataall, indexDataall ] = KthImport( options.input, classInd );
ff = toc;
fprintf('Import/Convert Data done in %f min\n',ff/60);
%% --Indexing Test/Train Samples
% Index matrix of test and train samples in following order:
% [category_idx, sample_idx_in_Category, test(1)/train(0)]
disp('Make Test/Train index ...');
test_train_idxs = KthMakeTestTrainIndex( options.kthTestSubjects, indexDataall );


%% --Feature Extraction
disp('Extract Features and PCA sampling...');
tic
% [cnn_feature_size] = ComputeFeaturesForPca(Dataall,options,options.mode);
[cnn_feature_size,pca_sample_all] = ComputeFeaturesForPca_withSampling(Dataall,test_train_idxs,options,options.mode);
ff = toc;
fprintf('Extract Features and PCA sampling done in %f min\n',ff/60);

%% -- Run Spelitting/Train/Test

% Main body of method
accResults = zeros(no_iterations,1);
resultsS= zeros(no_iterations,1);
allKCenters = cell(no_iterations,1);
allPcaData = cell(no_iterations,1);
allConf_line = cell(no_iterations,1);
allConf_lib = cell(no_iterations,1);
run_no = 1;

test_train_idx = test_train_idxs{1,run_no};

disp('Compute PCA data...');
tic;
[v_pca] = PcaData_sample(pca_sample_all{run_no},options);
ff = toc;
fprintf('Compute PCA data done in %f min\n',ff/60);
% Main body of method
Apply_test_train_pca;

accResults(run_no)=acc_orginal;
allKCenters{run_no} = center;
allPcaData{run_no} = v_pca;
allConf_line{run_no} = confusion_linear;

save_report;