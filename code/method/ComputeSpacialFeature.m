function [ feats, index_feats ] = ComputeSpacialFeature( Dataall, indexDataall, options )
% Compute Spacial Feature
%   Detailed explanation goes here

dispstat ('','init');
%% -- Compute Spacial Feature
tic;
all_video_no = lenght(indexDataall);
for sample_idx = 1 : all_video_no
    features_video = Dataall{Dataall{sample_idx,1}}{Dataall{sample_idx,2}};
    pca_sample =  [pca_sample ; features_video( randperm(indexDataall{sample_idx,4},ceil(indexDataall{sample_idx,4}/10)),:)];
    dispstat (['Sampling PCA for all video frames [' num2str(sample_idx) ']/[' num2str(all_video_no) ']']);
end
ff = toc;
dispstat(fprintf('Sampling PCA done in %f min\n',ff/60),'keepthis');

dispstat('Compute PCA on sampled frames ...');
tic;
[v_pca] = PcaData_sample(pca_sample,options);
ff = toc;
dispstat(fprintf('Compute PCA done in %f min\n',ff/60),'keepthis');

dispstat('Applying PCA for all frames...');
tic;
Dataall = apply_pca(Dataall, v_pca);
ff = toc;
dispstat(fprintf('Applying PCA for all frames done in %f min\n',ff/60),'keepthis');

dispstat('Make data for histogram...');
tic;
[data, data_index] = make_data_ready2hist(Dataall, indexDataall);
ff = toc;
dispstat(fprintf('Make data for histogram done in %f min\n',ff/60),'keepthis');
clear Dataall;

dispstat('Compute hist-features...');
tic;
[feats, index_feats] = make_hist( data, data_index, options );
ff = toc;
dispstat(fprintf('Compute hist-features done in %f min\n',ff/60),'keepthis');


end

function [Dataall] = apply_pca( Dataall, v_pca )
dispstat ('','init');
    for categorynum =1:length(Dataall)
        all_cat_video_no = size(Dataall{categorynum},1);
        for vidnum = 1: all_cat_video_no
            dispstat (['Apply PCA for: cat-[' num2str(categorynum) ']-video-[' num2str(vidnum)  ']/[' num2str(all_cat_video_no) ']']);
            features_video = Dataall{categorynum}{vidnum};
            Dataall{categorynum}{vidnum} = features_video*v_pca;
        end
    end
end

function [data, data_index] = make_data_ready2hist(Dataall, indexDataall)
dispstat ('','init');
    data = zeros (sum(cell2mat(indexDataall(:,2))),options.rdim);
    data_index = zeros (sum(cell2mat(indexDataall(:,2))),2);
    last_index =1;
    for categorynum =1:length(Dataall)
        all_cat_video_no = size(Dataall{categorynum},1);
        for vidnum = 1: all_cat_video_no
            dispstat (['Apply PCA for: cat-[' num2str(categorynum) ']-video-[' num2str(vidnum)  ']/[' num2str(all_cat_video_no) ']']);
            features_video = Dataall{categorynum}{vidnum};
            data(last_index:last_index+size(features_video,1),:) = features_video;
            data_index (last_index:last_index+size(features_video,1),:) = repmat([categorynum,vidnum],size(features_video,1),1);
            last_index = last_index+size(features_video,1);
        end
    end
end

function [hist_all, index_hist] = make_hist( data, data_index, options )

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
hist_all=[];
index_hist = [];
for i=1:max(data_index(:,1))
    for j=1:max(data_index(:,2))
        dispstat (['processing Hist: [' num2str(i) '] [' num2str(j) ']' ]);
        ind = find(data_index(:,1)==i&data_index(:,2)==j);
        if(~isempty(ind))
            AA=assignments1(ind);
            hist_all(end+1,:) = histc(AA,1:numClusters);
            index_hist(end+1,:) = [i j];
        end
    end
end

end

