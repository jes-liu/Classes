% Jesse Liu 111639610 and Terrance Leung 111627721
clear all;close all;clc;
%% A
syms Glu(t) tau r t tca
Glu = diff(Glu(t),t) == -Glu(t)/tau + r*(t-tca);
Glu = dsolve(Glu);  % (M*s)

tau_Glu = .001;  % decay rate of glutamate (s)
r_Glu = 10*10^(-6);  % max rate of glutamate production (M*s^-1)
t_Ca = 1;  % calcium threshold crossing
C1 = 1;
t = 0;  % initial time
m_eSP = 55*10^3;  % e-SP weighing factor
tau_eSP = 40;  % decay rate of eSP (s)
eSP(1) = 0;  % initial value of Endocannabinoid-Mediated Synaptic Potentiation
deltat = .001;  % time span

for i=1:2000
    eSP(i+1) = eSP(i) + ((-eSP(i) + m_eSP.*(C1*exp(-t/tau_Glu) - r_Glu*tau_Glu^2 + r_Glu*t*tau_Glu - r_Glu*t_Ca*tau_Glu).*t)./tau_eSP).*deltat;
    t = t + deltat;
end

t = linspace(0,200,length(eSP));
subplot(2,1,1)
hold on
plot(t,eSP)
ylabel('eSP (M)')
xlabel('time (s)')


%% B
tau_AG = .1;  % decay rate of 2-arachidonoyl glycerol (s)
r_AG = .8*10^(-6);  % max rate of 2-arachidonoyl glycerol production (M*s^-1)
t_sp = 1;
deltat = .001;  % time span
t = 0;  % initial time
DSE(1) = 0;  % initial value of Depolarization-induced Suppression of Excitation
K_AG = -4000;  % scaling factor
AG(1) = 0;  % initial value of 2-arachidonoyl glycerol (M*s)

for i=1:2000
    AG(i+1) = AG(i) + (-AG(i)./tau_AG + r_AG.*(t-t_sp)).*deltat;
    DSE(i+1) = DSE(i) +AG(i).*K_AG;
    t = t + deltat;
end

t = linspace(0,200,length(DSE));
subplot(2,1,2)
DSE=-DSE;
plot(t,DSE)
ylabel('DSE (M)')
xlabel('time (s)')
hold off


%% C
PR0 = .5;  % initial transmission probability of each associated synapse
PR = (PR0/100)*DSE + (PR0/100)*eSP;  % transmission probability
t = linspace(0,200,length(PR));
figure()
plot(t,PR)
ylabel('PR (M)')
xlabel('time (s)')