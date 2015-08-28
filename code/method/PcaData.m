function [TrainData_pca,TestData_pca] = PcaData(TrainData,TestData,options)

legcnn = options.legcnn;
numf = size(TrainData,2)/legcnn;

TrainData_pca= zeros(size(TrainData,1),numf*options.rdim);
dispstat ('','init');
for jj =1:numf
%     TrainData1 = TrainData(:,((jj-1)*legcnn+1):(jj*legcnn));
      TrainData1 = TrainData(:,1:legcnn);
      TrainData(:,1:legcnn)=[];
    i=2;
    [feature_pca,~,V] = fsvd(TrainData1, options.rdim,i,true);
    trainpca1 = V;
    
% %     %A2 = U * S * V';
% %     %display(['FSVD POWER Error: ' num2str(compute_error(TrainData1,A2))])
% %     %clear U S V A2;
% %     %tic;
% %     %[feature_pca,trainpca1] = MyPCA(TrainData1,options);
% %     %disp(toc);
% %     %display(['MyPCA Error: ' num2str(compute_error(TrainData1,(feature_pca*trainpca1')))])
% %     %clear feature_pca trainpca1;
% %     %tic;
% %     %[signals,PC, V] = pca2(TrainData1);
% %     %s_r =(signals(:,1:options.rdim)>=0);
% %     %disp(toc);
% %     %display(['MyPCA2 Error: ' num2str(compute_error(TrainData1,(signals*PC')))])
% %     %clear signals PC V;
    dispstat (['Appy PCA Trainset sample [' num2str(jj) ']/' num2str(numf) ]);
    trainpca{jj} = trainpca1;
    TrainData_pca(1:end,((jj-1)*options.rdim)+1:((jj)*options.rdim))= feature_pca;
end

TestData_pca= zeros(size(TestData,1),numf*options.rdim);
for jj =1:numf
%     TestData1 = TestData(:,((jj-1)*legcnn+1):(jj*legcnn));
      TestData1 = TestData(:,1:legcnn);
      TestData(:,1:legcnn)=[];
    testpca = trainpca{jj};
    dispstat (['Appy PCA Testset sample [' num2str(jj) ']/' num2str(numf) ]);
     TestData_pca(1:end,((jj-1)*options.rdim)+1:((jj)*options.rdim))= TestData1*testpca;
end
