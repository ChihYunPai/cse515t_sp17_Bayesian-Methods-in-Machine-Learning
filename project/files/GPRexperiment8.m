function [ypred,RMSE]=GPRexperiment8(IDs,xTr,yTr,xTr_reduced,yTr_reduced,xTe_reduced,yTe_reduced)
% experiment bagged tree regression with thrid model (three layer combinational net)
xTr1=xTr(:,1:240);
xTr2=xTr(:,241:end);
xTr1_reduced=xTr_reduced(:,1:240);
xTr2_reduced=xTr_reduced(:,241:end);
xTe1_reduced=xTe_reduced(:,1:240);
xTe2_reduced=xTe_reduced(:,241:end);
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
    btMdl = fitrensemble([H1,H2],yTri,'OptimizeHyperparameters','auto',...
    'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
    'expected-improvement-plus'));
    mdls2{i}=btMdl;
end

N1=length(mdls1_1)
N2=length(mdls1_2)
M=length(yTr_reduced)
K=length(yTe_reduced)

H3=zeros(M,N2);
parfor (i=1:N2,8)
    H3(:,i)=predict(mdls2{i},[predict(mdls1_1{i},xTr1_reduced),predict(mdls1_2{i},xTr2_reduced)]);
end
rng default
BTmdl = fitrensemble(H3,yTr_reduced,'OptimizeHyperparameters','auto',...
    'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
    'expected-improvement-plus'));

R=zeros(K,N2);
parfor (i=1:N2,8)
    R(:,i)=predict(mdls2{i},[predict(mdls1_1{i},xTe1_reduced),predict(mdls1_2{i},xTe2_reduced)]);
end
ypred=predict(BTmdl,R);
RMSE=sqrt(mean((yTe_reduced-ypred).^2));
end