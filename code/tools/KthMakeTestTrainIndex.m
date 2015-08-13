function [ test_train_idxs ] = KthMakeTestTrainIndex( test_subjects, indexDataall )
%UNTITLED2 Summary of this function goes here
%   test_train_idxs = [category_idx, sample_idx_in_Category, test(1)/train(0)]
    test_train_idxs = zeros(size(indexDataall,1),3);
    
    for i=1:size(indexDataall,1)
        subject_no = str2num(indexDataall{i,3}(7:8));
        test_train_idxs(i,1) = indexDataall{i,1};
        test_train_idxs(i,2) = indexDataall{i,2};
        if (find(test_subjects == subject_no))
            test_train_idxs(i,3) = 1;
        else
            test_train_idxs(i,3) = 0;
        end
    end
end

