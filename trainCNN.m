function [net]=trainCNN(X,T)

% X=randn(32,32,1,5000);
% T=categorical(randn(5000,1)>0.5);
% [net]=trainCNN(X,T)

%parameter
s1=size(X);  %X puede ser un vector de 32x32x1xN 
s2=size(T);  %T pueder un verto de Nx1

num_clases=length(unique(T(:)));

% Two class
% define network
ks=3;           % kernel size (3x3)
numfilters=[32,64,128]; % cambiar a 128
layers = [imageInputLayer([s1(1) s1(2) 1]);
          convolution2dLayer(ks,numfilters(1));   %16 filtros de 5x5
          %batchNormalizationLayer();
          reluLayer();
          maxPooling2dLayer(2,'Stride',1);
          convolution2dLayer(ks,numfilters(2));   %16 filtros de 5x5
          %batchNormalizationLayer();
          reluLayer();
          maxPooling2dLayer(2,'Stride',1);
          convolution2dLayer(ks,numfilters(3));   %16 filtros de 5x5
          %batchNormalizationLayer();
          reluLayer();
          maxPooling2dLayer(2,'Stride',1);
          fullyConnectedLayer(num_clases^2);  
          %dropoutLayer(0.5);
          fullyConnectedLayer(num_clases);         
          softmaxLayer();
          classificationLayer()];
      
options = trainingOptions('sgdm','MaxEpochs',5,'InitialLearnRate',0.01);
rng('default') % For reproducibility      
[net,traininfo] = trainNetwork(X,categorical(single(T)),layers,options);


