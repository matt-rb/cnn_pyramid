function cnn_feature = ComputeFeatures_bin(Dataall,trkM,options)

for categorynum =1:length(Dataall)%-------------------------extract feature for whole of dataset
    for vidnum = 1: size(Dataall{categorynum},1)%-------------------------extract feature for each video
        trkM2 = trkM{categorynum,vidnum};
        data = Dataall{categorynum}{vidnum};
        [cnn_feature_video] = cnndescriptor_bin(data,trkM2,options);
        % [feature_pca] = MyPCA(cnn_feature_pyramid1',options);
        cnn_feature{categorynum,vidnum} = cnn_feature_video;
    end
end