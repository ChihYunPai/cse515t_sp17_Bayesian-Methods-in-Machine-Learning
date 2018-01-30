function [mdls1_1,mdls1_2,mdls2] = GPR_Proc2(IDs,xTr,yTr)
xTr1=xTr(:,1:240);
xTr2=xTr(:,241:end);
IDseq=0:69;
mdls1_1=cell(1,length(IDseq));
parfor i=1:length(IDseq)
    idx=i-1;
    rng default
    gprMdl = fitrgp(xTr1(IDs==idx,:),yTr(IDs==idx,:),'KernelFunction','squaredexponential',...
                'OptimizeHyperparameters','auto','HyperparameterOptimizationOptions',...
                struct('AcquisitionFunctionName','expected-improvement-plus'));
    mdls1_1{i}=gprMdl;
end

mdls1_2=cell(1,length(IDseq));
parfor i=1:length(IDseq)
    idx=i-1;
    rng default
    gprMdl = fitrgp(xTr2(IDs==idx,:),yTr(IDs==idx,:),'KernelFunction','squaredexponential',...
                'OptimizeHyperparameters','auto','HyperparameterOptimizationOptions',...
                struct('AcquisitionFunctionName','expected-improvement-plus'));
    mdls1_2{i}=gprMdl;
end

mdls2=cell(1,length(IDseq));
parfor i=1:length(IDseq)
    idx=i-1;
    yTri=yTr(IDs==idx,:);
    H1=predict(mdls1_1{i},xTr1(IDs==idx,:));
    H2=predict(mdls1_2{i},xTr2(IDs==idx,:));
    rng default
    gprMdl = fitrgp([H1,H2],yTri,'KernelFunction','squaredexponential',...
                'OptimizeHyperparameters','auto','HyperparameterOptimizationOptions',...
                struct('AcquisitionFunctionName','expected-improvement-plus'));
    mdls2{i}=gprMdl;
end
end