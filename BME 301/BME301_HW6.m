% Jesse Liu 111639610
clear all;close all;clc;

%% 3a
t = 0:.01:10;
v0 = 20 - 60./(1+100.^(-(1.2.*t-6)));  % mV
figure()
plot(t,v0)
title('v_0')
xlabel('Distance (mm)')
ylabel('Voltage (mV)')

%% 3b
r = .5;  % this is r0/(r0+ri)
vm = - v0./r;
figure()
plot(t,vm)
title('v_m')
xlabel('Distance (mm)')
ylabel('Voltage (mV)')

%% 3c
dvmdz = diff(diff(vm));
km = dvmdz;
t = linspace(0,10,length(km));
figure()
plot(t,-km)
xlabel('Distance (mm)')
ylabel('Current per unit length (mA/mm)')
title('K_m')

%% Fourier Transform
% t = 0:0.001:1;
% N = 30;  % Hz signal
% signal = sin(30*2*pi*t);
% plot(t,signal)
% 
Fs = 1000;  % sampling frequency (samples/sec)
fourier_transformed_signal=fft(signal);
freqHz = (0:1:length(fourier_transformed_signal)-1)*Fs/N;
plot(freqHz,fourier_transformed_signal)

t = 0:0.001:1;
signal = sin(30*2*pi*t) + sin(60*2*pi*t);
plot(t,signal)
fourier_transformed_signal=fft(signal);
plot(freqHz,fourier_transformed_signal)
% 
% fourier_transformed_signal(55:65) = 0;
% fourier_transformed_signal(935:945) = 0;
% ind1 = find((freqHz>=55) & (freqHz<=65));
% freqHz(ind1)
% ind2 = find((freqHz>=935) & (freqHz<=945));
% freqHz(ind2)
% fourier_transformed_signal([ind1 ind2]) = 0;
% plot(freqHz,fourier_transformed_signal)
% 
% corrected=ifft(fourier_transformed_signal);
% plot(t,corrected,'r')

%% 4a
load('sample_ecg.mat')
t = 0:(1/1000):((length(ecg)-1)/1000);
figure()
plot(t,ecg,'r')
xlabel('Time (s)')
ylabel('Voltage (mV)')
title('ECG')

%% 4b
fourier_transformed_signal=fft(ecg);
fourier_transformed_signal(1) = 0;
corrected=ifft(fourier_transformed_signal);

%% 4c
Fs = 1000;  % sampling frequency (samples/sec)
N = length(ecg);  % Hz signal
freqHz = (0:1:length(fourier_transformed_signal)-1)*Fs/N;

bottom = find(freqHz <= 5);
top = find((1000-freqHz) <= 5);
fourier_transformed_signal(bottom) = 0;
fourier_transformed_signal(top) = 0;

%% 4d
corrected=ifft(fourier_transformed_signal);
figure()
plot(t,corrected,'r')
xlabel('Time (s)')
ylabel('Voltage (mV)')
title('Heartbeat')

%% 6a
t = [0 10.21 29.86 40.07 60.5 80.14 150.07 249.86 300.14 380.29];  % msec
RA = [0 0 -.3 -.7 -.1 0 -.02 -.12 -.14 0];
LA = [0 0 0 0 -.3 -.05 0 .06 .08 0];
LL = [0 .02 .2 .45 .35 .05 .01 .03 .02 .01];
figure()
plot(t,RA,t,LA,t,LL)
yline(0);
xlabel('Time (ms)')
ylabel('Voltage (mV)')
title('Leads I,II,III')
legend('Lead I','Lead II','Lead III')