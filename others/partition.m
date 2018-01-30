function [train, val, test]=partition(data, trp, valp, tep)
[n,~]=size(data);
numval=floor(n*valp);
vali=floor(rand(1,numval)*364);
numvali=length(vali);
for i=1:numvali
     val(i,:)=data(vali(i),:);
end
data(vali,:)=[];

[n,~]=size(data);
numte=floor(n*tep);
tei=floor(rand(1,numte)*n);
numtei=length(tei);
for i=1:numtei
     test(i,:)=data(tei(i),:);     
end
data(tei,:)=[];
train=data;
end