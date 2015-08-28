function [acc_lib,acc_linear,acc_linear3,confidence_lib,confidence_linear] = Testing(test_data,test_label,classifiers_lib,classifiers_linear,options)
CC = options.CC;
% classifiers = options.classifiers;
% classifiers_linear = options.classifiers_linear;
%------linear

for k=1:length(CC)
    [acc1,predilted_label,confidence] =CategorizationRateLinear(classifiers_lib{k}, test_data, test_label);
    best_model(k,:)=acc1;
    best_confidence1{k} = confidence(:,:);
end
[acc_lib1,I] = max(best_model);
acc_lib = mean(acc_lib1);
%---best confidence matrix for each category
% for i =1:length(I)    
% confidence_lib(i,:) = best_confidence1{I(i)}(i,:);
% end
confidence_lib = best_confidence1;


for k=1:length(CC)
    
[acc2,confidence_linear2] =CategorizationRate(classifiers_linear{k}, test_data', test_label'); 
best_model2(k,:)=acc2;
confidence_linear1{k} = confidence_linear2;
end
[acc_linear1,I]  = max(best_model2);
acc_linear = mean(acc_linear1);

for i =1:length(I)    
confidence_linear(i,:) = confidence_linear1{I(i)}(i,:);
end

%---

for k=1:3%length(CC)
    
[acc2,confidence_linear3,~] =CategorizationRateOrginal(classifiers_linear{k}, test_data', test_label'); 
accc(k) = acc2;
end
[acc_linear3,I]  = max(accc);
%acc_linear = mean(acc_linear1);

%for i =1:length(I)    
%confidence_linear(i,:) = confidence_linear1{I(i)}(i,:);
%end
