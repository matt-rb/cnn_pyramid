
for i=1 : size(classInd,1)
    idx = strfind(testlist01(:,1),classInd{i,2});
    [r,c]= find(~cellfun(@isempty,idx));
    testlist01(r,2) = {i};
    idx = strfind(testlist02(:,1),classInd{i,2});
    [r,c]= find(~cellfun(@isempty,idx));
    testlist02(r,2) = {i};
    idx = strfind(testlist03(:,1),classInd{i,2});
    [r,c]= find(~cellfun(@isempty,idx));
    testlist03(r,2) = {i};
end