function [testPool,trainPool,indTest,indTrain] = Splitting_Cnn(test_train_idxs,cnn_feature_size,options)

test_idxs= test_train_idxs(test_train_idxs(:,3)==1,1:2);
train_idxs= test_train_idxs(test_train_idxs(:,3)==0,1:2);
dispstat ('','init');
for i=1:length(train_idxs)
    pool1(i,:) = cnn_feature_size{train_idxs(i,1),train_idxs(i,2)};
end
%----------------------
S1 =0;%start fill big matrix
trainPool= zeros(sum(pool1(:,1)),(pool1(1,2)/options.legcnn)*options.rdim);
indTrain = zeros(sum(pool1(:,1)),2);
for i=1:length(train_idxs)
    Fname1 = ['cat-[' num2str(train_idxs(i,1)) ']-video-[' num2str(train_idxs(i,2))  ']'];
           load([options.output,options.run_name,Fname1],'Data_pca');
%  load([options.output,options.run_name,Fname1],'Data_pca');  
    trainPool((1+S1):S1+pool1(i,1),1:end) = Data_pca;
    indTrain((1+S1):S1+pool1(i,1),1:end) = repmat([train_idxs(i,1),train_idxs(i,2)],[size(Data_pca,1),1]);
    dispstat (['Trainset - Added : ' Fname1]);
    S1 = S1+pool1(i,1);
end

for i=1:length(test_idxs)
    pool2(i,:) = cnn_feature_size{test_idxs(i,1),test_idxs(i,2)};
end
%----------------------
S1 =0;%start fill big matrix
testPool= zeros(sum(pool2(:,1)),(pool1(1,2)/options.legcnn)*options.rdim);
indTest = zeros(sum(pool2(:,1)),2);
for i=1:length(test_idxs)
    Fname1 = ['cat-[' num2str(test_idxs(i,1)) ']-video-[' num2str(test_idxs(i,2))  ']'];
           load([options.output,options.run_name,Fname1],'Data_pca');
    testPool((1+S1):S1+pool2(i,1),1:end) = Data_pca;
    indTest((1+S1):S1+pool2(i,1),1:end) = repmat([test_idxs(i,1),test_idxs(i,2)],[size(Data_pca,1),1]);
    dispstat (['Testset - Added : ' Fname1]);
    S1 = S1+pool2(i,1);
end





