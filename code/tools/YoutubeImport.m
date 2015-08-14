function [ Dataall , IndexDataall ] = YoutubeImport( features_dir, cat_index )
%% YoutubeImport get the directory of categories feature files
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
    video_counter = 1;
    for cat_no=1 : size(cat_index,1)
        load(fullfile(features_dir,['kth_feats_' cat_index{cat_no,2} '.mat']));
        Dataall{1,cat_no}=all_feats;
        for video_idx=1 : length(all_feats)
            IndexDataall{video_counter,1} = cat_no;
            IndexDataall{video_counter,2} = video_idx;
            IndexDataall{video_counter,3} = FList{video_idx};
            video_counter = video_counter +1;
        end
    end
end

