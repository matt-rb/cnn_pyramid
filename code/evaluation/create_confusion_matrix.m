for i=1:15
confusion_lib = ConfusionMatix(confidence_lib{i},test_label);
 D = diag(confusion_lib);
 s(i) = mean(D);
 max(s);
end
confusion_linear = ConfusionMatix(confidence_linear,test_label);
 D = diag(confusion_linear);
 acc_linear = mean(D);
 
 disp(['S: ' num2str(acc_linear)]);