% tic;[ypred_SVM_raw_SR, RMSE_SVM_raw_SR]=GPRexperiment2(xTr_SR,yTr_SR,xTe_SR,yTe_SR);t1=toc
% tic;[GPRmdls_raw_SR] = GPR_Proc(xTr_SR,yTr_SR);[ypred_raw_SR, RMSE_raw_SR]=GPRexperiment1(GPRmdls_raw_SR,xTr_SR,yTr_SR,xTe_SR,yTe_SR);t2=toc

% tic;[ypred_SVM_PCA200_SR, RMSE_SVM_PCA200_SR]=GPRexperiment2(xTr_PCA200_SR,yTr_PCA200_SR,xTe_PCA200_SR,yTe_PCA200_SR);t3=toc
% tic;[GPRmdls_PCA200_SR] = GPR_Proc(xTr_PCA200_SR,yTr_PCA200_SR);[ypred_PCA200_SR, RMSE_PCA200_SR]=GPRexperiment1(GPRmdls_PCA200_SR,xTr_PCA200_SR,yTr_PCA200_SR,xTe_PCA200_SR,yTe_PCA200_SR);t4=toc

% tic;[ypred_SVM_PCA100_SR, RMSE_SVM_PCA100_SR]=GPRexperiment2(xTr_PCA100_SR,yTr_PCA100_SR,xTe_PCA100_SR,yTe_PCA100_SR);t5=toc
% tic;[GPRmdls_PCA100_SR] = GPR_Proc(xTr_PCA100_SR,yTr_PCA100_SR);[ypred_PCA100_SR, RMSE_PCA100_SR]=GPRexperiment1(GPRmdls_PCA100_SR,xTr_PCA100_SR,yTr_PCA100_SR,xTe_PCA100_SR,yTe_PCA100_SR);t6=toc

% tic;[RMSE_SparseGP_raw_SR] = gpSparse(xTr_SR, yTr_SR, xTe_SR, yTe_SR);t7=toc
% tic;[RMSE_SparseGP_PCA200_SR] = gpSparse(xTr_PCA200_SR,yTr_PCA200_SR,xTe_PCA200_SR,yTe_PCA200_SR);t8=toc
% tic;[RMSE_SparseGP_PCA100_SR] = gpSparse(xTr_PCA100_SR,yTr_PCA100_SR,xTe_PCA100_SR,yTe_PCA100_SR);t9=toc




tic;[ypred_raw_SR, RMSE_raw_SR]=GPRexperiment3(xTr_SR,yTr_SR,xTe_SR,yTe_SR);t2=toc
tic;[ypred_PCA200_SR, RMSE_PCA200_SR]=GPRexperiment3(xTr_PCA200_SR,yTr_PCA200_SR,xTe_PCA200_SR,yTe_PCA200_SR);t4=toc
tic;[ypred_PCA100_SR, RMSE_PCA100_SR]=GPRexperiment3(xTr_PCA100_SR,yTr_PCA100_SR,xTe_PCA100_SR,yTe_PCA100_SR);t6=toc


