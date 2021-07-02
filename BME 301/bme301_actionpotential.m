% Jesse Liu 111639610
clear all;clc;

I_app = 6.2;
[t,x] = ode15s(@actionpotential,[0 30],[-0.0090 0.0529 0.3173 0.5838],[],I_app)

voltage = x(:,1)-60;
figure(1)
plot(t,voltage)
xlabel('Time (msec)')
ylabel('voltage (mV)')

for i = 1:length(x)
 [f, G3(i,:)] = actionpotential(0,x(i,:),I_app);
end

figure(2)
plot(t,G3(:,1),'k','linewidth',1.5);
hold on
plot(t,G3(:,2),'k--','linewidth',1.5);
set(gca,'Fontsize',18);
hold off; box on; axis([0 30 0 45]);
xlabel('$t$ (ms)','interpreter','latex','fontsize',20);
ylabel('Conductance(mS$\cdot$cm$^{-2}$)','interpreter','latex','fontsize',20);
text(16.4,21,'$g_{Na}$','interpreter','latex','fontsize',20);
text(19,8,'$g_{K}$','interpreter','latex','fontsize',20);

function [f,varargout] = actionpotential(t,x,I_app)

% Resting potentials, conductivities, and capacitance:
V_Na = 115;
V_K = -12;
V_L = 10.6;
g_Na = 120;
g_K = 36;
g_L = 0.3;
C_m = 1e-6;

% State Variables:
v = x(1);
m = x(2);
n = x(3);
h = x(4);

% alphas and betas:
alpha_m = (.1.*(25-v))./(exp((25-v)./10)-1);
beta_m = 4.*exp(-v./18);
alpha_h = .07.*exp(-v./20);
beta_h = 1./(exp((30-v)./10)+1);
alpha_n = (.01*(10-v))/(exp((10-v)/10)-1);
beta_n = .125*exp(-v/80);

% Computing currents: for these, look at the HH equation including all the
% currents, and separate them into three different terms
I_Na = g_Na*m^3*h*(v-V_Na);
I_K = g_K*n^4*(v-V_K);
I_L = g_L*(v-V_L);

% Computing derivatives:
f(1,1) = (I_app - I_Na - I_K - I_L)/C_m;
f(2,1) = alpha_m.*(1-m) - beta_m.*m;
f(3,1) = alpha_n*(1-n) - beta_n*n;
f(4,1) = alpha_h.*(1-h) - beta_h.*h;

% Outputting the conductivities
varargout{1} = [g_Na*m^3*h, g_K*n^4, g_L];
end