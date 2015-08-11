function [acc, predilted_label ,confidence] =CategorizationRateLinear(classifiers, data, label)
[m n]=size(data');
uLabel=unique(label);
num_of_cat=length(uLabel);
for categorynum =1:num_of_cat
    
    test_label = double(label(:,1)==categorynum);
    [ predilted_label,accuracy,confidence1] = svmpredict(test_label, data,classifiers{categorynum});
    
    if(isempty(accuracy))
        accuracy = 0;
        confidence1(1:length(test_label))=0;
    end
    acc(categorynum) = accuracy(1,1);
    confidence(categorynum,:) = confidence1';
end
% num_test=length(label);
%   stdr=repmat(std(confidence,[],2),1,n);
%  meanr=repmat(mean(confidence,2),1,n);
%   confidence=(confidence-meanr)./(stdr+eps);
%   [max_conf predilted_label]=max(confidence);
%   acc=sum(predilted_label==label')/num_test;
%   acc
%   