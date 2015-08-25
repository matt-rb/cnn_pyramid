
%% annotaition for test samples
% for i=1 : size(classInd,1)
%     idx = strfind(testlist01(:,1),classInd{i,2});
%     [r,c]= find(~cellfun(@isempty,idx));
%     testlist01(r,2) = {i};
%     idx = strfind(testlist02(:,1),classInd{i,2});
%     [r,c]= find(~cellfun(@isempty,idx));
%     testlist02(r,2) = {i};
%     idx = strfind(testlist03(:,1),classInd{i,2});
%     [r,c]= find(~cellfun(@isempty,idx));
%     testlist03(r,2) = {i};
% end

%% remove missed videos
for i=1 : size(errorvideosall,1)-1
    idx = strfind(testlist01(:,1),errorvideosall{i});
    [r,c]= find(~cellfun(@isempty,idx));
    if r>0
        disp(['deleted ' errorvideosall{i} ' from testlist01']);
        testlist01(r,:) = [];
    end
    
    idx = strfind(testlist02(:,1),errorvideosall{i});
    [r,c]= find(~cellfun(@isempty,idx));
    if r>0
        disp(['deleted ' errorvideosall{i} ' from testlist02']);
        testlist02(r,:) = [];
    end
    
    idx = strfind(testlist03(:,1),errorvideosall{i});
    [r,c]= find(~cellfun(@isempty,idx));
    if r>0
        disp(['deleted ' errorvideosall{i} ' from testlist03']);
        testlist03(r,:) = [];
    end
    
    idx = strfind(trainlist01(:,1),errorvideosall{i});
    [r,c]= find(~cellfun(@isempty,idx));
    if r>0
        disp(['deleted ' errorvideosall{i} ' from trainlist01']);
        trainlist01(r,:) = [];
    end
    
    idx = strfind(trainlist02(:,1),errorvideosall{i});
    [r,c]= find(~cellfun(@isempty,idx));
    if r>0
        disp(['deleted ' errorvideosall{i} ' from trainlist02']);
        trainlist02(r,:) = [];
    end
    
    idx = strfind(trainlist03(:,1),errorvideosall{i});
    [r,c]= find(~cellfun(@isempty,idx));
    if r>0
        disp(['deleted ' errorvideosall{i} ' from trainlist03']);
        trainlist03(r,:) = [];
    end
end