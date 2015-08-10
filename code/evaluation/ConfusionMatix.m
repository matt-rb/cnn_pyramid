function  confusion = ConfusionMatix(confidence,label)

[value_disicion,I] = max (confidence);
for i = 1:size(confidence,1)
    ind = find(label==i);

    for j = 1:size(confidence,1)
        allsample = sum(label==i);
       selectsample =  sum(I(ind)==j);
       confusion(i,j) = (selectsample/allsample)*100;
    end
end


