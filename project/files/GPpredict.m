function [predmean, predcov, RMSE] = GPpredict(trainset, testset, theta, c, mu, sigma)
    % trainset, testset: format is [ID, ..., reference]
    % theta            : hyperparameters, contains two numbers
    % c                : constant kernel value for ID kernel
    % mu               : mean of prior distribution
    % sigma            : standard deviation of noise
    if nargin < 3
        theta = [1, 0.5];
        c = 0.5;
        mu = 0;
        sigma = 0;
    elseif nargin < 4
        c = 0.5;
        mu = 0;
        sigma = 0;
    elseif nargin < 5
        mu = 0;
        sigma = 0;
    elseif nargin < 6
        sigma = 0;
    end
    xtr = trainset(:, 1:end-1);
    ytr = trainset(:, end);
    xte = testset(:, 1:end-1);
    yte = testset(:, end);
    nE=diag(ones(size(xtr,1),1)*sigma^2);
    Ker = complexkernel(xte,xtr,theta,c);
    Krr = complexkernel(xtr,xtr,theta,c);
    Kee = complexkernel(xte,xte,theta,c);
    predmean = mu + Ker/(Krr+nE)*(ytr - mu);
    predcov = Kee-Ker*(Krr+nE)*Ker';
    RMSE = sqrt(mean((predmean - yte).^2));
end