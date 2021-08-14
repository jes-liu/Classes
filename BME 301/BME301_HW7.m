% Jesse Liu 111639610
clear all;close all;clc;

%% 1a
N = 10;  % Number of motor units within a muscle
i = 1:.01:N;  % ith motor unit
a = 100;
b = (log(2000/100))/(i(end)-1);
n = a.*exp(b.*(i-1));  % number of motor unit fibers in the ith unit

figure()
plot(i,n)
xlabel('Motor units')
ylabel('Motor unit fibers')

%% 2
load('emg_conduction_velocity.mat')
time = linspace(0,(1/4000)*1000*length(emg_data),length(emg_data));  % 4000Hz to ms
figure()
plot(time,emg_data)
legend(legend_labels)
xlabel('time (ms)')
ylabel('emg amplitude (mV)')

distance = [7 10 12.5 35 45 61 66]*10;  % mm
time = [10.08 9.579 11.09 14.12 16.13 19.66 20.17];  % ms
figure()
scatter(time,distance,'o')
legend('Location','Best')
xlabel('time (ms)')
ylabel('distance (mm)')

%% 3
load('emg_signal_from_emglab.mat')
t = linspace(0,(1/10000)*1000*length(sig),length(sig));  % 10000Hz to ms
figure()
plot(t,sig)
xlabel('time (ms)')
ylabel('signal amplitude (mV)')

%% 3a
fourier = fft(sig);

Fs = 10000;  % sampling frequency (samples/sec)
N = length(sig);  % Hz signal
freqHz = (0:1:length(fourier)-1)*Fs/N;

bottom = find(freqHz <= 1000);
top = find((10000-freqHz) <= 1000);
fourier(bottom) = 0;
fourier(top) = 0;
correct = ifft(fourier);

t = linspace(0,(1/10000)*1000*length(correct),length(correct));
figure()
plot(t,correct)
ylabel('voltage (mV)')
xlabel('time (ms)')