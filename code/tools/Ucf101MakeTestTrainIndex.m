function [ test_train_idxs ] = Ucf101MakeTestTrainIndex( annotation_file, indexDataall )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    load (annotation_file);
    test_train_idxs = cell(1,3);
    test_train_idx = [];
    for i=1:length(trainlist01)
        parts = strsplit(trainlist01{i}(1:end-4),'/');
        video_name = parts{1,2};
        sample_idx=find(~cellfun('isempty', strfind(indexDataall(:,3), video_name)));
        if size(sample_idx,1) > 0
         test_train_idx = [test_train_idx ; indexDataall{sample_idx(1),1},indexDataall{sample_idx(1),2},0];
        end
    end
    
    for i=1:length(testlist01)
        parts = strsplit(testlist01{i}(1:end-4),'/');
        video_name = parts{1,2};
        sample_idx=find(~cellfun('isempty', strfind(indexDataall(:,3), video_name)));
        if size(sample_idx,1) > 0
            test_train_idx = [test_train_idx ; indexDataall{sample_idx(1),1},indexDataall{sample_idx(1),2},1];
        end
    end
    
    test_train_idxs{1,1} = test_train_idx;
    
        test_train_idx = [];
    for i=1:length(trainlist02)
        parts = strsplit(trainlist02{i}(1:end-4),'/');
        video_name = parts{1,2};
        sample_idx=find(~cellfun('isempty', strfind(indexDataall(:,3), video_name)));
        if size(sample_idx,1) > 0
         test_train_idx = [test_train_idx ; indexDataall{sample_idx(1),1},indexDataall{sample_idx(1),2},0];
        end
    end
    
    for i=1:length(testlist02)
        parts = strsplit(testlist02{i}(1:end-4),'/');
        video_name = parts{1,2};
        sample_idx=find(~cellfun('isempty', strfind(indexDataall(:,3), video_name)));
        if size(sample_idx,1) > 0
            test_train_idx = [test_train_idx ; indexDataall{sample_idx(1),1},indexDataall{sample_idx(1),2},1];
        end
    end
    
    test_train_idxs{1,2} = test_train_idx;
    
        test_train_idx = [];
    for i=1:length(trainlist03)
        parts = strsplit(trainlist03{i}(1:end-4),'/');
        video_name = parts{1,2};
        sample_idx=find(~cellfun('isempty', strfind(indexDataall(:,3), video_name)));
        if size(sample_idx,1) > 0
         test_train_idx = [test_train_idx ; indexDataall{sample_idx(1),1},indexDataall{sample_idx(1),2},0];
        end
    end
    
    for i=1:length(testlist03)
        parts = strsplit(testlist03{i}(1:end-4),'/');
        video_name = parts{1,2};
        sample_idx=find(~cellfun('isempty', strfind(indexDataall(:,3), video_name)));
        if size(sample_idx,1) > 0
            test_train_idx = [test_train_idx ; indexDataall{sample_idx(1),1},indexDataall{sample_idx(1),2},1];
        end
    end
    
    test_train_idxs{1,3} = test_train_idx;

end
