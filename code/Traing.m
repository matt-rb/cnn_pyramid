function [classifiers_lib,classifiers_linear] = Traing(train_data,train_label,options)
%--classifiers{length(CC)}{category}
%%--options.classifiers   options.classifiers_linear;
CC = options.CC;
t = options.t;
for k=1:length(CC)
    disp(['processing k '  num2str(k)])
    C=CC(k);
    classifiers_lib{k} = one_vs_all_lib(train_data,train_label,C ,t);
end

CC = options.CC;
t = options.t;
for k=1:length(CC)
    disp(['processing k '  num2str(k)])
    C=CC(k);
    classifiers_linear{k} = one_vs_all(train_data',train_label',C ,1, options);
end

