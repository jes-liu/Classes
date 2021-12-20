%Jesse Liu 111639610
function squirrel_euler_method
clear all;clc;

t=1;
maxt=50;
deltat=2;
N(1)=10000;
year=1980:2030;

% Used to find the next N value from the previous N value using time step
for i=1:maxt
    N(i+1) = N(i) + f(N(i)).*deltat;
    t = t+deltat;
end

data=load('squirrel_data.txt');
t=data(:,1);
pop=data(:,2);
plot(t,pop,'oblue')
hold on
plot(year,N,'r')
title('Forward Euler Method')
xlabel('Time(years)')
ylabel('Squirrel Population')
legend('Squirrel Data','Euler model')
legend('Location','northwest')

% Subfunction used to find dN
function dN = f(N)
R0=.1449;
K=1000000;
dN = (R0.*N).*(1-N./K);
