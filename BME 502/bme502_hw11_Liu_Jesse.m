%% Jesse Liu 111639610
clear all; close all; clc;

%% pg.503 #2

a = 0;
b = 2;
ya = 1;
M_20 = 20;
M_40 = 40;
y = @(t) (4/3)*exp(3*t) - t - 1/3;
f = @(y,t) 3*y + 3*t;

R_M20=rk4(f,a,b,ya,M_20);
R_M40=rk4(f,a,b,ya,M_40);

fprintf(['pg.503\n#2b\nExact y(2)=%.4f\nApprox of h=0.1, M=20: y(2)=%.4f'...
    '\nApprox of h=0.05, M=40: y(2)=%.4f\n'], y(2), R_M20(end,2), R_M40(end,2))

fge1 = y(2) - R_M20(end,2);
fge2 = y(2) - R_M40(end,2);
ratio = fge1/fge2;

fprintf(['\n#2c\nThe final global error (F.G.E.)\nfor h=0.1, M=20 is %.4f\n'...
    'for h=0.05, M=40 is %.4f\nSince the step size is reduced by a factor'...
    ' of 1/2, then\nthe error should also theoretically reduce by a factor'...
    ' of 1/2.\nThe ratio of F.G.E. for these two step sizes is %.4f.\n'...
    'Therefore, no, the F.G.E. does not behave as expected.\n'], fge1, fge2, ratio)

hold on
plot(R_M20(:,1), R_M20(:,2))
plot(R_M40(:,1), R_M40(:,2))
plot(0:.05:2, y(0:.05:2))
title('pg.503 #2d')
legend('h=0.1, M=20', 'h=0.05, M=40', 'Exact Solution', 'location', 'best')

%% Program 9.4
function R=rk4(f,a,b,ya,M)
%Input          - f is the function entered as a string ’f’
%               - a and b are the left and right endpoints
%               - ya is the initial condition y(a)
%               - M is the number of steps
%Output         - R=[T’ Y’] where T is the vector of abscissas
%               and Y is the vector of ordinates

h=(b-a)/M;
T=zeros(1,M+1);
Y=zeros(1,M+1);
T=a:h:b;
Y(1)=ya;

for j=1:M
k1=h*feval(f,T(j),Y(j));
k2=h*feval(f,T(j)+h/2,Y(j)+k1/2);
k3=h*feval(f,T(j)+h/2,Y(j)+k2/2);
k4=h*feval(f,T(j)+h,Y(j)+k3);
Y(j+1)=Y(j)+(k1+2*k2+2*k3+k4)/6;
end

R=[T' Y'];
end