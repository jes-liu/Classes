clf; clc; clear memory; clear all; close all
global t K r N0 T
% Fitting Data to a Logistic Model: flu data
data = load('data_flu_class.txt');
% 
%% extract the semi-major axis from the first column of  data
tt=data(:,1);
% % extract the period from the second column of data
P = data(:,2); 
%%
t=1:1:length(tt);
%% Plot Data
figure
plot(t,P,'o');
title('First test')
xlabel('Time (days)')
ylabel('flu Population Size (Number)')
print('-r300','-depsc2',[ 'fig_sir_model_phase','.eps']);  

%% SIR plot model
%% Parameters
global gamma beta Ro
S0=3000;           % Initial Susceptible population
I0=10;             % Initial Infected population 
R0=0;              % Initial Recovered population 
SIR0 =[S0 I0 R0]'; % Initial
%% Parameters
Ro=1.5;
gamma=0.5;
beta=0.6000;
h = 0.001; % time steps
tSpan = 0:h:length(tt); % set time interval
hold on
[t,X] = ode45(@sir_model,tSpan,SIR0); 

plot(t,X(:,2),'Color','blue','LineWidth',1.2);         
xlabel('Time(days)','fontsize',14)
ylabel('Infected host density','fontsize',14);
print('-r300','-depsc2',[ 'fig_sir_data_model','.eps']);  

function dy = sir_model(t,y)
% Susceptible-Infected Model 
  global beta gamma Ro
  dy=zeros(3,1);
    S = y(1);
    I = y(2);
    R = y(3);
    N= S+I+R;
dy(1)= -Ro.*beta.*S.*(I./N);          %Susceptible
dy(2)= Ro.*beta.*S.*(I./N)-gamma.*I;          %Infected
dy(3)= gamma.*I;          %Recovered
return
end