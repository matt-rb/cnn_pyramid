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
    features_video = Dataall{indexDataall{sample_idx,1}}{indexDataall{sample_idx,2}};
    feat = comp_feats_old(features_video, options.maxima_npeaks, options);
    feats{indexDataall{sample_idx,1},indexDataall{sample_idx,2}} = feat;
    dispstat (['Compute Maxima-feature for cat [' num2str(indexDataall{sample_idx,1}) '] video [' num2str(indexDataall{sample_idx,2}) ']']);
end
disp (num2str(toc));

end

function feat = comp_feats_old(features_video, n_peaks, options)
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

function feats_filtered = apply_gaussian (features_video)
    sigma = 5;
    size = 30;
    x = linspace(-size / 2, size / 2, size);
    gaussFilter = exp(-x .^ 2 / (2 * sigma ^ 2));
    gaussFilter = gaussFilter / sum (gaussFilter); % normalize
    feats_filtered = conv2 (features_video, gaussFilter, 'same');
end

function feat = comp_feats(feats_vector, n_peaks, options)
    % features_video N x dim
    feats_filtered = apply_gaussian (feats_vector);
    regmax = imregionalmax(feats_filtered);
    tt = regmax.*feats_vector;
    [val,ind]=sort(tt,2,'descend');
    val = val(:,1:n_peaks);
    ind = ind(:,1:n_peaks);
    [val_s, ind_s] = sort(ind,2);

    for i=1: size(feats_vector,1)
        val_s(i,:)= val(i, ind_s(i,:));
    end
    feat = reshape(val_s',1,options.legcnn*n_peaks);
end
