% Jesse Liu 111639610
clf; clc; clear memory; clear all; close all
set(0,'DefaultTextFontname', 'Arial','DefaultAxesFontSize', 12) 
set(gca, 'FontName', 'Arial','DefaultTextFontSize', 12)

data = load('data_flu_2009.txt');
t=data(:,1);  % time in weeks
i=data(:,2);  % number of cases per week

figure(1)
hold on
plot(t,i,'o')

%% Constants
global beta gamma q v
Ro=1.51;  % reproductive rate
gamma=(1/1.4286);  % infectious period per week
beta=(Ro*gamma);  % transmission probability %%1.023
q=.2; % quarantine rate
v=.3; % vaccine rate
timestep=.001;  % per week
timespan=0:timestep:length(t);

global S0 I0 R0
S0=7000;  % healthy indiviuals
I0=10;  % infected individuals
R0=0;  % cured individuals

%% SIR Model
intitial=[S0 I0 R0]';  % initial values

[t,p]=ode45(@pop,timespan,intitial);

plot(t,p(:,2))
xlabel('Time(weeks)')
ylabel('Population')
title('H1N1 strain')
xlim([0 30])
legend('Influenza data','Infected','location','best')
hold off
print('-r300','-dpng',['Flu_H1N1','.png']);

%% Quarantine Model
initialQ=[S0 I0 R0]';

[t,Q]=ode45(@quarantine,timespan,initialQ);

figure(2)
hold on
plot(t,Q(:,2))
xlabel('Time(weeks)')
ylabel('Population')
title('SIR quarantine')
xlim([0 30])
legend('Infected','location','best')
hold off
print('-r300','-dpng',['Flu_quarantine','.png']);

%% Vaccine Model
initialV=[S0 I0 R0]';

[t,V]=ode45(@vaccine,timespan,initialV);

figure(3)
hold on
plot(t,V(:,2))
xlabel('Time(weeks)')
ylabel('Population')
title('SIR vaccine')
xlim([0 30])
legend('Infected','location','best')
hold off
print('-r300','-dpng',['Flu_vaccine','.png']);

%% SIR function
function SIR=pop(t,x)
global beta gamma

dx=zeros(3,1);
S = x(1);
I = x(2);
R = x(3);
N= S+I+R;

dS = -beta.*S.*(I./N);  %Susceptible
dI = beta.*S.*(I./N) - gamma.*I;  %Infected
dR = gamma.*I;  %Recovered

SIR=[dS dI dR]';
return
end

%% Quarantine function
function SIRQ=quarantine(t,y)
global beta gamma q

dy=zeros(3,1);
S = y(1);
I = y(2);
R = y(3);
N= S+I+R;

dS = -beta.*S.*(I./N);  %Susceptible
dI = beta.*S.*(I./N) - gamma.*I - q.*I;  %Infected
dR = gamma.*I + q.*I;  %Recovered

SIRQ=[dS dI dR]';
return
end

%% Vaccine function
function SIRV=vaccine(t,z)
global beta gamma v

dz=zeros(3,1);
S = z(1);
I = z(2);
R = z(3);
N= S+I+R;

dS = -beta.*S.*(I./N) - v.*S;  %Susceptible
dI = beta.*S.*(I./N) - gamma.*I;  %Infected
dR = gamma.*I;  %Recovered

SIRV=[dS dI dR]';
return
end