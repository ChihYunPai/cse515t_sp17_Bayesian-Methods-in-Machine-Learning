function [ypred, RMSE]=GPRexperiment6(mdls1_1,mdls1_2,mdls2,xTr,yTr,xTe,yTe)
xTr1=xTr(:,1:240);
xTr2=xTr(:,241:end);
xTe1=xTe(:,1:240);
xTe2=xTe(:,241:end);

% creating H matrix
N1=length(mdls1_1)
N2=length(mdls1_2)
M=length(yTr)
K=length(yTe)

H3=zeros(M,N2);
parfor (i=1:N2,8)
    H3(:,i)=predict(mdls2{i},[predict(mdls1_1{i},xTr1),predict(mdls1_2{i},xTr2)]);
end
% Now, problem becomes learning w for min[H(x')*w] using given xVal
rng default
GPRmdl = fitrgp(H3,yTr,'KernelFunction','squaredexponential',...
            'OptimizeHyperparameters','auto','HyperparameterOptimizationOptions',...
            struct('AcquisitionFunctionName','expected-improvement-plus'));
% test phase: 
% using 20% of data as test set (size of K)
% creating R matrix
R=zeros(K,N2);
parfor (i=1:N2,8)
    R(:,i)=predict(mdls2{i},[predict(mdls1_1{i},xTe1),predict(mdls1_2{i},xTe2)]);
end
ypred=predict(GPRmdl,R);
RMSE=sqrt(mean((yTe-ypred).^2));
end