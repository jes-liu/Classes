function competition_mixed
clf; clc; clear memory; clear all; close all
% global t U V alpha beta gamma epsilon
% Ploting the squirrel data
%%  Intraspecific competition
data12 = load('Mixed_Culture_Yeast_1_2.txt');  % Mixed Culture Yeast 1 2

% Mixed culture
t3= data12(:,1)        %;		% time
U1m_data =data12(:,2)  %;		% S. cerevisiae (Volume)
U2m_data =data12(:,3)  %;		% S. kephir (Volume)
%% Interspecific Competition - Yeast Mixed culture
figure
plot(t3, U1m_data,'ro-','LineWidth',1);   % plot S. cerevisiae (Volume) data
hold on
plot(t3, U2m_data , 'bo-','LineWidth',1);  % plot S. kephir (Volume) data

title('Interspecific Competition - Yeast Mixed culture','fontsize',14)
xlabel('Time','fontsize',14)
ylabel(' Mixed Culture Yeast species (Volume)','fontsize',14)
legend('S. cerevisiae (Volume)','S. kephir (Volume)','location','best')
print('-r300','-depsc2',[ 'fig_compet_mix12_data','.eps']); 
hold off
%% Mixed culture Model:
%SET INITIAL CONDITIONS ##################################################### 
global Ro1 Ro2 alpha beta k1 k2  
U1=U1m_data(1,1);           % Initial prey population
U2=U2m_data(1,1);           % Initial predator population 
U1U20 = [U1 U2]';

%% set constants
Ro1=0.25864;
Ro2=0.057443;
k1=12.742;
k2=5.8802;
alpha=0.995;
beta=0.41;

h = .01; % time steps
tSpan = 0:h:50; % set time interval

%% ** ODE solver **
[t,X] = ode45(@compet,tSpan,U1U20); 
figure
plot(t,X(:,1), 'r-','LineWidth',1);   % plot S. cerevisiae (Volume) data
hold on
plot(t,X(:,2), 'b-','LineWidth',1);   % S. kephir (Volume) (Volume) data

title('Interspecific Competition - Yeast Mixed culture','fontsize',14)
xlabel('Time','fontsize',14)
ylabel(' Mixed Culture Yeast species (Volume)','fontsize',14)
legend('S. cerevisiae (Volume)','S. kephir (Volume)','location','best')
print('-r300','-depsc2',[ 'fig_compet_mix12_model','.eps']); 

hold off

%% Use the meshgrid function to generate two matrices (UU and VV) of U and V values
xMin = 0;
xMax = 15;
yMin = 0;
yMax = 15;
gWidth =0.6;

range_U1 = xMin:gWidth:xMax;
range_U2 = yMin:gWidth:yMax;

[U1,U2]=meshgrid(range_U1, range_U2);
dU1dt = Ro1.*U1.*(1-(U1+alpha*U2)./k1); %Species 1
dU2dt=  Ro2.*U2.*(1-(U2+beta*U1)./k2);  %Species 2
L = sqrt(dU1dt.^2 + dU2dt.^2);
figure
quiver(U1,U2,dU1dt./L,dU2dt./L, 0.7,  'k-', 'LineWidth', 0.5)              % plot 
hold on  

nc_U10 = 0*(ones(1,length(range_U1))); % U1 0 null_clines 
nc_U1 = k1-range_U2.*alpha;            % U1 null_clines 

nc_U20 = 0*(ones(1,length(range_U2))); % U2 0 null_clines 
nc_U2 = k2-range_U1.*beta;             % U2 null_clines 

plot(nc_U10,range_U1,'r--','LineWidth',2); % plot U1 0 null_cline
plot(nc_U1,range_U2,'r--','LineWidth',2);  % plot U1 null_cline
hold on  

plot(range_U2,nc_U20,'b-','LineWidth',2); % plot U2 0 null_cline
plot(range_U1,nc_U2,'b-','LineWidth',2);  % plot U2 null_cline
axis([xMin xMax yMin yMax])
xlabel('S. cerevisiae (Volume)','fontsize',14)
ylabel('S. kephir (Volume)','fontsize',14);
print('-r300','-depsc2',[ 'fig_compet_mix12_model','.eps']); 
end

% end

function dy = compet(t,y)
% Competition Model for Two Species
  global Ro1 Ro2 alpha beta k1 k2  
  dy=zeros(2,1);
    U1 = y(1);
    U2 = y(2);
dy(1)= Ro1.*U1.*(1-(U1+alpha*U2)./k1); %Species 1
dy(2)= Ro2.*U2.*(1-(U2+beta*U1)./k2);  %Species 2
return
end
