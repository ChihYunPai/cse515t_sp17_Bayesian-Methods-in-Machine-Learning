function [K] = kernel(opt,z1,z2)
% Inputs:
%           x1: dxm matrix, d: dimension, m: number of data points x1
%           x2: dxn matrix, d: dimension, n: number of data points x2
%           kernelType: type of kernel ('linear', 'poly': polynomial, 'rbf', )
% Outputs:  
%           K: kernel 
m=length(z1);
n=length(z2);
k1=@(x1,x2)exp(-abs(x1-x2)^2/2);
k2=@(x1,x2)exp(-abs(x1-x2));
k3=@(x1,x2)(1+sqrt(3)*abs(x1-x2))*exp(-sqrt(3)*abs(x1-x2));
k4=@(x1,x2)delta(x1,x2);
k1_d  = @(x1,x2)-2*(x1-x2)*exp(-(x1-x2)^2);
k1_dd = @(x1,x2)(4*(x1-x2)^2-2)*exp(-(x1-x2)^2);

switch opt
    case 1
        k=k1;
    case 2
        k=k2;
    case 3
        k=k3;
    case 4
        k=k4;
    case 5
        k=k1_d;
    case 6 
        k=k1_dd;
end
K=zeros(m,n);
for i=1:m
    for j=1:n
        K(i,j)=k(z1(i),z2(j));
    end
end
end