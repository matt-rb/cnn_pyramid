

%% --Setting Configs
clear all;
option_all;
disp('Setting Up...');
% Set the root directory of video-feature mat files
disp('Load Data ...');
load (options.youtubeClassIndexFile);

%% --Import Data
% Read mat feature files and convert to standard input cell format
% and Make the index of imported video features to "Dataall"
disp('Import/Convert Data ...');
[ Dataall, indexDataall ] = YoutubeImport( options.youtubeInput, classInd );

%% --Indexing Test/Train Samples
% Index matrix of test and train samples in following order:
% [category_idx, sample_idx_in_Category, test(1)/train(0)]
disp('Make Test/Train index ...');
test_train_idxs = YoutubeMakeTestTrainIndex( options.youtubeSubjects, indexDataall );



%% -- Run Spelitting/Train/Test
results = zeros(options.youtubeSubjects,1);
for run_no=1:options.youtubeSubjects
    % Select test/train sets
    test_train_idx = test_train_idxs{1,run_no};
    
    disp('Spelitting Test/Train Data ...');
    [TestData,TrainData,indTest1,indTrain1] = Splitting(cnn_feature,test_train_idx);
    disp('Make binary Data ...');
    [ normalized_fv, mean_data  ] = NormalizeFeatures( TrainData );
    [ train_bin,itq_rot_mat,pca_mapping ] = train_itq( 20, 5, double(normalized_fv) );
    [ normalized_fv1, ~  ] = normalize_features( TestData,mean_data);
    [ test_bin ] = test_itq( double(normalized_fv1), itq_rot_mat, pca_mapping );
    [trkM] =  BinaryPath(Dataall,train_bin,test_bin,indTrain1,indTest1,options);
    
    % Main body of method
    apply_train_test_bin;

    results(run_no)=acc_orginal;
end