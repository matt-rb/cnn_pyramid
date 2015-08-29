
%% --Run Test/Train

tic;
disp('Compute features')
cnn_feature_bin = ComputeFeatures_bin(Dataall,trkM,options);
ff = toc;
fprintf('Compute features done in %f min\n',ff/60);

% --Splitting Test/Train Data
disp('Spelitting Test/Train Data ...');
tic;
[TestData,TrainData,indTest1,indTrain1] = Splitting(cnn_feature_bin,test_train_idx);
ff = toc;
fprintf('Spelitting done in %f min\n',ff/60);

% --PCA
disp('Apply PCA ...');
tic;
[train_sample,test_sample] = PcaData(TrainData,TestData,options);
ff = toc;
fprintf('Apply PCA done in %f min\n',ff/60);

% --Visul word- create hist for train and test
disp('Creat Histogram ...');
[test_data,train_data,indTest,indTrain,center] = HistFeature(train_sample,test_sample,indTrain1,indTest1,options);

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
