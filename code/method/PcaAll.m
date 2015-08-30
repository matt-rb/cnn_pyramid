function PcaAll(Dataall,v_pca,options)
if ~exist (fullfile(options.output,options.run_name),'dir')
    mkdir(options.output,options.run_name);
end
dispstat ('','init');
for categorynum =1:length(Dataall)%-------------------------extract feature for whole of dataset
    for vidnum = 1: size(Dataall{categorynum},1)%-------------------------extract feature for each video
        
        Fname1 = ['cat-[' num2str(categorynum) ']-video-[' num2str(vidnum)  ']'];
        load(fullfile(options.output,options.run_name,Fname1),'cnn_feature_video');
        dispstat (['Apply PCA for: ' Fname1]);
        numf = size(cnn_feature_video,2)/options.legcnn;
        Data_pca = zeros(size(cnn_feature_video,1), numf*options.rdim);
        %Data_pca = [];
        for jj =1:numf
            %pX=cnn_feature_video(:,((jj-1)*options.legcnn+1):(jj*options.legcnn))*v_pca{jj};
            %Data_pca = [Data_pca,cnn_feature_video(:,((jj-1)*options.legcnn+1):(jj*options.legcnn))*v_pca{jj}];
            Data_pca(:,(jj-1)*options.rdim+1:options.rdim*jj) = cnn_feature_video(:,((jj-1)*options.legcnn+1):(jj*options.legcnn))*v_pca{jj};
        end
        Fname1 = ['cat-[' num2str(categorynum) ']-video-[' num2str(vidnum)  ']'];
        save(fullfile(options.output,options.run_name,Fname1),'cnn_feature_video','Data_pca')
    end
end