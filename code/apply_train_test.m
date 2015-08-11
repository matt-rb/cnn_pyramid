
%%% ----- Run Test/Train
disp('Spelitting Test/Train Data ...');
[TestData,TrainData,indTest1,indTrain1] = Splitting(cnn_feature,test_train_idxs);

%% --PCA
disp('Apply PCA ...');
[train_sample,test_sample] = PcaData(TrainData,TestData,options);

%% --visul word- create hist for train and test
disp('Creat Histogram ...');
[test_data,train_data,indTest,indTrain] = HistFeature(train_sample,test_sample,indTrain1,indTest1,options);

%% --create label 
disp('Creat Test/Train Labels ...');
[train_label,test_label] = CreateLabel(indTrain,indTest);

%% --Training
disp('Training ...');
[classifiers,classifiers_linear] = Traing(train_data,train_label,options); %--model into options --options.classifiers , options.classifiers_linear

%% -- testing
disp('Testing ...');
[acc_lib,acc_linear,acc_orginal,confidence_lib,confidence_linear] = Testing(test_data,test_label,classifiers,classifiers_linear,options);

%% --confusion
disp(['Accuracy: ' num2str(acc_orginal)]);
create_confusion_matrix;

disp('Finito!');