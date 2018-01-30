function [ypred,RMSE]=GPRexperiment7(xTr,yTr,xTe,yTe)
% experiment bagged tree regression with whole raw data set
Mdl = fitrensemble(xTr,yTr,'OptimizeHyperparameters','auto',...
    'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
    'expected-improvement-plus'));
ypred=predict(Mdl,xTe);
RMSE=sqrt(mean((yTe-ypred).^2));

% experiment bagged tree regression with thrid model (three layer combinational net)
end