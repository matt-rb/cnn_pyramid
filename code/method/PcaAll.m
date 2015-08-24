function PcaAll(Dataall,v_pca,options)
for categorynum =1:length(Dataall)%-------------------------extract feature for whole of dataset
    for vidnum = 1: size(Dataall{categorynum},1)%-------------------------extract feature for each video
        Data_pca = [];
        Fname1 = ['cat-[' num2str(categorynum) ']-video-[' num2str(vidnum)  ']'];
        load([options.output,options.run_name,Fname1],'cnn_feature_video');
        
        numf = size(cnn_feature_video,2)/options.legcnn;
        for jj =1:numf
            pX=cnn_feature_video(:,((jj-1)*options.legcnn+1):(jj*options.legcnn))*v_pca{jj};
            Data_pca = [Data_pca,cnn_feature_video(:,((jj-1)*options.legcnn+1):(jj*options.legcnn))*v_pca{jj}];
        end
        Fname1 = ['cat-[' num2str(categorynum) ']-video-[' num2str(vidnum)  ']'];
        mkdir(options.output,options.run_name);
        save([options.output,options.run_name,Fname1],'cnn_feature_video','Data_pca')
    end
end