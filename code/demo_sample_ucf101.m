%% --setting configs
clear all;
option_all;
disp('Setting Up...');
options.input='../data/input/ucf101sample';
disp('Load Data ...');
load (options.ucfClassIndexFile);
disp('Import/Convert Data ...');
[ Dataall ] = ImportUcf101( options.input, classInd );

%% --feature extraction
disp('Extract CNN Features ...');
cnn_feature = ComputeFeatures(Dataall,options);

%% --splitting
% test_train_idxs matrix [category_idx, sample_idx, test(1)/train(0)]
test_train_idxs = [3 1 0;...
                   2 3 0;...
                   2 1 0;...
                   1 1 0;...
                   1 3 0;...
                   2 2 1;...
                   1 2 1;...
                   3 2 1;
                   3 3 1];         
apply_train_test;