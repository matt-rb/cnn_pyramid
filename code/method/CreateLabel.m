function [train_label,test_label] = CreateLabel(indTrain,indTest)
train_label = indTrain(:,1);
test_label = indTest(:,1);