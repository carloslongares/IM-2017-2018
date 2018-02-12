function [RF]=trainRF(X,T)

% X=randn(5000,32*32);
% T=randn(5000,1)>0.5;
% RF =trainRF(X,T);

%parameters
num_trees=50;

%train
tic
RF = TreeBagger(num_trees,X,T);
toc
