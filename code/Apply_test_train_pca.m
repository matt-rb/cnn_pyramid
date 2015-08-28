
%% --Run Test/Train

% --PCA
disp('Apply PCA ...');
tic
PcaAll(Dataall,v_pca,options);
ff = toc;
fprintf('PCA done in %f min\n',ff/60);

% --Splitting Test/Train Data
disp('Spelitting Test/Train Data ...');
% [TestData,TrainData,indTest1,indTrain1] = Splitting(cnn_feature,test_train_idx);
% [TestData,TrainData,indTest1,indTrain1] = Splitting_ComputeCnn(Dataall,test_train_idx,options);
[testPool,trainPool,indTest1,indTrain1] = Splitting_Cnn(test_train_idx,cnn_feature_size,options);

% --Visul word- create hist for train and test
disp('Creat Histogram ...');
[test_data,train_data,indTest,indTrain,center] = HistFeature(trainPool,testPool,indTrain1,indTest1,options);

% --Create Label 
disp('Creat Test/Train Labels ...');
[train_label,test_label] = CreateLabel(indTrain,indTest);

% --Training
disp('Training ...');
% [classifiers,classifiers_linear] = Traing1(train_data,train_label,options); %--model into options --options.classifiers , options.classifiers_linear
[classifiers_linear] = Traing1(train_data,train_label,options);
% --Testing
disp('Testing ...');
% [acc_lib,acc_linear,acc_orginal,confidence_lib,confidence_linear] = Testing(test_data,test_label,classifiers,classifiers_linear,options);
[acc_orginal,confusion_linear] = Testing1(test_data,test_label,classifiers_linear,options);
% --Evaluation
disp(['Accuracy: ' num2str(acc_orginal)]);
% create_confusion_matrix;

disp('Finito!');
