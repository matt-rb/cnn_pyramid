function [TrainData_pca,TestData_pca] = PcaData(TrainData,TestData,options)

legcnn = options.legcnn;
numf = size(TrainData,2)/legcnn;
TestData_pca = [];
TrainData_pca = [];
for jj =1:numf
    TrainData1 = TrainData(:,((jj-1)*legcnn+1):(jj*legcnn));
    %tic;
    %i=2;
    [feature_pca,S,V] = fsvd(TrainData1, options.rdim);
    trainpca1 = V;
    %disp(toc);
    %A2 = U * S * V';
    %display(['FSVD POWER Error: ' num2str(compute_error(TrainData1,A2))])
    %clear U S V A2;
    %tic;
    %[feature_pca,trainpca1] = MyPCA(TrainData1,options);
    %disp(toc);
    %display(['MyPCA Error: ' num2str(compute_error(TrainData1,(feature_pca*trainpca1')))])
    %clear feature_pca trainpca1;
    %tic;
    %[signals,PC, V] = pca2(TrainData1);
    %s_r =(signals(:,1:options.rdim)>=0);
    %disp(toc);
    %display(['MyPCA2 Error: ' num2str(compute_error(TrainData1,(signals*PC')))])
    %clear signals PC V;
    trainpca{jj} = trainpca1;
    TrainData_pca = [TrainData_pca,feature_pca];
end
for jj =1:numf
    TestData1 = TestData(:,((jj-1)*legcnn+1):(jj*legcnn));
    testpca = trainpca{jj};
    pX=TestData1*testpca;
    TestData_pca = [TestData_pca,pX];
end
