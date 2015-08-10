function [testPool,trainPool,indTest,indTrain] = Splitting(data,test_train_idxs)

test_idxs= test_train_idxs(test_train_idxs(:,3)==1,1:2);
train_idxs= test_train_idxs(test_train_idxs(:,3)==0,1:2);

%----------
trainPool=[];
indTrain =[];
for i=1:length(train_idxs)
    trainPool = [trainPool ; cell2mat(data(train_idxs(i,1),train_idxs(i,2)))];
    cellsz = cellfun(@size,data,'uni',false);
    b1 =cell2mat(cellsz(train_idxs(i,1),train_idxs(i,2)));
    indTrain = [indTrain; repmat([train_idxs(i,1),train_idxs(i,2)],[b1(1,1),1])];
end
%----------
testPool=[];
indTest =[];
for i=1:length(test_idxs)
    testPool = [testPool ; cell2mat(data(test_idxs(i,1),test_idxs(i,2)))];
    cellsz = cellfun(@size,data,'uni',false);
    b1 =cell2mat(cellsz(test_idxs(i,1),test_idxs(i,2)));
    indTest = [indTest; repmat([test_idxs(i,1),test_idxs(i,2)],[b1(1,1),1])];
end

