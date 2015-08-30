function [ feats ] = ComputeSpacialFeature( Dataall, indexDataall, options )
% Compute Spacial Feature
%   Detailed explanation goes here

dispstat ('','init');
%% -- Compute Spacial Feature
tic;
all_video_no = length(indexDataall);
pca_sample = zeros(sum(ceil(cell2mat(indexDataall(:,4))/10)), options.legcnn);
current_index=0;
sample_percent = 10;
for sample_idx = 1 : all_video_no
    features_video = Dataall{indexDataall{sample_idx,1}}{indexDataall{sample_idx,2}};
    vid_sample_count = ceil(indexDataall{sample_idx,4}/sample_percent);
    pca_sample(current_index+1:current_index + vid_sample_count,:) = features_video( :, randperm(indexDataall{sample_idx,4},vid_sample_count))';
    current_index = current_index + vid_sample_count;
    dispstat (['Sampling PCA for all video frames [' num2str(sample_idx) ']/[' num2str(all_video_no) ']']);
end
ff = toc;
fprintf('Sampling PCA done in %f min\n',ff/60);

disp('Compute PCA on sampled frames ...');
tic;
[v_pca] = PcaData_sample(pca_sample,options);
ff = toc;
fprintf('Compute PCA done in %f min\n',ff/60);

tic;
Dataall = apply_pca(Dataall, v_pca);
ff = toc;
fprintf('Applying PCA for all frames done in %f min\n',ff/60);

disp('Make data for histogram...');
tic;
[data, data_index] = make_data_ready2hist(Dataall, indexDataall, options);
ff = toc;
fprintf('Make data for histogram done in %f min\n',ff/60);
clear Dataall;

disp('Compute hist-features...');
tic;
[feats] = make_hist( data, data_index, options );
ff = toc;
fprintf('Compute hist-features done in %f min\n',ff/60);


end

function [Dataall] = apply_pca( Dataall, v_pca )
dispstat ('','init');
    for categorynum =1:length(Dataall)
        all_cat_video_no = size(Dataall{categorynum},1);
        for vidnum = 1: all_cat_video_no
            dispstat (['Apply PCA for: cat-[' num2str(categorynum) ']-video-[' num2str(vidnum)  ']/[' num2str(all_cat_video_no) ']']);
            features_video = Dataall{categorynum}{vidnum};
            Dataall{categorynum}{vidnum} = features_video'*v_pca{1};
        end
    end
end

function [data, data_index] = make_data_ready2hist(Dataall, indexDataall , options)
dispstat ('','init');
    data = zeros (sum(cell2mat(indexDataall(:,2))),options.rdim);
    data_index = zeros (sum(cell2mat(indexDataall(:,2))),2);
    last_index =0;
    for categorynum =1:length(Dataall)
        all_cat_video_no = size(Dataall{categorynum},1);
        for vidnum = 1: all_cat_video_no
            dispstat (['Adding data : cat-[' num2str(categorynum) ']-video-[' num2str(vidnum)  ']/[' num2str(all_cat_video_no) ']']);
            features_video = Dataall{categorynum}{vidnum};
            video_frames_count = size(features_video,1);
            data(last_index+1:last_index+video_frames_count,:) = features_video;
            data_index (last_index+1:last_index+video_frames_count,:) = repmat([categorynum,vidnum],video_frames_count,1);
            last_index = last_index+video_frames_count;
        end
    end
end

function [feats] = make_hist( data, data_index, options )

numClusters = options.numClusters;
run(fullfile(options.vl_featPath, 'vl_setup.m'));
addpath(options.pwmetricPath);
dispstat ('','init');
%% ---clustering
dispstat('Clustering apply kmeans...');
[~,NX_train] = Norm2Normalization(data);
 NX_train=single(NX_train');
%[centers, assignments] = vl_kmeans(NX_train, numClusters);
[~, assignments] = vl_kmeans(NX_train, numClusters);
assignments1=assignments';

%% --- make histogram
dispstat('creat Histogram...');
feats = cell(max(data_index(:,1)),1);

%hist_all=[];
%index_hist = [];
for i=1:max(data_index(:,1))
    for j=1:max(data_index(:,2))
        dispstat (['processing Hist: [' num2str(i) '] [' num2str(j) ']' ]);
        ind = find(data_index(:,1)==i&data_index(:,2)==j);
        if(~isempty(ind))
            AA=assignments1(ind);
            hist = histc(AA,1:numClusters);
            feats{i,j} = hist';
            %index_hist(end+1,:) = [i j];
        end
    end
end

end

