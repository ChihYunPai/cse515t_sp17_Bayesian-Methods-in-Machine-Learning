function [RMSE_SparseGP] = gpSparse(xTr, yTr, xTe, yTe)
%% READ FILE
% datasource = csvread(csvfilename, 1, 0);
% IDs = datasource(:,1);
% IDs_uni = unique(IDs);
% randseq = randperm(length(IDs_uni));
% setA = [];
% for i = 1:10
%     subset = datasource(IDs==randseq(i),2:end);
%     setA = [setA; subset];
% end
% usedID = randseq([1:10, 12]);
% % setAseq = randperm(size(setA,1));
% % cut = floor(0.7*length(setAseq));
% % trainset = setA(setAseq(1:cut),:);
% trainset = setA;
% xTr = trainset(:,1:end-1);
% yTr = trainset(:,end);
% lbound = min(yTr);
% ubound = max(yTr);
% for i = 11:length(randseq)
%     sid = randseq(i);
%     if max(datasource(IDs == sid,end)) <= ubound && min(datasource(IDs == sid,end)) >= lbound
%         testset=datasource(IDs == sid,2:end);
%         break;
%     end
% end
% testset = sortrows(testset,size(testset,2));
% % testsetA = setA(setAseq(cut+1:end),:);
% % testsetA = sortrows(testsetA,size(testsetA,2));
% xTe = testset(:,1:end-1);
% yTe = testset(:,end);
% X_train = xTr;
% y_train = yTr;
% X_test = xTe;
% y_test = yTe;
% X_train = xTr_PCA100;
% y_train = yTr_PCA100;
% X_test = xTe_PCA100;
% y_test = yTe_PCA100;
trainset = sortrows([xTr, yTr], size(xTr,2)+1);
testset = sortrows([xTe, yTe], size(xTe,2)+1);
X_train=trainset(:,1:end-1);
X_test=testset(:,1:end-1);
y_train=trainset(:,end);
y_test=testset(:,end);
%% LINEAR MODEL
% use matlab built-in function fitlim to build a linear prior
% [r1,~] = size(x_train);
% [r2,~] = size(x_test);
linear_model = fitlm(X_train, y_train, 'linear');
y_pre        = feval(linear_model, X_test);
% coeff        = linear_model.Coefficients.Estimate;

figure(1);hold;
plot(y_test, y_test, 'b');
plot(y_test, y_pre, 'r');
xlim([0,100]);ylim([0,100]);

%% GP MODEL
% parameters
input_scale  = 1;       % input scale ?
output_scale = 1;       % output scale ?
noise        = 0.5;     % noise scale ?

% add ones
[r,~]        = size(X_train);
x_train_gp   = [ones(r,1), X_train];
[r,c]        = size(X_test);
x_test_gp    = [ones(r,1), X_test];

% prior mean & prior cov
mean_function_gp = {@meanLinear};
cov_function_gp  = {@covSEiso};
inf_function_gp  = {@infGaussLik};
lik_function_gp  = {@likGauss};

% hyperparameters
hyperparameters.lik  = log(noise);
hyperparameters.mean = ones(c+1,1);
hyperparameters.cov  = ...
                    [log(input_scale);
                     log(output_scale)];

% optimize
learned_hyperparameters_gp = minimize(hyperparameters, ...
                           @gp, 100, ... 
                           inf_function_gp, mean_function_gp, cov_function_gp, ...
                           lik_function_gp, x_train_gp, y_train);
% 
% % prediction
% [mean_pos_gp, cov_pos_gp]  = gp(learned_hyperparameters_gp, inf_function_gp, ...
%                            mean_function_gp, cov_function_gp, ...
%                            lik_function_gp, x_train_gp, y_train, x_test_gp);  
% 
% figure(2);hold;
% plot(y_test, y_test, 'b')
% plot(y_test, mean_pos_gp, 'r');
% plot(y_test, mean_pos_gp + 2 * sqrt(cov_pos_gp), 'g');
% plot(y_test, mean_pos_gp - 2 * sqrt(cov_pos_gp), 'g');
% xlim([0,100]);ylim([0,100]);

%% SPARSE GP
% inducing point locations x?
[r,~]   = size(x_train_gp);
percent = 0.1;

% randomly select initial x?
index = randsample(1:length(x_train_gp), floor(percent*r));
x_bar = x_train_gp(index,:);

% wrapper for covariance
sparse_covariance_function = {@apxSparse, cov_function_gp, x_bar};

% wrapper for inference method (computes marginal likelihoods)
inference_method = @(varargin) infGaussLik(varargin{:}, struct('s', 1));

% sparse predictions
[y_mean, y_var] = gp(learned_hyperparameters_gp, inf_function_gp, ...
        mean_function_gp, sparse_covariance_function, @likGauss, x_train_gp, y_train, x_test_gp);

figure(3);
hold('on');
plot(y_test, y_test, '.')
plot(y_test, y_mean, 'r');
plot(y_test, y_mean + 2 * sqrt(y_var), 'g');
plot(y_test, y_mean - 2 * sqrt(y_var), 'g');
% plot(x_bar, -2.5, 'b+');
hold on
% hyperparameters.xu = x_bar;


% calling minimize next will learn inducing point locations!

% sparse_learned_hyperparameters = minimize(hyperparameters, @gp, 100, ...
%         inference_method_gp, mean_function_gp, sparse_covariance_function, ...
%         lik_function_gp, x_train_gp, y_train_gp);
%     
% [y_mean, y_var] = gp(sparse_learned_hyperparameters, inference_method_gp, ...
%         mean_function_gp, sparse_covariance_function, @likGauss, x_train_gp, y_train_gp, x_test_gp);
% 
% figure(4);
% hold('on');
% plot(y_test, y_mean, 'r');
% plot(y_test, y_mean + 2 * sqrt(y_var), 'r');
% plot(y_test, y_mean - 2 * sqrt(y_var), 'r');
% plot(sparse_learned_hyperparameters.xu, -2.5, 'b+');
RMSE_SparseGP = sqrt(mean((y_mean - y_test).^2));
y = [y_mean, y_test];
save('gpSparse.mat', 'RMSE', 'y');
end