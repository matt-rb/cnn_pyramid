function [acc, confidence] =Categorization_rate(classifiers, data, label)
[m n]= size(data);
nCat = size(classifiers,2);
num_test=length(label);
for i=1:nCat
    labelMatrix(i,:)= -ones(1,n);
    labelMatrix(i,label==i) = 1;
end

%% Accuracy L2-svm %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% confidence= (classifiers'*[data; ones(1,n)]);
% stdr=repmat(std(confidence,[],2),1,n);
% meanr=repmat(mean(confidence,2),1,n);
% confidence=(confidence-meanr)./stdr;

confidence= (classifiers'*[data; ones(1,n)]);
 confidence1 = 2*(confidence>0)-1;


acc(1,:)=(mean(confidence1==labelMatrix,2));