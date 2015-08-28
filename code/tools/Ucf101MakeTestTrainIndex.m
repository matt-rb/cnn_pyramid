function [ test_train_idxs ] = Ucf101MakeTestTrainIndex( annotation_file, indexDataall )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    dispstat ('','init');
    load (annotation_file);
    test_train_idxs = cell(1,3);
    test_train_idx = zeros(length(trainlist01)+length(testlist01),3);
    for i=1:length(trainlist01)
        parts = strsplit(trainlist01{i}(1:end-4),'/');
        video_name = parts{1,2};
        sample_idx=find(~cellfun('isempty', strfind(indexDataall(:,3), video_name)));
        if size(sample_idx,1) > 0
         test_train_idx(i,:) = [indexDataall{sample_idx(1),1},indexDataall{sample_idx(1),2},0];
        end
        dispstat (['Trainset [1] sample: [' num2str(i) ']/' num2str(length(trainlist01))]);
    end
    offset = length(trainlist01);
    
    for i=1:length(testlist01)
        parts = strsplit(testlist01{i}(1:end-4),'/');
        video_name = parts{1,2};
        sample_idx=find(~cellfun('isempty', strfind(indexDataall(:,3), video_name)));
        if size(sample_idx,1) > 0
            test_train_idx(offset+i,:) = [indexDataall{sample_idx(1),1},indexDataall{sample_idx(1),2},1];
        end
        dispstat (['Testset [1] sample: [' num2str(i) ']/' num2str(length(testlist01))]);
    end
    
    test_train_idxs{1,1} = test_train_idx;
    
    test_train_idx = zeros(length(trainlist02)+length(testlist02),3);
    for i=1:length(trainlist02)
        parts = strsplit(trainlist02{i}(1:end-4),'/');
        video_name = parts{1,2};
        sample_idx=find(~cellfun('isempty', strfind(indexDataall(:,3), video_name)));
        if size(sample_idx,1) > 0
         test_train_idx(i,:) = [indexDataall{sample_idx(1),1},indexDataall{sample_idx(1),2},0];
        end
        dispstat (['Trainset [2] sample: [' num2str(i) ']/' num2str(length(trainlist02))]);
    end
    offset = length(trainlist02);
    
    for i=1:length(testlist02)
        parts = strsplit(testlist02{i}(1:end-4),'/');
        video_name = parts{1,2};
        sample_idx=find(~cellfun('isempty', strfind(indexDataall(:,3), video_name)));
        if size(sample_idx,1) > 0
            test_train_idx(offset+i,:) = [indexDataall{sample_idx(1),1},indexDataall{sample_idx(1),2},1];
        end
        dispstat (['Testset [2] sample: [' num2str(i) ']/' num2str(length(testlist02))]);
    end
    
    test_train_idxs{1,2} = test_train_idx;
    
    test_train_idx = zeros(length(trainlist03)+length(testlist03),3);
    for i=1:length(trainlist03)
        parts = strsplit(trainlist03{i}(1:end-4),'/');
        video_name = parts{1,2};
        sample_idx=find(~cellfun('isempty', strfind(indexDataall(:,3), video_name)));
        if size(sample_idx,1) > 0
         test_train_idx(i,:) = [indexDataall{sample_idx(1),1},indexDataall{sample_idx(1),2},0];
        end
        dispstat (['Trainset [3] sample: [' num2str(i) ']/' num2str(length(trainlist03))]);
    end
    offset = length(trainlist03);
    
    for i=1:length(testlist03)
        parts = strsplit(testlist03{i}(1:end-4),'/');
        video_name = parts{1,2};
        sample_idx=find(~cellfun('isempty', strfind(indexDataall(:,3), video_name)));
        if size(sample_idx,1) > 0
            test_train_idx(offset+i,:) = [indexDataall{sample_idx(1),1},indexDataall{sample_idx(1),2},1];
        end
        dispstat (['Testset [3] sample: [' num2str(i) ']/' num2str(length(testlist03))]);
    end
    
    test_train_idxs{1,3} = test_train_idx;

end

