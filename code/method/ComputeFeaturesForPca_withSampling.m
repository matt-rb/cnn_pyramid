function [cnn_feature_size,pca_sample_all] = ComputeFeaturesForPca_withSampling(Dataall,test_train_idxs,options,mode)
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
pca_sample_all= cell(3,1);
for categorynum =1:length(Dataall)%-------------------------extract feature for whole of dataset
    for vidnum = 1: size(Dataall{categorynum},1)%-------------------------extract feature for each video
              data = Dataall{categorynum}{vidnum};
        if strcmp(mode, 'cnn')
            [cnn_feature_video] = CnnDescriptor(data,options);
        else
            [cnn_feature_video] = CnnDescriptor_FFT(data,options);
        end
        %%---cat_feats{vidnum} = cnn_feature_video;
        % [feature_pca] = MyPCA(cnn_feature_pyramid1',options);
        %         cnn_feature{categorynum,vidnum} = cnn_feature_video;
        Fname1 = ['cat-[' num2str(categorynum) ']-video-[' num2str(vidnum)  ']'];
        dispstat (['Computed : ' Fname1]);
        save(fullfile(options.output,options.run_name,Fname1),'cnn_feature_video')
        %---------------------size of cell
        %         [cnn_feature_video] = CnnDescriptor_size(data,options);
        % [feature_pca] = MyPCA(cnn_feature_pyramid1',options);
        cnn_feature_size{categorynum,vidnum} = [size(cnn_feature_video,1),size(cnn_feature_video,2)];
        for i=1:3
            pca_sample= get_pca_sample( test_train_idxs{i}, cnn_feature_video, categorynum,vidnum,options.overlap);
            if size(pca_sample,2)>0
                pca_sample_all{i} = [pca_sample_all{i}; pca_sample];
            end
        end
        
    end
end
end
function [ pca_sample ] = get_pca_sample( test_train_idx, cnn_feature_video, categorynum,vidnum, overlap )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
test_train_idx = (test_train_idx((test_train_idx(:,1)>0),:));
pca_sample=[];
if(test_train_idx(test_train_idx(:,1)==categorynum&test_train_idx(:,2)==vidnum,3)==0)
    pca_sample =  cnn_feature_video( randperm(size(cnn_feature_video,1),ceil(size(cnn_feature_video,1)/overlap)),:);
end
end