function [Hist_all_test,Hist_all_train,indextest,indextrain] = HistFeature(data_train,data_test,Video_train,Video_test,options)
% should change some parameter
numClusters = options.numClusters;
run(fullfile(options.vl_featPath, 'vl_setup.m'));
addpath(options.pwmetricPath);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%clustering
 [NX_test,NX_train] = Norm2Normalization(data_train,data_test);
% M=mean(data_train);
% X_train=bsxfun(@minus,data_train,M);
% NX_train=bsxfun(@rdivide,X_train, sqrt(sum(X_train.^2,2)));
% X_test=bsxfun(@minus,data_test,M);
% NX_test=bsxfun(@rdivide,X_test, sqrt(sum(X_test.^2,2)));

NX_train=single(NX_train');
sprev = rng(0,'v5uniform');
[centers, assignments] = vl_kmeans(NX_train, numClusters);

 NX_test=single(NX_test)';
 dw   = slmetric_pw(NX_test,centers, 'eucdist' );
[~,idw]   =  min(dw');
idw1=idw';
assignments1=assignments';
%%%%%%%%%%
Hist_all=[];
Hist_all_train=[];
Hist_all_test=[];
indextrain = [];
indextest = [];
for i=1:max(Video_train(:,1))
    for j=1:max(Video_train(:,2))
        disp(['processing Test '  num2str(i)])
        ind = find(Video_train(:,1)==i&Video_train(:,2)==j);
        
        if(~isempty(ind))
            AA=assignments1(ind);
            Hist_all_train(end+1,:) = histc(AA,1:numClusters);
            indextrain(end+1,:) = [i j];
        end
    end
end

for i=1:max(Video_train(:,1))
    for j=1:max(Video_train(:,2))
        disp(['processing Test '  num2str(i)])
        ind = find(Video_test(:,1)==i&Video_test(:,2)==j);
        if(~isempty(ind))
            AA=idw1(ind);
            Hist_all_test(end+1,:) = histc(AA,1:numClusters);
            indextest(end+1,:) = [i j];
        end
    end
    
end





