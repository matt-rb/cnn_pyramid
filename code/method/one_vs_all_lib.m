function model = one_vs_all_lib(train_data,train_label,C ,t)

uLabel=unique(train_label);
num_of_cat=length(uLabel);

for categorynum =1:num_of_cat
%      pos_train_idx=find(train_label==uLabel(categorynum));
%         neg_train_idx=find(train_label~=uLabel(categorynum));
% %            num_of_negative_train=255;
% %            neg_train_idx=floor(neg_train_idx(1:(length(neg_train_idx)/num_of_negative_train):end));
%         
%         posneg_train_data=double([train_data(:,pos_train_idx) train_data(:,neg_train_idx)]); % binarized verion of classemes
%         posneg_train_label=[ones(length(pos_train_idx),1); -ones(length(neg_train_idx),1)];
%         N=length(posneg_train_label);
%         Np=sum(posneg_train_label==1);
%         Nn=sum(posneg_train_label==0);
%         d1=  sparse(posneg_train_data);
        
    label = double(train_label(:,1)==categorynum);
    cmd1 = ['-t', num2str(t) '-c ', num2str(C)];
    
    model{categorynum} = svmtrain2(label, train_data,cmd1);
%     classifiers(:,i)=(model{categorynum}.Label(1)).*model{categorynum}.SVs';
end
% classifiers(:,i)=(model.label(1)).*model.w';