function competition_mono
clf; clc; clear memory; clear all; close all
% global t U V alpha beta gamma epsilon
% Ploting the squirrel data
%%  Intraspecific competition
data1  = load('Monoculture_Yeast_1.txt');      % Mono culture Yeast 1
data2  = load('Monoculture_Yeast_2.txt');      % Mono culture Yeast 2
 
% Single-species cultures   
t1= data1(:,1);		% time
U1_data = data1(:,2);		% S. cerevisiae (Volume)

t2= data2(:,1);		% time
U2_data = data2(:,2);		% S. kephir (Volume)

%% Plot time vs. prey and predator on the same graph 
figure
subplot(2,1,1);
plot(t1, U1_data,'ro-','LineWidth',1);    % plot prey data
title('Yeast Single-species: S. cerevisiae (Volume)','fontsize',14)
xlabel('Time','fontsize',14)
ylabel('S. cerevisiae (Volume)','fontsize',14)
legend('S. cerevisiae (Volume)','location','best')
hold on

subplot(2,1,2);
plot(t2,U2_data , 'bo-','LineWidth',1);  % plot predator data
title('Yeast Single-species: S. kephir (Volume)','fontsize',14)
xlabel('Time','fontsize',14)
ylabel('S. kephir (Volume)','fontsize',14)
legend('S. kephir (Volume)','location','best')

print('-r300','-depsc2',[ 'fig_compet_mono_data','.eps']); 
 

%% Monoculture Model:
%% INITIAL CONDITIONS ##################################################### 
global Ro1 Ro2 alpha beta k1 k2  
U1=U1_data(1);           % Initial prey population
U2=U2_data(1);           % Initial predator population 
U1U20 = [U1 U2]';

Ro1=0.25864;
Ro2=0.057443;
k1=12.742;
k2=5.8802;
alpha=0;
beta=0;


tSpan = 0:140;

%% ** ODE solver **
[t,X] = ode45(@compet,tSpan,U1U20); 
  figure
subplot(2,1,1);
plot(t,X(:,1),'r','LineWidth',1);    % plot prey data
title('Yeast Single-species: S. cerevisiae (Volume)','fontsize',14)
xlabel('Time','fontsize',14)
ylabel('S. cerevisiae (Volume)','fontsize',14)
legend('S. cerevisiae (Volume)','location','best')

hold on
subplot(2,1,2);
plot(t,X(:,2), 'b','LineWidth',1);  % plot predator data
title('Yeast Single-species: S. kephir (Volume)','fontsize',14)
xlabel('Time','fontsize',14)
ylabel('S. kephir (Volume)','fontsize',14)
legend('S. kephir (Volume)','location','best')
print('-r300','-depsc2',[ 'fig_compet_mono_model','.eps']); 
 
end

% end

function dy = compet(t,y)
% Competition Model for Two Species
  global Ro1 Ro2 alpha beta k1 k2  
  dy=zeros(2,1);
    U1 = y(1);
    U2 = y(2);
dy(1)= Ro1.*U1.*(1-(U1+alpha.*U2)./k1) ; %Species 1
dy(2)= Ro2.*U1.*(1-(U2+beta.*U1)./k2) ; %Species 2
return
end
