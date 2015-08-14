function [ test_train_idxs ] = YoutubeMakeTestTrainIndex( subjects_count, indexDataall )
%% YoutubeMakeTestTrainIndex make index for test/train sets
%   -input:
%       subjects_no : number of subjects in dataset
%       indexDataall : Cell index of Dataall in following order
%                      [Category_id, video_index_in_Category , Video_name]
%   -output: 
%       test_train_idxs: matrix of test/train set indexes in following order
%       [category_idx, sample_idx_in_Category, test(1)/train(0)]
%%

test_train_idxs = cell(1, subjects_count);

for set_no=1:subjects_count
    test_train_idx = zeros(size(indexDataall,1),3);
    for i=1:size(indexDataall,1)
        subject_no = str2double(indexDataall{i,3}(end-8:end-7));
        test_train_idx(i,1) = indexDataall{i,1};
        test_train_idx(i,2) = indexDataall{i,2};
        if (find(subject_no == set_no))
            test_train_idx(i,3) = 1;
        else
            test_train_idx(i,3) = 0;
        end
    end
    test_train_idxs{1,set_no}=test_train_idx;
end

end

