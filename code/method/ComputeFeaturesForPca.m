function [cnn_feature_size] = ComputeFeaturesForPca(Dataall,options,mode)

if ~exist (fullfile(options.output,options.run_name),'dir')
    mkdir(options.output,options.run_name);
end

if strcmp(mode,'cnn')
    if ~isfield(options,'pyramidType')
        options.pyramidType = 'sub';
    end
    disp(['extract cnn-' options.pyramidType])
else
    disp(['extract ' mode])
end

dispstat ('','init');
cnn_feature_size = cell(length(Dataall),1);
for categorynum =1:length(Dataall)%-------------------------extract feature for whole of dataset
    for vidnum = 1: size(Dataall{categorynum},1)%-------------------------extract feature for each video
        data = Dataall{categorynum}{vidnum};
        if strcmp(mode, 'cnn')
            [cnn_feature_video] = CnnDescriptor(data,options);
        else
            [cnn_feature_video] = CnnDescriptor_FFT(data,options);
        end
        % [feature_pca] = MyPCA(cnn_feature_pyramid1',options);
        %         cnn_feature{categorynum,vidnum} = cnn_feature_video;
        Fname1 = ['cat-[' num2str(categorynum) ']-video-[' num2str(vidnum)  ']'];
        dispstat (['Computed : ' Fname1]);
        save([options.output,options.run_name,Fname1],'cnn_feature_video')
        %---------------------size of cell
        %         [cnn_feature_video] = CnnDescriptor_size(data,options);
        % [feature_pca] = MyPCA(cnn_feature_pyramid1',options);
        cnn_feature_size{categorynum,vidnum} = [size(cnn_feature_video,1),size(cnn_feature_video,2)];

    end
end