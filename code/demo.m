%%%% setting configs
clear all;
option_all;
load_data;
%%--feature extraction
cnn_feature = ComputeFeatures(Dataall,options);
%--splitting
test_train_idxs = [1 2 1;...
                   2 2 1;...
                   3 3 1;...
                   1 1 0;...
                   2 1 0;...
                   3 1 0;...
                   3 2 0];
         
[TestData,TrainData,indTest1,indTrain1] = Splitting(cnn_feature,test_train_idxs);
%%--PCA
[train_sample,test_sample] = PcaData(TrainData,TestData,options);
%--visul word- create hist for train and test
[test_data,train_data,indTest,indTrain] = HistFeature(train_sample,test_sample,indTrain1,indTest1,options);


%--create label 
[train_label,test_label] = CreateLabel(indTrain,indTest);
%------Training
[classifiers,classifiers_linear] = Traing(train_data,train_label,options); %--model into options --options.classifiers , options.classifiers_linear
%-- testing
[acc_lib,acc_linear,acc_orginal,confidence_lib,confidence_linear] = Testing(test_data,test_label,classifiers,classifiers_linear,options);
%------confusion
acc_orginal
create_confusion_matrix;
 