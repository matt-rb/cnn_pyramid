function [ Dataall , IndexDataall ] = YoutubeImport( features_dir, cat_index )
%% IMPORTUCF101 get the directory of categories feature files
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


    Dataall=cell(1,3);
    IndexDataall=cell(1,3);
    cat_counter = ones(size(cat_index,1),1);
    video_counter = 1;
    for cat_no=1 : size(cat_index,1)
        load(fullfile(features_dir,['youtube_feats_' cat_index{cat_no,2} '.mat']));
        cat_name = {feats_names(f_idx).name(3:end-16)};
        cat_idx = find(cellfun(@(s) ~isempty(strfind(cat_name{1}, s)), cat_index(:,2)));
        Dataall{1,cat_idx}= [Dataall{1,cat_idx} ; {feat'}];
        IndexDataall{video_counter,1} = cat_idx;
        IndexDataall{video_counter,2} = cat_counter(cat_idx);
        IndexDataall{video_counter,3} = [feats_names(f_idx).name(1:end-4)];
        video_counter = video_counter +1;
        cat_counter(cat_idx)= cat_counter(cat_idx)+1;
    end
end

