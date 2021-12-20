function predator_prey_data
clf; clc; clear memory; clear all; close all
global t U V alpha beta gamma epsilon
% Ploting the squirrel data
%%
data = load('predator_prey_data.txt');
t= data(:,1);		% Generation(time)
U_data = data(:,2);		% prey equation	
V_data = data(:,3);		% predator equation
%% Plot time vs. prey and predator on the same graph 
figure
plot(t,U_data,'ro','LineWidth',1);    % plot prey data
hold on
plot(t,V_data,'bo','LineWidth',1);  % plot predator data

title('Predator-Prey Interaction Model','fontsize',14)
xlabel('Generation(time)','fontsize',14)
ylabel('Rabbits, Wolves(Number)','fontsize',14)
legend('Rabbits','Wolves')
print('-r300','-depsc2',[ 'fig_predator_prey','.eps']); 
hold off
%% Number of Wolves vs Rabbits
figure
N=length(U_data);
grads= flipud((hot(N))); % flipud  

scatter(U_data,V_data,20,grads,'filled','MarkerEdgeColor','black')

title('Number of Wolves vs Rabbits','fontsize',14)
xlabel('Rabbits(Number)','fontsize',14)
ylabel('Wolves(Number)','fontsize',14)
print('-r300','-depsc2',[ 'fig_pred_prey_pp','.eps']); 
end

