function [pX,pc] = MyPCA(data,options)
X=double(data);
X=bsxfun(@minus,X,mean(X));
[pc,~]=eigs(X'*X,options.rdim);
pX=X*pc;

%mX=X(:,1:options.rdim);
