function cnn_feature = ComputeFeatures(Dataall,options)

for categorynum =1:length(Dataall)%-------------------------extract feature for whole of dataset
    for vidnum = 1: size(Dataall{categorynum},1)%-------------------------extract feature for each video
        vidnum
        data = Dataall{categorynum}{vidnum};
        [cnn_feature_video] = CnnDescriptor(data,options);
        % [feature_pca] = MyPCA(cnn_feature_pyramid1',options);
        cnn_feature{categorynum,vidnum} = cnn_feature_video;
    end
end