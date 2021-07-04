% Jesse Liu 111639610
clear all;close all;clc;

%% Given
v_na = 55; % Nernst potential of sodium (mV)
v_k = -72; % Nernst potential of potassium (mV)
gna_bar = 120; % max sodium conductance (mV)
gk_bar = 36; % max potassium conductance (mV)
c_m = 1; % capacitance of membrane (uF)
tau = .1; % time constant (msec)
r = (tau/c_m)/1000; % membrance resistance (ohm)

timing = [-10:.1:20];
v = 0; % membrane command voltage (mV)
initial = [0.3173 0.0529 0.5838]; % [n0, m0, h0]

%% Solver and Equations
[t,x] = ode15s(@conductances,[0 20],initial,[],v+60); % ode equation
n = x(:,1);
m = x(:,2);
h = x(:,3);
gk = gk_bar.*n.^4; % changing n from dn/dt to conductance (mS/cm^2)
gna = gna_bar.*m.^3.*h; % changing m/h to conductance (mS/cm^2)

ik = gk.*n.^4.*(v-v_k)./1000; % potassium current (mA/cm^2)
ina = gna.*m.^3.*h.*(v-v_na)./1000; % sodium current (mA/cm^2)

final_ik = zeros(length(timing),1);
final_ina = zeros(length(timing),1);

final_ik(101:end) = interp1(t,ik,timing(101:end));
final_ina(101:end) = interp1(t,ina,timing(101:end));

total_ik = (v-v_k)/r; % mA

%% First Subplot
hold on
figure(1)
subplot(4,1,1)
plot(timing,total_ik)
ylabel('I_T (mA/cm^2)')
xlabel('Time (msec)')
ylim([-2 7])
xlim([-2 10])
yline(0);

subplot(4,1,2)
plot(timing,final_ina)
ylabel('I_{na} (mA/cm^2)')
xlabel('Time (msec)')
ylim([-2 7])
xlim([-2 10])
yline(0);

subplot(4,1,3)
plot(timing,final_ik)
ylabel('I_k (mA/cm^2)')
xlabel('Time (msec)')
ylim([-2 7])
xlim([-2 10])
yline(0);

subplot(4,1,4)
plot(timing,total_ik)
ylabel('I_c (mA/cm^2)')
xlabel('Time (msec)')
ylim([-1 1])
xlim([-2 10])
yline(0);
hold off

%% Second Subplot
hold on
figure(2)
subplot(2,1,1)
plot(timing,gna)
ylabel('g_{na} (mS/cm^2)')
xlabel('Time (msec)')
ylim([-10 50])
xlim([-2 10])
yline(0);

subplot(2,2,1)
plot(timing,gk)
ylabel('g_k (mS/cm^2)')
xlabel('Time (msec)')
ylim([-10 60])
xlim([-2 10])
yline(0);

%% Function
function f = conductances(t,x,v)

n = x(1);
m = x(2);
h = x(3);

alpha = (.01.*(10-v))./(exp((10-v)./10)-1);  % alpha equation
beta = .125.*exp(-v./80);  % beta equation
fn = alpha.*(1-n) - beta.*n;  % dn/dt equation

alpha_m = (.1.*(25-v))./(exp((25-v)./10)-1);  % alpha equation for m
beta_m = 4.*exp(-v./18);  % beta equation for m
fm = alpha_m.*(1-m) - beta_m.*m;

alpha_h = .07.*exp(-v./20);  % alpha equation for h
beta_h = 1./(exp((30-v)./10)+1);  % beta equation for h
fh = alpha_h.*(1-h) - beta_h.*h;

f = [fn fm fh]';
end