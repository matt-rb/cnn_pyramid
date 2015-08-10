for i=1:15
confusion1 = ConfusionMatix(confidence_lib{i},test_label);
 D = diag(confusion1);
 s(i) = mean(D);
 max(s);
end
confusion2 = ConfusionMatix(confidence_linear,test_label);
 D = diag(confusion2);
 s = mean(D)