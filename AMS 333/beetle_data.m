% Jesse Liu 111639610
function beetles
data1=load('beetle_Rhizopertha_data.txt');  %Rhizopertha mono data
data2=load('beetle_Oryzaephilus_data.txt');  %Oryzaphilus mono data

tR=data1(:,1);  %Rhizopertha time in days
beetleR=data1(:,2);  %Rhizopertha data

tO=data2(:,1);  %Oryzaphilus time in days
beetleO=data2(:,2);  %Oryzaphilus data

figure(1)
subplot(2,1,1)
plot(tR,beetleR,'bo-','LineWidth',1)
xlabel('time(days)')
ylabel('Beetle Growth')
title('Rhizopertha')
legend('Rhizopertha','location','best')
hold on
subplot(2,1,2)
plot(tO,beetleO,'ro-','LineWidth',1)
xlabel('time(days)')
ylabel('Beetle Growth')
title('Oryzaphilus')
legend('Oryzaphilus','location','best')
hold off

data3=load('beetle_Rhizo_Oryz_data.txt');  %Rhizo and Oryz mixed data
tOR=data3(:,1);
beetleRO=data3(:,2);
beetleOR=data3(:,3);
figure(2)
hold on
plot(tOR,beetleRO,'co-','LineWidth',1)
plot(tOR,beetleOR,'yo-','LineWidth',1)
xlabel('time(days)')
ylabel('Beetle Growth')
title('Rhizopertha and Oryzaphilus')
legend('Rhizopertha','Oryzaphilus','location','best')
hold off

R01=.051;
R02=.056;
k1=500;
k2=500;
alpha=.6;
beta=.31;

time=0:data3(end,1);
initial_U=[data3(1,2) data3(1,3)]';
[tt,dU]=ode45(@competition,time,initial_U);

figure(3)
subplot(2,1,1)
hold on
plot(time,dU(:,1),'g','LineWidth',1)
plot(tOR,beetleRO,'bo-','LineWidth',1)
hold off
xlabel('time(days)')
ylabel('Malthusian Growth')
title('Rhizopertha')
legend('Rhizopertha model','Rhizopertha data','location','best')

subplot(2,1,2)
hold on
plot(time,dU(:,2),'m','LineWidth',1)
plot(tOR,beetleOR,'ro-','LineWidth',1)
xlabel('time(days)')
ylabel('Malthusian Growth')
title('Oryzaphilus')
legend('Oryzaphilus model','Oryzaphilus data','location','best')
hold off

% Nullclines
figure(4)
hold on
plot([0 k1],[k1/alpha 0],'o-')
plot([0 k2/beta],[k2 0],'o-')
plot(245.096,424.02,'go')
[U1,U2]=meshgrid(0:200:2000,0:200:2000);
dU1=R01.*U1.*(1-(U1+alpha.*U2)./k1);
dU2=R02.*U2.*(1-(U2+beta.*U1)./k2);
quiver(U1,U2,dU1,dU2,'k')
xlim([0 2000])
ylim([0 2000])
xlabel('Rhizopertha population')
ylabel('Oryzaephilus population')
legend('dU1 nullcline','dU2 nullcline','Equilibrium point','quiver','location','best')
hold off

% Euler method
t(1)=0;
tstep=.01;
x(1)=data3(1,2);
y(1)=data3(1,3);

for i=1:20000
    x(i+1)=x(i)+(R01.*x(i).*(1-(x(i)+alpha.*y(i))./k1)).*tstep;  %Rhizopertha Euler
    y(i+1)=y(i)+(R02.*y(i).*(1-(y(i)+beta.*x(i))./k2)).*tstep;  %Oryzaephilus Euler
    t(i+1)=t(i)+tstep;
end

figure(5)
hold on
subplot(2,1,1)
plot(t,x,'c-','LineWidth',1)
xlabel('time(days)')
ylabel('Population')
title('Forward Euler Method - Rhizopertha')

subplot(2,1,2)
plot(t,y,'m-','LineWidth',1)
xlabel('time(days)')
ylabel('Population')
title('Forward Euler Method - Oryzaephilus')
hold off

figure(6)
plot(x,y,'r-','LineWidth',1)
xlabel('Oryzaephilus population')
ylabel('Rhizopertha population')
title('Rhizopertha vs Oryzaephilus euler method')
end

% ODE45 solver for Malthusian growth
function [dU]=competition(tt,U)
R01=.051;
R02=.056;
k1=500;
k2=500;
alpha=.6;
beta=.31;

dU=zeros(2,1);
U1=U(1);
U2=U(2);

dU(1)= R01.*U1.*(1-(U1+alpha.*U2)./k1);  %Rhizopertha data
dU(2)= R02.*U2.*(1-(U2+beta.*U1)./k2);  %Oryzaephilus data
return
end
