function [TrainData_pca,TestData_pca] = PcaData(TrainData,TestData,options)

legcnn = options.legcnn;
numf = size(TrainData,2)/legcnn;
TestData_pca = [];
TrainData_pca = [];
for jj =1:numf
    TrainData1 = TrainData(:,((jj-1)*legcnn+1):(jj*legcnn));
    [feature_pca,trainpca1] = MyPCA(TrainData1,options);
    trainpca{jj} = trainpca1;
    TrainData_pca = [TrainData_pca,feature_pca];
end
for jj =1:numf
    TestData1 = TestData(:,((jj-1)*legcnn+1):(jj*legcnn));
    testpca = trainpca{jj};
    pX=TestData1*testpca;
    TestData_pca = [TestData_pca,pX];
end
