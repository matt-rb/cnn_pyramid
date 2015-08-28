%% --Run Test/Train

% --Splitting Test/Train Data
disp('Spelitting Test/Train Data ...');
[TestData,TrainData,indTest1,indTrain1] = Splitting(max_feature,test_train_idx);

% --PCA
if apply_PCA        
    disp('Apply PCA ...');
    [TrainData_pca,TestData_pca] = PcaData(TrainData,TestData,options);
end


% --Create Label 
disp('Creat Test/Train Labels ...');
[train_label,test_label] = CreateLabel(indTrain1,indTest1);

% --Training
disp('Training ...');
[classifiers_linear] = Traing1(TrainData,train_label,options);
% --Testing
disp('Testing ...');
[acc_orginal] = Testing1(TestData,test_label,classifiers_linear,options);
% --Evaluation
disp(['Accuracy: ' num2str(acc_orginal)]);
% create_confusion_matrix;

disp('Finito!');