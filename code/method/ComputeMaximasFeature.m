function [ feats ] = ComputeMaximasFeature( Dataall, indexDataall, options )
% Compute Spacial Feature
%   Detailed explanation goes here
options.maxima_npeaks = 3;
dispstat ('','init');
%% -- Compute Spacial Feature
tic;
all_video_no = length(indexDataall);
%feat_dim = options.legcnn * options.maxima_npeaks;
feats= cell(length(Dataall), 1);
tic;
for sample_idx = 1 : all_video_no
    %feat = zeros(1,feat_dim);
    features_video = Dataall{indexDataall{sample_idx,1}}{indexDataall{sample_idx,2}};
    feat = comp_feats(features_video, options.maxima_npeaks, options);
    %for dim_no = 1: options.legcnn
    %    tt = get_n_peaks(features_video(dim_no,:), options.maxima_npeaks);
    %    feat(((dim_no-1)*options.maxima_npeaks)+1:options.maxima_npeaks*dim_no) = tt;
    %end
    feats{indexDataall{sample_idx,1},indexDataall{sample_idx,2}} = feat;
    dispstat (['Compute Maxima-feature for cat [' num2str(indexDataall{sample_idx,1}) '] video [' num2str(indexDataall{sample_idx,2}) ']']);
end
disp (num2str(toc));

end

function feat = comp_feats(features_video, n_peaks, options)
    feat_dim = options.legcnn * options.maxima_npeaks;
    feat = zeros(1,feat_dim);
    for dim_no = 1: options.legcnn
        [val,idx] = findpeaks(features_video(dim_no,:),'SortStr','descend','minpeakdistance',3,'npeaks',n_peaks);
        maximas = zeros(1,n_peaks);
        if ~isempty(val)
            % make index/value for peaks
            maximas_temp = [idx; val];
            % sort peaks by index
            [~,I]=sort(maximas_temp(1,:));
            % Exclude index row
            maximas(1:length(val)) = maximas_temp(2,I);
        end
        feat(((dim_no-1)*options.maxima_npeaks)+1:options.maxima_npeaks*dim_no) = maximas;
    end
end

function maximas = get_n_peaks(feats_vector, n_peaks)

    % features_video N x dim
    %regmax = imregionalmax(feats_vector);
    %tt = regmax*.feats_vector;
    
    [val,idx] = findpeaks(feats_vector,'SortStr','descend','minpeakdistance',3,'npeaks',n_peaks);
    maximas = zeros(1,n_peaks);
    if ~isempty(val)
        % make index/value for peaks
        maximas_temp = [idx; val];
        % sort peaks by index
        [~,I]=sort(maximas_temp(1,:));
        % Exclude index row
        maximas(1:length(val)) = maximas_temp(2,I);
    end
end
