% Ploting the Logistic Model
clf; clc; clear memory; clear all; close all
global t U V alpha beta gamma epsilon

data = load('');
% 
%%
t= data(:,1);			% Generation
U_data = data(:,2);		% prey equation	
V_data = data(:,3);		% predator equation
%% 
alpha=0.03;
gamma=0.0005;
beta=0.05;
epsilon=1;
xMin = 0;
xMax = 180;
yMin = 0;
yMax = 140;
gWidth =7;

range_U = xMin:gWidth:xMax;
range_V = yMin:gWidth:yMax;

%% Use the meshgrid function to generate two matrices (UU and VV) of U and V values
[UU,VV]=meshgrid(range_U, range_V);
dUdt =alpha.*UU-gamma*VV.*UU;
dVdt = epsilon*gamma*UU.*VV-beta*VV;

quiver(UU,VV,dUdt,dVdt)          % plot 
axis([xMin xMax yMin yMax])
    title('Number of Wolves vs Rabbits','fontsize',14)
    xlabel('Rabbits(Number)','fontsize',14)
    ylabel('Wolves(Number)','fontsize',14)
    print('-r300','-depsc2',[ 'fig_pred_prey_pp_m','.eps']);
%% 
hold on  

nc_U = (beta/(gamma*epsilon))*(ones(1,length(range_V)));
nc_V = alpha/gamma*(ones(1,length(range_U)));

plot(nc_U,range_V,'r');
hold on  
plot(range_U,nc_V,'b');

%% INITIAL CONDITIONS ##################################################### 
U0=U_data(1);           % Initial prey population
V0=V_data(1);           % Initial predator population 
UV0 = [U0 V0]';

tSpan = 0:0.1:length(V_data);

%% ** ODE solver **
[t,X] = ode45(@dxdt,tSpan,UV0); 
plot(X(:,1),X(:,2),'k');
legend('','Rabbits','Wolves', 'Solution')
print('-r300','-depsc2',[ 'fig_predator_prey_ps','.eps']); 
hold off

%% 
function dy=dxdt(t,y)
global alpha beta gamma epsilon
    dy=zeros(2,1);
    U = y(1);
    V = y(2);
    
    dy(1)=  ;	     % dU' prey equation
    dy(2)=  ;         % dV' predator equation
return
end
