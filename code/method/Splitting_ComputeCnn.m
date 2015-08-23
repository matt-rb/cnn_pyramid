function [testPool,trainPool,indTest,indTrain] = Splitting_ComputeCnn(data,test_train_idxs,options)
disp('Extract CNN Features and spliting...');
for categorynum =1:length(data)%-------------------------extract feature for whole of dataset
    for vidnum = 1: size(data{categorynum},1)%-------------------------extract feature for each video
        data1 = data{categorynum}{vidnum};
        [cnn_feature_video] = CnnDescriptor_size(data1,options);
        % [feature_pca] = MyPCA(cnn_feature_pyramid1',options);
        cnn_feature{categorynum,vidnum} = cnn_feature_video;
    end
end

test_idxs= test_train_idxs(test_train_idxs(:,3)==1,1:2);
train_idxs= test_train_idxs(test_train_idxs(:,3)==0,1:2);

for i=1:length(train_idxs)
    pool1(i) = size(cell2mat(cnn_feature(train_idxs(i,1),train_idxs(i,2))),1);
end
%----------------------
S1 =0;%start fill big matrix
trainPool= zeros(sum(pool1),sum(cnn_feature{train_idxs(i,1),train_idxs(i,2)}(1,:)));
indTrain = zeros(sum(pool1),2);
for i=1:length(train_idxs)
    
    data1 = data{train_idxs(i,1)}{train_idxs(i,2)};
    [cnn_feature_video] = CnnDescriptor(data1,options);
    % [feature_pca] = MyPCA(cnn_feature_pyramid1',options);
    trainPool((1+S1):S1+pool1(i),1:end) = cnn_feature_video;
    indTrain((1+S1):S1+pool1(i),1:end) = repmat([train_idxs(i,1),train_idxs(i,2)],[size(cnn_feature_video,1),1]);
    S1 = S1+pool1(i);
    data{train_idxs(i,1)}{train_idxs(i,2)} =[];
end


for i=1:length(test_idxs)
    pool2(i) = size(cell2mat(cnn_feature(test_idxs(i,1),test_idxs(i,2))),1);
end
%----------------------
S1 =0;%start fill big matrix
testPool= zeros(sum(pool2),sum(cnn_feature{test_idxs(i,1),test_idxs(i,2)}(1,:)));
indTest = zeros(sum(pool2),2);
for i=1:length(test_idxs)
    data1 = data{test_idxs(i,1)}{test_idxs(i,2)};
    [cnn_feature_video] = CnnDescriptor(data1,options);
    % [feature_pca] = MyPCA(cnn_feature_pyramid1',options);
    testPool((1+S1):S1+pool2(i),1:end) = cnn_feature_video;
    indTest((1+S1):S1+pool2(i),1:end) = repmat([test_idxs(i,1),test_idxs(i,2)],[size(cnn_feature_video,1),1]);
    S1 = S1+pool2(i);
    data{test_idxs(i,1)}{test_idxs(i,2)} = [];
end



