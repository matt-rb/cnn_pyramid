function [pX,pc] = MyPCA(data,options)
X=double(data);
X=bsxfun(@minus,X,mean(X));
%X=bsxfun(@rdivide,X,sqrt(sum(X.^2,2)));
%[ndata, ndim]=size(X);
%%%%%%%%%%% Reducing the dimensions
%%%%% PCA
C=X'*X;
[pc,~]=eigs(C,options.rdim);
pX=X*pc;

mX=X(:,1:options.rdim);
