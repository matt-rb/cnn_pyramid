
feature_dir ='/Users/mat/Documents/sources/MATLAB/cnn_pyramid/data/input/ucf101sample';
output_dir = '/Users/mat/Documents/sources/MATLAB/cnn_pyramid/data/input/ucf101sample_ss';
index_file='';

load(index_file);
vid_feats_names=dir(feature_dir);

dispstat ('','init');
for vid_idx=1 : size(vid_feats_names,1)
        if(~(strcmpi(vid_feats_names(vid_idx).name,'.') || strcmpi(vid_feats_names(vid_idx).name,'..')) && size(findstr(vid_feats_names(vid_idx).name,'.mat'),1)>0)
        cat_name = {vid_feats_names(vid_idx).name(3:end-16)};
        cat_idx = find(cellfun(@(s) ~isempty(strmatch(lower(cat_name{1}), lower(s),'exact')), classInd(:,2)));
        if cat_idx>0
            dispstat(['copying : ' vid_feats_names(vid_idx).name]);
            copyfile(fullfile(feature_dir,vid_feats_names(vid_idx).name),fullfile(output_dir,vid_feats_names(vid_idx).name));
        end
        end
end
