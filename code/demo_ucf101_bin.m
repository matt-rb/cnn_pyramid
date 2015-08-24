
%% --Setting Configs
clear all;
option_all;
disp('Setting Up...');
% Set the root directory of video-feature mat files
options.input= fullfile(options.input,'ucftest2');
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

%% -- Run Spelitting/Train/Test
for run_no=1:3
    
    test_train_idx = test_train_idxs{1,run_no};
    % --Splitting Test/Train Data
    disp('Spelitting Test/Train Data ...');
    [TestData,TrainData,indTest1,indTrain1] = Splitting(cnn_feature,test_train_idx);
    
    [ normalized_fv, mean_data  ] = NormalizeFeatures( TrainData );
    [ train_bin,itq_rot_mat,pca_mapping ] = train_itq( 20, 5, double(normalized_fv) );
    [ normalized_fv1, ~  ] = NormalizeFeatures( TestData,mean_data);
    [ test_bin ] = test_itq( double(normalized_fv1), itq_rot_mat, pca_mapping );
    [trkM] =  BinaryPath(Dataall,train_bin,test_bin,indTrain1,indTest1,options);
    % Main body of method
    apply_train_test_bin;
    
end