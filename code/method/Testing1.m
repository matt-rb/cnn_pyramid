function [acc_linear3,confusion] = Testing1(test_data,test_label,classifiers_linear,options)
CC = options.CC;



% for k=1:length(CC)
%     
% [acc2,confidence_linear2] =CategorizationRate(classifiers_linear{k}, test_data', test_label'); 
% best_model2(k,:)=acc2;
% confidence_linear1{k} = confidence_linear2;
% end
% [acc_linear1,I]  = max(best_model2);
% acc_linear = mean(acc_linear1);
% 
% for i =1:length(I)    
% confidence_linear(i,:) = confidence_linear1{I(i)}(i,:);
% end

%---

for k=1:1%length(CC)
    
[acc2,confidence,~] =CategorizationRateOrginal(classifiers_linear{k}, test_data', test_label'); 
accc(k) = acc2;
confusion1 = ConfusionMatix(confidence,test_label);
confall{k} = confusion1;
end
[acc_linear3,I]  = max(accc);
confusion = confall{I};
%acc_linear = mean(acc_linear1);

%for i =1:length(I)    
%confidence_linear(i,:) = confidence_linear1{I(i)}(i,:);
%end
