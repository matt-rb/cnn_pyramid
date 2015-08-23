function [max_feature] = ComputeFeatures_max(Dataall,options)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    max_feature = cell(length(Dataall), 1);
    for cat_idx=1:(length(Dataall))
        for sample_idx =1: size (Dataall{cat_idx},1)
            max_feature{cat_idx,sample_idx} = max(Dataall{1,cat_idx}{sample_idx}');
        end
    end
    

end

