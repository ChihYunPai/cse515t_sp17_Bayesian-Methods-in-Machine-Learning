function [ypred, RMSE]=GPRexperiment4(mdls,xTr,yTr,xTe,yTe)
% creating H matrix
N=length(mdls)
M=length(yTr)
K=length(yTe)

H=zeros(M,N);
parfor i=1:N
    H(:,i)=predict(mdls{i},xTr);
end

% Now, problem becomes learning w for min[H(x')*w] using given xVal
rng default
GPRmdl = fitrgp(H,yTr,'KernelFunction','squaredexponential',...
            'OptimizeHyperparameters','auto','HyperparameterOptimizationOptions',...
            struct('AcquisitionFunctionName','expected-improvement-plus'));
% test phase: 
% using 20% of data as test set (size of K)
% creating R matrix
R=zeros(K,N);
parfor i=1:N
    R(:,i)=predict(mdls{i},xTe);
end
ypred=predict(GPRmdl,R);
RMSE=sqrt(mean((yTe-ypred).^2));
end