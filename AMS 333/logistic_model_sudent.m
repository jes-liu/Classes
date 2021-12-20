clf; clc; clear memory; clear all; close all

% Fitting Data to a Logistic Model: Algae growth
% Here is the data will work with.
data=load('data_Algae.txt')

% t is the time (in days) of the experiment
 t= data(:,1);

% M is the biomass of algae, measured in square millimeters on a petri dish.
 M= data(:,2);


% Fitting the data to a logistic function
%  M(t)=(k)/(1+e^{r(t-t_0))

% Try out some intitial guesses
% We use r=665 as before and experiment with r and t

K= 5;
r= .5;
t0= 10;
tt= 0:90;
plot(t,M,'or','LineWidth',2);

hold on 

plot(tt,logistic_model(tt,K,r,t0),'blue','LineWidth',1);

title('First test')
xlabel('Time (days)')
ylabel('Biomass $(mm^2)$')

% print('-r300','-djpeg',[ 'fig_log_mod_1','.jpeg'])

% K= ;
% r= ;
% t0= ;

figure(3);
plot(t,M,'or','LineWidth',2); 

hold on 

plot(tt,logistic_model(tt,K,r,t0),'blue','LineWidth',1);

title('Second test')
xlabel('Time (days)')
ylabel('Biomass $(mm^2)$')

% print('-r300','-djpeg',[ 'fig_log_mod_2','.jpeg'])





% This program calls two simple functions logistic_model
 
function y = logistic_model(tt,K,r,t0)
y= (k)./(1+e.^(r.*(tt-t_0)));
end


