function [testPool,trainPool,indTest,indTrain] = Splitting(data,test_train_idxs)

test_idxs= test_train_idxs(test_train_idxs(:,3)==1,1:2);
train_idxs= test_train_idxs(test_train_idxs(:,3)==0,1:2);
dispstat ('','init');
for i=1:length(train_idxs)          
        pool1(i) = size(cell2mat(data(train_idxs(i,1),train_idxs(i,2))),1);
end 
%----------------------
S1 =0;%start fill big matrix
trainPool= zeros(sum(pool1),size(cell2mat(data(train_idxs(i,1),train_idxs(i,2))),2));
indTrain = zeros(sum(pool1),2);
for i=1:length(train_idxs)
    trainPool((1+S1):S1+pool1(i),1:end) = cell2mat(data(train_idxs(i,1),train_idxs(i,2)));
    cellsz = cellfun(@size,data,'uni',false);
    b1 =cell2mat(cellsz(train_idxs(i,1),train_idxs(i,2)));
    indTrain((1+S1):S1+pool1(i),1:end) = repmat([train_idxs(i,1),train_idxs(i,2)],[b1(1,1),1]);
    dispstat (['Trainset - Added : [' num2str(i) ']/[' num2str(length(train_idxs)) ']']);
    S1 = S1+pool1(i);
end
%----------
 
for i=1:length(test_idxs)          
        pool2(i) = size(cell2mat(data(test_idxs(i,1),test_idxs(i,2))),1);
end 
%----------------------
S1 =0;%start fill big matrix
testPool= zeros(sum(pool2),size(cell2mat(data(test_idxs(i,1),test_idxs(i,2))),2));
indTest = zeros(sum(pool2),2);
for i=1:length(test_idxs)
    testPool((1+S1):S1+pool2(i),1:end) = cell2mat(data(test_idxs(i,1),test_idxs(i,2)));
    cellsz = cellfun(@size,data,'uni',false);
    b1 =cell2mat(cellsz(test_idxs(i,1),test_idxs(i,2)));
    indTest((1+S1):S1+pool2(i),1:end) = repmat([test_idxs(i,1),test_idxs(i,2)],[b1(1,1),1]);
    dispstat (['Trainset - Added : [' num2str(i) ']/[' num2str(length(test_idxs)) ']']);
     S1 = S1+pool2(i);
end

% %----------
% trainPool=[];
% indTrain =[];
% for i=1:size(train_idxs,1)
%     trainPool = [trainPool ; cell2mat(data(train_idxs(i,1),train_idxs(i,2)))];
%     cellsz = cellfun(@size,data,'uni',false);
%     b1 =cell2mat(cellsz(train_idxs(i,1),train_idxs(i,2)));
%     indTrain = [indTrain; repmat([train_idxs(i,1),train_idxs(i,2)],[b1(1,1),1])];
% end
% %----------
% testPool=[];
% indTest =[];
% for i=1:size(test_idxs,1)
%     testPool = [testPool ; cell2mat(data(test_idxs(i,1),test_idxs(i,2)))];
%     cellsz = cellfun(@size,data,'uni',false);
%     b1 =cell2mat(cellsz(test_idxs(i,1),test_idxs(i,2)));
%     indTest = [indTest; repmat([test_idxs(i,1),test_idxs(i,2)],[b1(1,1),1])];
% end

