function [RF]=trainRF()

 X3=randn(120,32,32);
 size(X3)
 T=randn(120,1)>0.5;
% RF =trainRF(X,T);

%parameters
num_trees=50;

%train
tic
RF = TreeBagger(num_trees,X3,T);
toc
