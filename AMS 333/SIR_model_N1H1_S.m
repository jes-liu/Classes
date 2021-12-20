clf; clc; clear memory; clear all; close all
clf; clc; clear memory; clear all; clc; close all
set(0,'DefaultTextFontname', 'Arial','DefaultAxesFontSize', 12) 
set(gca, 'FontName', 'Arial','DefaultTextFontSize', 12)

%% Fitting Data to a Logistic Model: Flu data
data = load('data_flu_class.txt');
%% extract the semi-major axis from the first column of  data
tt=data(:,1);
% % extract the period from the second column of data
P = data(:,2); 
%% Time span
t=1:1:length(tt);
%% Plot Data
figure
plot(t,P,'or','LineWidth',1.5);
    xlabel('Time(days)','fontsize',16)
    ylabel('Infected population(Density)','fontsize',16);
    legend({'Data of cases', 'Model fit to data'},'FontSize',16);
set(gca, 'LooseInset', get(gca, 'TightInset'));
print('-r300','-depsc2',['fig_sir_data_model','.eps']);   
print('-r300','-dpng',  ['fig_sir_data_model','.png']);  
print('-r300','-djpeg', ['fig_sir_data_model','.jpg']);  

%% SIR plot model
%% Intial Parameters
global t gamma beta Ro
S0=3000;             % Initial Susceptible population
I0=5;                % Initial Infected population 
R0=0;                % Initial Recovered population 
SIR0 = [S0 I0 R0]';
%% Parameters
gamma=0.35;         % Recovery or removal rate
Ro=2;               % Basic Reproductive Number(ratio)
beta=Ro*gamma       % Transmission probability
h = 0.005;          % time steps

tSpan = 0:h:length(tt); % set time interval

hold on
[t,X] = ode45(@sir_model,tSpan,SIR0); 

plot(t,X(:,2),'Color','blue','LineWidth',1.2);         
    xlabel('Time(days)','fontsize',16)
    ylabel('Infected population(Density)','fontsize',16);
    legend({'Data of cases', 'Model fit to data'},'FontSize',16);

set(gca, 'LooseInset', get(gca, 'TightInset'));
print('-r300','-depsc2', '-loose',['fig_sir_data_model','.eps']);   
print('-r300','-dpng',  ['fig_sir_data_model','.png']);  
print('-r300','-djpeg', ['fig_sir_data_model','.jpg']);  

%%
function dy = sir_model(t,y)
% Susceptible-Infected Model 
global beta gamma 
  dy=zeros(3,1);
    S = y(1);
    I = y(2);
    R = y(3);
    N=S+I+R;
dy(1)= -beta.*S.*I./N;              %Susceptible
dy(2)= beta.*S.*I./N-gamma.*I;      %Infected
dy(3)= gamma.*I;                    %Recovered
return
end