function [mdls] = GPR_Proc(IDs,xTr,yTr)
    IDseq=0:69;
    mdls=cell(1,length(IDseq));
    parfor i=1:length(IDseq)
        idx=i-1;
        xTri=xTr(IDs==idx,:);
        yTri=yTr(IDs==idx,:);
        rng default
        gprMdl = fitrgp(xTri,yTri,'KernelFunction','matern32',...
                    'OptimizeHyperparameters','auto','HyperparameterOptimizationOptions',...
                    struct('AcquisitionFunctionName','expected-improvement-plus'));
        mdls{i}=gprMdl;
    end
end