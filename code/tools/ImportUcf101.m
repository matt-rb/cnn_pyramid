function [ Dataall ] = ImportUcf101( features_dir, cat_index )
%% IMPORTUCF101 get the directory of individual feature files
% combine all to the standard input format 
%   input:
%       - features_dir : string, root directory of mat files(feats)
%       - cat_index : cell matrix of category index [cat_id, cat_name]
%   output:
%       - Dataall : standard cell format for input features
%                   columns will represent categories and rows in each
%                   column contains a video-sample feats for that category
%%


    vid_feats_names=dir(features_dir);
    Dataall=cell(1,3);
    %Dataall = cell(1,size(cat_index,1));
    cat_counter = ones(size(cat_index,1),1);
    
    for vid_idx=1 : size(vid_feats_names,1)
        if(~(strcmpi(vid_feats_names(vid_idx).name,'.') || strcmpi(vid_feats_names(vid_idx).name,'..') || size(findstr(vid_feats_names(vid_idx).name,'.mat'),1)==0))
            load(fullfile(features_dir,vid_feats_names(vid_idx).name));
            cat_name = {vid_feats_names(vid_idx).name(3:end-16)};
            cat_idx = find(cellfun(@(s) ~isempty(strfind(cat_name{1}, s)), cat_index(:,2)));
            Dataall{1,cat_idx}= [Dataall{1,cat_idx} ; {feat'}];
            cat_counter(cat_idx)= cat_counter(cat_idx)+1;
        end
    end
end

