%Jesse Liu 111639610
clear all;clc;

% Imports the squirrel data and plots it
data=load('squirrel_data.txt');
t=data(:,1);
pop=data(:,2);
figure(1)
plot(t,pop,'oblue')
 
% Uses the general population model and plots it
N0=10000;
T=0:39;
tt=1980:2019;
tau=6;
N = N0.* 2.^(T/tau);
hold on
plot(tt,N,'red')
xlabel('Time(years)')
ylabel('Population size')
title('Population growth model')
legend('Squirrel Data','General Population Model')
legend('Location','northwest')
hold off

% Used to find the growth rate
figure(2)
plot(t,pop,'ob')
N0=10000;
K=1000000;
N=769020;
t_growth=40;
R0 = -(log((N0.*(K-N))/(N.*(K-N0))))./t_growth;

% Used to find how many years it takes to reach 90% of the max population
N=900000;
K=1000000;
t_year = -(log((N0.*(K-N))/(N.*(K-N0))))./R0;
% Used to find how many years it takes to reach K-1 population
N=999999;
t_max = -(log((N0.*(K-N))/(N.*(K-N0))))./R0;

% Used to find the growth curve
N0=10000;
K=1000000;
t=0:49;
year=1980:2029;
N = ((K.*N0)./(N0+(K-N0).*exp(-R0.*t)));
hold on
plot(year,N,'r')
xlabel('Time(years)')
ylabel('Population size')
title('Logistic Equation Model')
yline(0,'g'); % First steady state
yline(K,'g'); % Second steady state
legend('Squirrel Data','Growth Curve','Steady States')
legend('Location','northwest')
ylim([-50000,1050000])