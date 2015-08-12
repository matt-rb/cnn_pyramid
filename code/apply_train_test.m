
%% --Run Test/Train

% --Feature Extraction
disp('Extract CNN Features ...');
cnn_feature = ComputeFeatures(Dataall,options);

% --Splitting Test/Train Data
disp('Spelitting Test/Train Data ...');
[TestData,TrainData,indTest1,indTrain1] = Splitting(cnn_feature,test_train_idx);

% --PCA
disp('Apply PCA ...');
[train_sample,test_sample] = PcaData(TrainData,TestData,options);

% --Visul word- create hist for train and test
disp('Creat Histogram ...');
[test_data,train_data,indTest,indTrain] = HistFeature(train_sample,test_sample,indTrain1,indTest1,options);

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