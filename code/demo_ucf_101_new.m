
%% --Setting Configs
%clear all;

disp('Setting Up...');
option_all;
options.overlap = 19;
options.numClusters = 1000;
options.demo_alias = 'ucf101_new';
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

%% --Feature Extraction
disp('Extract CNN Features ...');
[cnn_feature_size] = ComputeFeaturesForPca(Dataall,options);


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
    
    test_train_idx = test_train_idxs{1,run_no};
    [pca_sample] = PcaSampleData(Dataall,test_train_idx,options);
    [v_pca] = PcaData_sample(pca_sample,options);
    
    % Main body of method
    Apply_test_train_pca;
    
    % save results for current iteration
    accResults(run_no)=acc_orginal;
    allKCenters{run_no} = center;
    allPcaData{run_no} = v_pca;
    allConf_line{run_no} = confusion_linear;
    allConf_lib{run_no} = confusion_lib;
end

%% Report
save_report;