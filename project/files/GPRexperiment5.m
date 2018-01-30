function [ypred, RMSE]=GPRexperiment5(mdls1,mdls2,xTr,yTr,xTe,yTe)
xTr1=xTr(:,1:240);
xTr2=xTr(:,241:end);
xTe1=xTe(:,1:240);
xTe2=xTe(:,241:end);

% creating H matrix
N=length(mdls1)
assert(N==length(mdls2));
M=length(yTr)
K=length(yTe)

H1=zeros(M,N);
parfor i=1:N
    H1(:,i)=predict(mdls1{i},xTr1);
end
H2=zeros(M,N);
parfor i=1:N
    H2(:,i)=predict(mdls2{i},xTr2);
end
H=[H1,H2];
% Now, problem becomes learning w for min[H(x')*w] using given xVal
rng default
GPRmdl = fitrgp(H,yTr,'KernelFunction','matern32',...
            'OptimizeHyperparameters','auto','HyperparameterOptimizationOptions',...
            struct('AcquisitionFunctionName','expected-improvement-plus'));
% test phase: 
% using 20% of data as test set (size of K)
% creating R matrix
R1=zeros(K,N);
parfor i=1:N
    R1(:,i)=predict(mdls1{i},xTe1);
end
R2=zeros(K,N);
parfor i=1:N
    R2(:,i)=predict(mdls2{i},xTe2);
end

ypred=predict(GPRmdl,[R1,R2]);
RMSE=sqrt(mean((yTe-ypred).^2));
end