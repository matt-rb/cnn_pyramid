function cnn_feature = ReadyCnnFeature(Dataall,options)

for categorynum =1:length(Dataall)%-------------------------extract feature for whole of dataset
    for vidnum = 1: size(Dataall{categorynum},1)%-------------------------extract feature for each video
        
        cnn_feature_video = Dataall{categorynum}{vidnum};  
        cnn_feature{categorynum,vidnum} = cnn_feature_video';
    end
end