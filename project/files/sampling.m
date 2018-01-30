function [idx_train50,xTr50,yTr50,idx_test50,xTe50,yTe50]=sampling(data)
sampleSize=50; %sample size for each patient
Index=[1:size(data,1)]';
Data=[Index,data];
% indx50=[1:97*sampleSize];
% N=length(yTr);
% M=length(yTe);
% d=size(xTr,2);
train=[];
test=[];

for i=1:70
    idx=i-1;
    temp=sortrows(Data(Data(:,2)==idx,:),size(Data,2));
    [ref,idx]=datasample(temp(:,end),50,'Replace',false);
    train=[train;temp(idx,:)];
end
idx_train50=train(:,1);
xTr50=train(:,3:end-1);
yTr50=train(:,end);
for i=71:97
    idx=i-1;
    temp=sortrows(Data(Data(:,2)==idx,:),size(Data,2));
    [ref,idx]=datasample(temp(:,end),50,'Replace',false);
    test=[test;temp(idx,:)];
end
idx_test50=test(:,1);
xTe50=test(:,3:end-1);
yTe50=test(:,end);
end