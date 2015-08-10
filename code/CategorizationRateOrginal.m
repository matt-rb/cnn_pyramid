function [acc, confidence, predilted_label] =Categorization_rate_orginal(classifiers, data, label);
[m n]=size(data);
num_test=length(label);
 %% Accuracy L2-svm %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            confidence= (classifiers'*[data; ones(1,n)]);
            stdr=repmat(std(confidence,[],2),1,n);
            meanr=repmat(mean(confidence,2),1,n);
            confidence=(confidence-meanr)./stdr;
             [max_conf predilted_label]=max(confidence);
             acc=sum(predilted_label==label)/num_test;