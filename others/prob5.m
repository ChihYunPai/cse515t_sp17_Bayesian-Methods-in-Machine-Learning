x = [-3:1:3];
y = [1.2341e-4,1.8316e-2,0.36788,1,0.36788,1.8316e-2,1.2341e-4];

%%%%%%%%%%k1
for i=1:1:7;
    for j=1:1:7;
        kori(i,j) = exp(-(x(i)-x(j))*(x(i)-x(j)));
    end
end

ynew = [0,y];


count = 0;
sigma=zeros(1,1001);
for m=-5:0.01:5;
    count = count+1;
    
    Rxy(1) = -2*m*exp(-m*m);
    for i=2:1:8;
        Rxy(i)= exp(-(m-x(i-1))*(m-x(i-1)));
    end
    

            Ryy(1,1) = 2;
            for i=2:1:8;
            Ryy(1,i) = -2*x(i-1)*exp(-(x(i-1)*x(i-1)));
            Ryy(i,1) = -2*x(i-1)*exp(-(x(i-1)*x(i-1)));
            end
            for i=2:1:8;
                for j=2:1:8;
                    Ryy(i,j) = kori((i-1),(j-1));
                end
            end
            miunew(count) = Rxy * inv(Ryy)*ynew';
            
            sigma(count) = 1-Rxy*inv(Ryy)*Rxy';
            
            yhigh(count) = miunew(count)+1.96*sigma(count);
            ylow(count) = miunew(count)-1.96*sigma(count);
end
            
var=[yhigh;ylow]';


plot(-5:0.01:5,miunew);hold on

plot(x_star,f,'b');hold on
plot(x,y,'ok');hold on;
title('predictive distribution: K1')
xlabel('x_*')
ylabel('y')
legend('mean','truth function', 'D','95% interval')
v=plotshaded(-5:0.01:5,var,'b');hold on


%plot(-5:0.01:5,yhigh,'r');
%hold on
%plot(-5:0.01:5,ylow);
%hold on
%plot(x,y,'*');
% hold on
% a = [-5:0.01:5];
% b = exp(-a.*a);
% plot(a,b);

hold off;



