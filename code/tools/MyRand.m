function findrand = MyRand(data)
[r,c]= find(~cellfun(@isempty,data));
tmp = [r c];
for i =1 :size(data,1)
    b(i) = max(tmp(find(tmp(:,1)==i),2));
end

for i =1:length(b)
    a1 = [];
     for s =1 :10
     a1 = [a1,randperm(b(i))];
     end
     findrand(i,:) = a1(1,[1:20]);
end
