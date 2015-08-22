function  [trkM] =  BinaryPath(Dataall,train_bin,test_bin,indTrain1,indTest1,options)

for categorynum =1:length(Dataall)%-------------------------extract feature for whole of dataset
    for vidnum = 1: size(Dataall{categorynum},1)   
        index  = find((indTrain1(:,1)==categorynum & indTrain1(:,2)==vidnum));
        if(isempty(index)) 
        index = find((indTest1(:,1)==categorynum & indTest1(:,2)==vidnum));
        [trkM1] =  OverlapBinatryPath(test_bin,index,options);
        else
        [trkM1] =  OverlapBinatryPath(train_bin,index,options);
        end
          [tmpevideo] =  BinaryTrjectory(trkM1,options);
          trkM{categorynum,vidnum} = tmpevideo;
          
       clear C index trkM1;
    end
end