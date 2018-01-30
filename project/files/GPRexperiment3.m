function [ypred_GPR,RMSE_GPR]=GPRexperiment3(xTr,yTr,xTe,yTe);
rng default
GPRmdl = fitrgp(xTr,yTr,'KernelFunction','squaredexponential',...
            'OptimizeHyperparameters','auto','HyperparameterOptimizationOptions',...
            struct('AcquisitionFunctionName','expected-improvement-plus'));
ypred_GPR=predict(GPRmdl,xTe);
RMSE_GPR=sqrt(mean((yTe-ypred_GPR).^2));
end