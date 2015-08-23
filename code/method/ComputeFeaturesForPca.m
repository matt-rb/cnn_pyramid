function [cnn_feature_size] = ComputeFeaturesForPca(Dataall,options)
for categorynum =1:length(Dataall)%-------------------------extract feature for whole of dataset
    for vidnum = 1: size(Dataall{categorynum},1)%-------------------------extract feature for each video
        data = Dataall{categorynum}{vidnum};
        [cnn_feature_video] = CnnDescriptor(data,options);
        % [feature_pca] = MyPCA(cnn_feature_pyramid1',options);
        %         cnn_feature{categorynum,vidnum} = cnn_feature_video;
        Fname1 = ['cat-[' num2str(categorynum) ']-video-[' num2str(vidnum)  ']'];
        mkdir(options.output,options.run_name);
        save([options.output,options.run_name,Fname1],'cnn_feature_video')
        %---------------------size of cell
        %         [cnn_feature_video] = CnnDescriptor_size(data,options);
        % [feature_pca] = MyPCA(cnn_feature_pyramid1',options);
        cnn_feature_size{categorynum,vidnum} = [size(cnn_feature_video,1),size(cnn_feature_video,2)];

    end
end