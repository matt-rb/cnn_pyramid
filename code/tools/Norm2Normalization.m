function [NX_test,NX_train] = Norm2Normalization(data_train,data_test)
M=mean(data_train);

X_train=bsxfun(@minus,data_train,M);
NX_train=bsxfun(@rdivide,X_train, sqrt(sum(X_train.^2,2)));

X_test=bsxfun(@minus,data_test,M);
NX_test=bsxfun(@rdivide,X_test, sqrt(sum(X_test.^2,2)));

