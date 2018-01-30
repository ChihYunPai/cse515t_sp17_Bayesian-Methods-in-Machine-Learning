x=[-3,-2,-1,0,1,2,3]';
y=exp(-x.^2);

d=length(x);
y=exp(-x.^2);

k1=@(x1,x2)exp(-abs(x1-x2)^2);
K1=zeros(d,d);
for i=1:d
    for j=1:d
        K1(i,j)=k1(x(i),x(j));
    end
end
K1;
log_1 = -y'*inv(K1)*y/2-log(det(K1))/2-d*log(2*pi)/2;
k2=@(x1,x2)exp(-abs(x1-x2));
K2=zeros(d,d);
for i=1:d
    for j=1:d
        K2(i,j)=k2(x(i),x(j));
    end
end
K2;
log_2 = -y'*inv(K2)*y/2-log(det(K2))/2-d*log(2*pi)/2;
k3=@(x1,x2)(1+sqrt(3)*abs(x1-x2))*exp(-sqrt(3)*abs(x1-x2));
K3=zeros(d,d);
for i=1:d
    for j=1:d
        K3(i,j)=k3(x(i),x(j));
    end
end
K3;
log_3 = -y'*inv(K3)*y/2-log(det(K3))/2-d*log(2*pi)/2;
k4=@(x1,x2)delta(x1,x2);
K4=zeros(d,d);
for i=1:d
    for j=1:d
        K4(i,j)=k4(x(i),x(j));
    end
end
K4;
log_4 = -y'*inv(K4)*y/2-log(det(K4))/2-d*log(2*pi)/2;

log_max = max([log_1,log_2,log_3,log_4]);
result = 0;
k3=@(x1,x2)(1+sqrt(0.42)*abs(x1-x2))*exp(-sqrt(0.42)*abs(x1-x2));
for num_1 = 0.02:0.001:0.22
    for num_2 = 0.6:0.001:0.62
        for num_3 = 2

            K5=zeros(d,d);
            for i=1:d
                for j=1:d
                    K5(i,j)=num_1*exp(-num_2*abs(x(i)-x(j))^num_3);
                end
            end
            K5;
            log_5 = -y'*inv(K5)*y/2-log(det(K5))/2-d*log(2*pi)/2;
            if log_5 > log_max
                result = [num_1,num_2,num_3];
                log_max = log_5;
            end
        end
    end
end
result
log_max

% 
% 
% x=[-4.3,-3,-2,-1,0,1,2,3,4.3]';
% y=exp(-x.^2);
%  
% d=length(x);
% y=exp(-x.^2);
%  
% 
% x_star=[-5:0.1:5]';
% f=exp(-x_star.^2);
% for i=1
%     p  = zeros(length(x_star),1);
%     mu = zeros(length(x_star),1);
%     sigma = zeros(2,length(x_star));
%     for j = 1:length(x_star)
%         mufd = kernel(i,x_star(j),x)*inv(kernel(i,x,x))*y;
%         Kfd  = kernel(i,x_star(j),x_star(j))-kernel(i,x_star(j),x)*inv(kernel(i,x,x))*kernel(i,x,x_star(j));
%         p(j) = normpdf(f(j),mufd,Kfd);
%         mu(j)=mufd;
%         sigma(1,j) = mufd+1.96*real(sqrt(Kfd));
%         sigma(2,j) = mufd-1.96*real(sqrt(Kfd));
%     end
%     plot(x_star,mu);hold on
% end
% plot(x_star,f,'b');hold on
% plot(x,y,'ok');hold on
%  
% title('predictive distribution: K1, add two points x_* = +4.3, -4.3')
% legend('mean', 'true function', 'D','+/- 1.96 deviation')
% xlabel('x')
% ylabel('y')
% varargout = plotshaded(x_star',sigma,'b')



% 
% x_star=[-5:0.1:5]';
% f=exp(-x_star.^2);
% x_=0;
% f_=0;
% ff=[f;f_];
% for i=1
%     p = zeros(length(x_star),1);
%     mu = zeros(length(x_star),1);
%     sigma = zeros(2,length(x_star));
%     for j = 1:length(x_star)
%         E11=[kernel(1,x,x), kernel(5,x,x');kernel(5,x_,x), kernel(6,x_,x_)];
%         E12=[kernel(1,x,x_star(j));kernel(5,x_,x_star(j))];
%         E21=E12';
%         E22=kernel(1,x_star(j),x_star(j));
%         mufd = 0 + E21*inv(E11)*ff;
%         Kfd  = E22-E21*inv(E11)*E12;
%         p(j) = normpdf(f(j),mufd,Kfd);
%         mu(j)=mufd;
%         sigma(1,j) = mufd+1.96*real(sqrt(Kfd));
%         sigma(2,j) = mufd-1.96*real(sqrt(Kfd));
%     end
% %      plot(x_star,mu);hold on
% end
% 
% 
% 
% plot(x_star,mu);hold on
% plot(x_star,f,'b');hold on
% plot(x,y,'ok');hold on
% title('model-marginal predictive mean function plot, Pr(Mi|d):from part1(b)')
% legend('mean', 'true function', 'D')
% xlabel('x')
% ylabel('y')
% v =  plotshaded(x_star',sigma,'b')
% % MU=zeros(length(mu),1);
% % size(MU)
% % for i=1:length(mu)
% %     MU(i)=0.2594*mu(i,1)+.2425*mu(i,2)+.359*mu(i,3)+.1391*mu(i,4);
% % end
% % plot(x_star,MU);hold on
% % i=4
% %         mufd = kernel(i,2.5,x)*inv(kernel(i,x,x))*y
% %         Kfd  = kernel(i,2.5,2.5)-kernel(i,2.5,x)*inv(kernel(i,x,x))*kernel(i,x,2.5);
% %         p(j) = normpdf(f(j),mufd,Kfd);
% %         sqrt(Kfd)
%         
