function [ypred, RMSE]=GPRexperiment1(mdls,xTr,yTr,xTe,yTe)

% training phase: 
% using 60% of data as training set (size of N), train N GPRs' function (hi, i=1~N)
% mdls = {N}


% validation phase:
% using 20% of data as validtion set (size of M)
% using SVM to learning weights, H=[hj(x_val_i)] M by N matrix as inputs, validation set as 

% creating H matrix
N=length(mdls);
M=length(yTr);
K=length(yTe);

H=zeros(M,N);
tic
parfor i=1:N
    H(:,i)=predict(mdls{i},xTr);
end
toc
N
M
K



% Now, problem becomes learning w for min[H(x')*w] using given xVal
tic

SVMmdl = fitrsvm(H,yTr,'KernelFunction','gaussian','KernelScale',...
            'auto','Standardize',true, 'OptimizeHyperparameters','auto',...
            'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
            'expected-improvement-plus'));

% or also using GPR in the second phase
% GPRmdl = fitrgp(H,yTr,'KernelFunction','squaredexponential',...
%                     'OptimizeHyperparameters','auto','HyperparameterOptimizationOptions',...
%                     struct('AcquisitionFunctionName','expected-improvement-plus'));
toc
% test phase: 
% using 20% of data as test set (size of K)
% creating R matrix
tic
R=zeros(K,N);
parfor i=1:N
    R(:,i)=predict(mdls{i},xTe);
end
toc
ypred=predict(SVMmdl,R);
RMSE=sqrt(mean((yTe-ypred).^2));

end