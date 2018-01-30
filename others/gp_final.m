function [X_val,Y_val,X_train,Y_train,loss]=gp_final();
% load spiral;
% [d,n]=size(xTr);
% [~,m]=size(xTe);
% gprMdl = fitrgp(xTr',yTr,'Basis','linear','FitMethod','exact','PredictMethod','exact')
% ypred = sign(predict(gprMdl,xTe'))';
% loss = sum(ypred~=yTe)/m;

%% test for midterm problem
% x=[-3,-2,-1,0,1,2,3]';
% x_test=[-4:0.1:4]';
% y=exp(-x.^2);
% d=length(x);
% kfcn = @(XN,XM,theta) exp(-(pdist2(XN,XM).^2));
% theta0=[log(sqrt(.5)), 0];
% gprMdl = fitrgp(x,y,'Basis','none','FitMethod','none','PredictMethod','exact','KernelFunction',kfcn,'KernelParameters',theta0);
% 
% ypred = predict(gprMdl,x_test);
% plot(x,y,'ko',x_test,ypred,'r--');hold on;
% plot(x_test,ypred,'r','LineWidth',1.5);
% xlabel('x');ylabel('y');legend('Data','GPR predictions');
% hold off

%% test for Gaussian Process Regression
load data2;
[d,N]=size(whole3data);
d=d-1;
X_train=train(:,1:d);
Y_train=train(:,d+1);
X_val  =val(:,1:d);
Y_val  =val(:,d+1);
X_test =[X_val;test(:,1:d)];
Y_test =[Y_val;test(:,d+1)];
gprMdl = fitrgp(X_train,Y_train,'Basis','constant','FitMethod','exact','PredictMethod','exact','KernelFunction','ardsquaredexponential');

% ypred = sign(predict(gprMdl,X_val));
%using sigmoid function
ypred = predict(gprMdl,X_val);

loss  = sum(ypred~=Y_val)/size(Y_val,1)

%% test for SVM classification with Gaussian kernel
% load data2;
% [d,N]=size(whole3data);
% d=d-1;
% X_train=train(:,1:d);
% Y_train=train(:,d+1);
% X_val  =val(:,1:d);
% Y_val  =val(:,d+1);
% X_test =[X_val;test(:,1:d)];
% Y_test =[Y_val;test(:,d+1)];
% 
% Mdl = fitcsvm(X_train,Y_train,'KernelFunction','rbf');
% [Label,Score] = predict(Mdl,X_test);
% loss=sum(Label~=Y_test)/length(Label);

%% test for Gaussian mixture distribution

end