function [mdls,svmloss] = SVMProc(filename, IDseq)
    source=csvread(filename,1,0);
    IDs=source(:,1);
    svmloss=ones(1,length(IDseq));
    mdls=cell(1,length(IDseq));
    parfor i=1:length(IDseq)
        singlesrc=source(IDs==IDseq(i),2:end);
        %random permute sequence
        randseq=randperm(size(singlesrc,1));
        cut=ceil(0.7*length(randseq));
        %separate train and test sets
        trainseq=randseq(1:cut-1);
        xtr=singlesrc(trainseq,1:end-1);
        ytr=singlesrc(trainseq,end);
        testseq=randseq(cut:end);
        xte=singlesrc(testseq,1:end-1);
        yte=singlesrc(testseq,end);
        temp= fitrsvm(xtr,ytr,'KernelFunction','gaussian','KernelScale',...
            'auto','Standardize',true, 'OptimizeHyperparameters','auto',...
            'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
            'expected-improvement-plus'));
        mdls{i}=temp;
        svmloss(i)=loss(temp,xte,yte);
    end
    save('svmRegressionMdls.mat','mdls','svmloss');
end