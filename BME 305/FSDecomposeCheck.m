% FSDecomposeCheck.m
%
%   Makes a Fourier series decomposition of a waveform, from a tab-delimited test file
%       named 'femoralraw.txt', containing equally spaced (time, flow) data
%		  Plots Fourier series with orginal data for quality control.
%
%   Use this routine to prepare data for a Womersly solution for real flow waveform
%       (ie as a preprocessing step prior to running WomerslyQWave.m)

% read flow rate waveform from file
Qraw = dlmread('femoralraw.txt','\t');
t = Qraw(:,1);
Qraw = Qraw(:,2);

nf = 14;				% Number of frequencies for resynthesized flow wave.
KQ = ones(1,nf)'; w = ones(1,nf)';		% initialize arrays
T = max(t) + (t(2)-t(1));
nt = size(t);  nt = max(nt);

Qf = fft(Qraw);		% Calculate discrete Fourier Series expansion of flow waveform

% Recombine FFT coefficients to get Fourier Series Coefficients; compute frequencies
KQ0 = real(Qf(1))/nt;

j = sqrt(-1);
j32 = j^1.5;

for n = 1:nf
   KQ(n) = 2*Qf(n+1)/nt;
   w(n)	= 2*pi*n/T;
end
KQmag = [KQ0; abs(KQ)];
KQphase = [0.0; angle(KQ)];

t1 = [0:0.001*T:(T - (t(2)-t(1)))]';
nt1 = size(t1);  nt1 = max(nt1);

Q = KQ0*ones(1,nt1)';

for n = 1:nf
   for k = 1:nt1
      Q(k) = Q(k) + real(KQ(n)*exp(j*w(n)*t1(k)));
   end
end

plot(t,Qraw,t1,Q); xlabel('Time (s)'); 
ylabel('Q (ml/s)'); 
legend('Original','Fourier Series');

