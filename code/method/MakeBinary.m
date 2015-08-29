function [ trkM ] = MakeBinary(Dataall,test_train_idx, options )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    disp('Make ready CNN features...');
    cnn_feature = ReadyCnnFeature(Dataall,options);
    disp('Spelitting Test/Train Data ...');
    [TestData,TrainData,indTest1,indTrain1] = Splitting(cnn_feature,test_train_idx);
    disp('Make binary Data ...');
    [ normalized_fv, mean_data  ] = NormalizeFeatures( TrainData );
    [ train_bin,itq_rot_mat,pca_mapping ] = train_itq( 20, 5, double(normalized_fv) );
    [ normalized_fv1, ~  ] = NormalizeFeatures( TestData,mean_data);
    [ test_bin ] = test_itq( double(normalized_fv1), itq_rot_mat, pca_mapping );
    disp('---Compuet binary path---');
    [trkM] =  BinaryPath(Dataall,train_bin,test_bin,indTrain1,indTest1,options);
    

end

