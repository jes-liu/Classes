% Jesse Liu 111639610
clf; clc; clear memory; clear all; close all
set(0,'DefaultTextFontname', 'Arial','DefaultAxesFontSize', 12) 
set(gca, 'FontName', 'Arial','DefaultTextFontSize', 12)

data = load('data_flu_2009.txt');
t=data(:,1);  % time in weeks
i=data(:,2);  % number of cases per week

figure(1)
hold on
plot(t,i,'co','linewidth',1.5)

%% SIR model
global beta gamma
Ro=1.47;  % reproductive rate
gamma=(1/1.4286);  % infectious period per week
beta=(Ro*gamma);  % transmission probability %%1.023
timestep=.001;  % per week
timespan=0:timestep:length(t);

% SIR initials
global S0 I0 R0
S0=7000;  % healthy indiviuals
I0=10;  % infected individuals
R0=0;  % cured individuals
intitial=[S0 I0 R0]';  % initial values

[t,p]=ode45(@pop,timespan,intitial);
disp(max(p(:,2)))

plot(t,p(:,1),'r','linewidth',1.5)
plot(t,p(:,2),'g','linewidth',1.5)
plot(t,p(:,3),'b','linewidth',1.5)
xlabel('Time(weeks)')
ylabel('Population')
title('H1N1 strain')
xlim([0 30])
ylim([0 7000])
legend('Influenza data','Susceptible','Infected','Recovered','location','best')
hold off
print('-r300','-dpng',['SIR_model','.png']);  

%% Quaratine model
global alpha death epsilon
alpha = .1;  % chances of being quarantined
death = .2;  % death rate of infected
epsilon = .8;  % chances of quarantined being recovered
Q0=0;  % quarantined individuals
initialQ=[S0 I0 R0 Q0]';

[t,q]=ode45(@quarantine,timespan,initialQ);

figure(2)
hold on
plot(t,q(:,1),'r','linewidth',1.5)
plot(t,q(:,2),'g','linewidth',1.5)
plot(t,q(:,3),'b','linewidth',1.5)
plot(t,q(:,4),'k--','linewidth',1.5)
xlabel('Time(weeks)')
ylabel('Population')
title('SIR quarantine')
xlim([0 30])
ylim([0 7000])
legend('Susceptible','Infected','Recovered','Quarantined','location','best')
hold off
print('-r300','-dpng',['SIR_model_quarantine','.png']);

%% Vaccine model
global phi
phi = .2;  % chance of getting vaccine when susceptible
V0=7000;  % number of vaccines available
initialV=[S0 I0 R0 V0]';

[t,v]=ode45(@vaccine,timespan,initialV);

figure(3)
hold on
plot(t,v(:,1),'r','linewidth',1.5)
plot(t,v(:,2),'g','linewidth',1.5)
plot(t,v(:,3),'b','linewidth',1.5)
plot(t,v(:,4),'k--','linewidth',1.5)
xlabel('Time(weeks)')
ylabel('Population')
title('SIR vaccine')
xlim([0 30])
ylim([0 7000])
legend('Susceptible','Infected','Recovered','Vaccine','location','best')
hold off
print('-r300','-dpng',['SIR_model_vaccine','.png']);

%% SIR model function
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
global beta gamma alpha death epsilon

dy=zeros(4,1);
S = y(1);
I = y(2);
R = y(3);
Q = y(4);
N= S+I+R+Q;

dS = -beta.*S.*(I./N);  %Susceptible
dI = beta.*S.*(I./N) - gamma.*I - (alpha+death).*I;  %Infected
dR = gamma.*I + epsilon.*Q;  %Recovered
dQ = alpha.*I - epsilon.*Q;  %Quarantined

SIRQ = [dS dI dR dQ]';
return
end

%% Vaccine function
function SIRV=vaccine(t,z)
global beta gamma phi death

dz=zeros(4,1);
S = z(1);
I = z(2);
R = z(3);
V = z(4);
N= S+I+R;
% disp(7000-N)

dS = -beta.*S.*(I./N) - phi.*S;  %Susceptible
dI = beta.*S.*(I./N) - gamma.*I - death.*I;  %Infected
dR = gamma.*I + phi.*S;  %Recovered
dV = -phi.*V;  %Vaccinated

SIRV = [dS dI dR dV]';
return
end