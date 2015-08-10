function classifiers=one_vs_all(train_data,train_label,c,norm, options)
addpath(options.liblinearPatch)
if nargin<4
    norm=2;
end
uLabel=unique(train_label);
num_of_cat=length(uLabel);

for i=1:num_of_cat
        pos_train_idx=find(train_label==uLabel(i));
        neg_train_idx=find(train_label~=uLabel(i));
%            num_of_negative_train=255;
%            neg_train_idx=floor(neg_train_idx(1:(length(neg_train_idx)/num_of_negative_train):end));
        
        posneg_train_data=double([train_data(:,pos_train_idx) train_data(:,neg_train_idx)]); % binarized verion of classemes
        posneg_train_label=[ones(length(pos_train_idx),1); -ones(length(neg_train_idx),1)];
        N=length(posneg_train_label);
        Np=sum(posneg_train_label==1);
        Nn=sum(posneg_train_label==-1);
       %% L2-svm %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       if norm==2
             opt1 = ['-q -B 1 -c ' num2str(c) ' -s 3 -w-1 ' num2str((1/Nn)) ' -w1 ' num2str(1/Np)];
%            opt1 = ['-q -B 1 -c ' num2str(c) ' -s 2 '];
%            opt1 = ['-q -B 1 -c ' num2str(c) ' -s 2 -w-1 ' num2str((Np/N)) ' -w1 ' num2str(Nn/N)];

       else
           opt1 = ['-q -B 1 -c ' num2str(c) ' -s 6 -w-1 ' num2str((Np/N)) ' -w1 ' num2str(Nn/N)];
       end
        %tic;
        model = train(posneg_train_label,sparse(posneg_train_data),opt1,'col');
        %time_learning_L2(i)=toc;
        
         classifiers(:,i)=(model.Label(1)).*model.w';
        %b_L2(i)=model.w(end);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
end
