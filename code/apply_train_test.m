
%% --Run Test/Train

% --Splitting Test/Train Data
disp('Spelitting Test/Train Data ...');
% [TestData,TrainData,indTest1,indTrain1] = Splitting(cnn_feature,test_train_idx);
[TestData,TrainData,indTest1,indTrain1] = Splitting_ComputeCnn(Dataall,test_train_idx,options);
% --PCA
disp('Apply PCA ...');
tic
[train_sample,test_sample] = PcaData(TrainData,TestData,options);
ff = toc;
clear TestData TrainData;
% --Visul word- create hist for train and test
disp('Creat Histogram ...');
[test_data,train_data,indTest,indTrain] = HistFeature(train_sample,test_sample,indTrain1,indTest1,options);

clear train_sample test_sample;
% --Create Label 
disp('Creat Test/Train Labels ...');
[train_label,test_label] = CreateLabel(indTrain,indTest);

% --Training
disp('Training ...');
[classifiers,classifiers_linear] = Traing(train_data,train_label,options); %--model into options --options.classifiers , options.classifiers_linear

% --Testing
disp('Testing ...');
[acc_lib,acc_linear,acc_orginal,confidence_lib,confidence_linear] = Testing(test_data,test_label,classifiers,classifiers_linear,options);

% --Evaluation
disp(['Accuracy: ' num2str(acc_orginal)]);
create_confusion_matrix;

disp('Finito!');
