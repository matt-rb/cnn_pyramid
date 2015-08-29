function cnn_feature = ComputeFeatures_bin(Dataall,trkM,options)

dispstat ('','init');
cnn_feature = cell(length(Dataall),1);
for categorynum =1:length(Dataall)%-------------------------extract feature for whole of dataset
    all_video_cat_no = size(Dataall{categorynum},1);
    for vidnum = 1: all_video_cat_no%-------------------------extract feature for each video
        trkM2 = trkM{categorynum,vidnum};
        data = Dataall{categorynum}{vidnum};
        [cnn_feature_video] = CnnDescriptor_bin(data,trkM2,options);
        % [feature_pca] = MyPCA(cnn_feature_pyramid1',options);
        cnn_feature{categorynum,vidnum} = cnn_feature_video;
        dispstat (['Computed : video [' num2str(vidnum) ']/[' num2str(all_video_cat_no) '] cat [' num2str(categorynum) ']']);
    end
end