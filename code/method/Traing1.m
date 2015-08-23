function [classifiers_linear] = Traing1(train_data,train_label,options)
%--classifiers{length(CC)}{category}% for k=1:length(CC)
%     disp(['processing k '  num2str(k)])
%     C=CC(k);
%     classifiers_lib{k} = one_vs_all_lib(train_data,train_label,C ,t);
% end

%%--options.classifiers   options.classifiers_linear;

CC = options.CC;
for k=1:length(CC)
    disp(['processing k '  num2str(k)])
    C=CC(k);
    classifiers_linear{k} = one_vs_all(train_data',train_label',C ,2, options);
end

