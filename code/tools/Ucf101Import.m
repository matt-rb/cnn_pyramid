function [ Dataall , IndexDataall ] = Ucf101Import( features_dir, cat_index )
%% IMPORTUCF101 get the directory of individual feature files
% combine all to the standard input format 
%   input:
%       - features_dir : string, root directory of mat files(feats)
%       - cat_index : cell matrix of category index [cat_id, cat_name]
%   output:
%       - Dataall : standard cell format for input features
%                   columns will represent categories and rows in each
%                   column contains a video-sample feats for that category
%       - IndexDataall : Cell index of Dataall in following order
%                   [ Category_id, video_index_in_Category , Video_name ]
%%


    vid_feats_names=dir(features_dir);
    Dataall=cell(1,size(cat_index,1));
    IndexDataall=cell(1,4);
    %Dataall = cell(1,size(cat_index,1));
    cat_counter = ones(size(cat_index,1),1);
    video_counter = 1;
    dispstat ('','init');
    for vid_idx=1 : size(vid_feats_names,1)
        if(~(strcmpi(vid_feats_names(vid_idx).name,'.') || strcmpi(vid_feats_names(vid_idx).name,'..')) && size(findstr(vid_feats_names(vid_idx).name,'.mat'),1)>0)
            load(fullfile(features_dir,vid_feats_names(vid_idx).name));
            cat_name = {vid_feats_names(vid_idx).name(3:end-16)};
            cat_idx = find(cellfun(@(s) ~isempty(strmatch(lower(cat_name{1}), lower(s),'exact')), cat_index(:,2)));
            dispstat (['Import sample: [' num2str(video_counter) '] cat: ['  num2str(cat_idx) ']']);
            Dataall{1,cat_idx}= [Dataall{1,cat_idx} ; {feat'}];
            IndexDataall{video_counter,1} = cat_idx;
            IndexDataall{video_counter,2} = cat_counter(cat_idx);
            IndexDataall{video_counter,3} = vid_feats_names(vid_idx).name(1:end-4);
            IndexDataall{video_counter,3} = size(feat,1);
            video_counter = video_counter +1;
            cat_counter(cat_idx)= cat_counter(cat_idx)+1;
         
        end
    end
end

