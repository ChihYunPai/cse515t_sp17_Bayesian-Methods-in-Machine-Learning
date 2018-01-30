function [ypred_SVM, RMSE_SVM]=GPRexperiment2(xTr,yTr,xTe,yTe)
tic
SVMmdl = fitrsvm(xTr,yTr,'KernelFunction','gaussian','KernelScale',...
            'auto','Standardize',true, 'OptimizeHyperparameters','auto',...
            'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
            'expected-improvement-plus'));
toc
ypred_SVM=predict(SVMmdl,xTe);
RMSE_SVM=sqrt(mean((yTe-ypred_SVM).^2));

end