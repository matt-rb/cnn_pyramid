function [pca_sample] = PcaSampleData(Dataall,test_train_idx,options)
pca_sample = [];
disp('PCA Sampling');
dispstat ('','init');
% train_idxs= test_train_idx(test_train_idx(:,3)==0,1:2);
for categorynum =1:length(Dataall)%-------------------------extract feature for whole of dataset
    for vidnum = 1: size(Dataall{categorynum},1)%-------------------------extract feature for each video
        if(test_train_idx(test_train_idx(:,1)==categorynum&test_train_idx(:,2)==vidnum,3)==0)
        Fname1 = ['cat-[' num2str(categorynum) ']-video-[' num2str(vidnum)  ']'];
        dispstat (['Loading : cat-[' num2str(categorynum) ']-video-[' num2str(vidnum)  ']']);
        load([options.output,options.run_name,Fname1],'cnn_feature_video');
        pca_sample = [pca_sample; cnn_feature_video( randperm(size(cnn_feature_video,1),ceil(size(cnn_feature_video,1)/options.overlap)),:)];
        end
        dispstat (['PCA Sample video_No: ' num2str(vidnum) '/' num2str(size(Dataall{categorynum},1)) '- Cat_no: '  num2str(categorynum)])
    end
end