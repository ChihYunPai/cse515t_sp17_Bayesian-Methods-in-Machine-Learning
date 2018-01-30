function [lossMatrix]=svmPredict(source, IDseq, mdls)
IDs=source(:,1);
idl=length(IDseq);
lossMatrix = zeros(idl,idl);
 for i=1:length(IDseq)
    for j=1:length(mdls)
         singlesrc=source(IDs==IDseq(i),2:end);
         xte=singlesrc(:,1:end-1);
         yte=singlesrc(:,end);
         lossMatrix(i,j)=loss(mdls{j}, xte,yte);
     
     end
 end