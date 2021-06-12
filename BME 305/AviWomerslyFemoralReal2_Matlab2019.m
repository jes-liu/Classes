% FSDecomposeCheck.m
%
%   Makes a Fourier series decomposition of a waveform, from a tab-delimited test file
%       named 'femoralraw.txt', containing equally spaced (time, flow) data
%		  Plots Fourier series with orginal data for quality control.
%
%   This routine prepares the data for a Womersly solution for real flow waveform
%       (ie as a preprocessing step prior to running WomerslyQWave.m - below)

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

t1 = (0:0.001*T:(T - (t(2)-t(1))))';
nt1 = size(t1);  nt1 = max(nt1);

Q = KQ0*ones(1,nt1)';

for n = 1:nf
   for k = 1:nt1
      Q(k) = Q(k) + real(KQ(n)*exp(j*w(n)*t1(k)));
   end
end
figure;
plot(t,Qraw,'red',t1,Q,'blue'); xlabel('Time (s)'); 
ylabel('Q (ml/s)'); 
legend('Original Data','Fourier Series');
pause

%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% Proceed to the next stage by pressing Return in the Command Window
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% WomerslyQWave.m
%
%		Calculates Womersly solution for fully developed, periodic laminar flow in a straight tube
%		Uses KQ, the Fourier Series amplitudes of a flow waveform, calculated by FSDecomposeCheck
%     
%     Calculates velocity profiles, and pressure, wall shear stress, and centerline velocity waveforms
%     Also produces an animation of the flow profile.
%

T = 0.82;		% period, in seconds
a = 0.25;		% radius, in cm
% KQ is from workspace, as is KQ0 (DC component of flow)
nu = 0.04;	% kinematic viscosity, in cm2/s
rho = 1.0;	% density, g/ml
ny = 21;		% # points in profile (over diameter)
nt = 30;		% # time points to calculate over period
nf = size(KQ);  nf = nf(1);		% # of nonzero frequencies
temp2 = ones(nt);  temp2 = temp2(1,:);

y = (-1: 2/(ny-1): 1)';				% column vector of y's
t = (0: T/nt : T); t = t(1:nt);	% row vector of times

w0 = 2*pi/T;				% fundamental radian frequency
alpha0 = a*sqrt(w0/nu);	% Womersly parameter, single frequency
w = w0*(1:nf);				% array of radian frequencies
alpha = a*sqrt(w/nu);	% array of Womersly parameters
K = 0*KQ;					% initialize pressure gradient array
Q = KQ0*temp2;				% initialize flow rate array with DC flow component
Pp = -8*nu*Q/(pi*a^4);	% initialize pressure gradient array with DC component
Tau_steady = -a*Pp/2;	% initialize wall shear stress array with DC component
Tau = Tau_steady;
j = sqrt(-1);
j32 = j^1.5;

u = (2*KQ0/(pi*a^2))*((1 - y.*y)*temp2);

for n = 1:nf		% Sum over all frequencies
   K(n) = KQ(n)*j*w(n)*rho/(pi*a^2*(1 - 2*besselj(1,j32*alpha(n))/(j32*alpha(n)*besselj(0,j32*alpha(n)))));
   Ktau(n) = rho*K(n)*a*besselj(1,j32*alpha(n))/(j32*alpha(n)*besselj(0,j32*alpha(n)));
   for k = 1:nt		% Calculate for each point in time
      Q(k) = Q(k) + real(KQ(n)*exp(j*w(n)*t(k)));
      Pp(k) = Pp(k) + real(K(n)*exp(j*w(n)*t(k)));
      Tau(k) = Tau(k) + real(Ktau(n)*exp(j*w(n)*t(k)));
      for m = 1:ny		% Calculate for each spatial location y
         u(m,k) = u(m,k) + real((K(n)*a^2/(nu*alpha(n)^2*i))*(1-besselj(0,j32*alpha(n)*y(m))/besselj(0,j32*alpha(n)))*exp(i*w(n)*t(k)));
      end	% y loop
   end	% t loop
end	% f loop

umin = min(min(u));  umax = max(max(u));
% Make an animated velocity profile plot
clear M;
% Movie = VideoWriter('femoral.avi','Motion JPEG AVI');%,'compression','None','fps',10);
% Movie.Quality = 25;
% open(Movie);
for n = 1:nt
   %Fig = figure('Visible','off');
   plot(u(:,n),y); axis([1.1*umin 1.1*umax -1 1]);
   xlabel('U(y,t)'); ylabel('y');
   M(n)=getframe;
   %Movie = writeVideo(Movie,Fig);
%    close(Fig);
end
% 
% for o=1:length(M)
%     frame=M(o);
%     writeVideo(Movie,frame);
% end

%close(Movie);
moviereps = 2;	% number of repetitions of the movie
%speedratio = 0.5;	% ratio of movie speed to actual speed
% if gt(moviereps,1)
%     femoral=VideoReader('femoral.avi');
%     femoral2=[];
%     for n=1:moviereps
%         femoral2=cat(2,femoral2,femoral);
%     end
    movie(M,1)%(femoral2,'femoral.avi','compression','None');
% end
%figure;
%pause
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% Proceed to the next figure by pressing Return in the Command Window
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

%  Plot from the movie velocity profiles at four time points in the cycle
%
figure;
for n = 1
   time = n*T/nt
   set(axes,'FontSize',8)
   subplot(3,4,1); plot(u(:,n),y); axis([1.1*umin 1.1*umax -1 1]);
   xlabel('U(y,t=0.027 s)','FontSize',8); ylabel('y','FontSize',8);
end
for n = 3
   subplot(3,4,2); plot(u(:,n),y); axis([1.1*umin 1.1*umax -1 1]);
   xlabel('U(y,t=0.082 s)','FontSize',8); ylabel('y','FontSize',8);
end
for n = 7
   subplot(3,4,3); plot(u(:,n),y); axis([1.1*umin 1.1*umax -1 1]);
   xlabel('U(y,t=0.191 s)','FontSize',8); ylabel('y','FontSize',8);
end
for n = 10
   subplot(3,4,4); plot(u(:,n),y); axis([1.1*umin 1.1*umax -1 1]);
   xlabel('U(y,t=0.273 s)','FontSize',8); ylabel('y','FontSize',8);
end
for n = 12
   subplot(3,4,5); plot(u(:,n),y); axis([1.1*umin 1.1*umax -1 1]);
   xlabel('U(y,t=0.328 s)','FontSize',8); ylabel('y','FontSize',8);
end
for n = 15
   subplot(3,4,6); plot(u(:,n),y); axis([1.1*umin 1.1*umax -1 1]);
   xlabel('U(y,t=0.410 s)','FontSize',8); ylabel('y','FontSize',8);

for n = 18
   subplot(3,4,7); plot(u(:,n),y); axis([1.1*umin 1.1*umax -1 1]);
   xlabel('U(y,t=0.492 s)','FontSize',8); ylabel('y','FontSize',8);
end
for n = 20
   subplot(3,4,8); plot(u(:,n),y); axis([1.1*umin 1.1*umax -1 1]);
   xlabel('U(y,t=0.547 s)','FontSize',8); ylabel('y','FontSize',8);
end
for n = 23
   subplot(3,4,9); plot(u(:,n),y); axis([1.1*umin 1.1*umax -1 1]);
   xlabel('U(y,t=0.628 s)','FontSize',8); ylabel('y','FontSize',8);
end
for n = 26
   subplot(3,4,10); plot(u(:,n),y); axis([1.1*umin 1.1*umax -1 1]);
   xlabel('U(y,t=0.711 s)','FontSize',8); ylabel('y','FontSize',8);
end
for n = 28
   subplot(3,4,11); plot(u(:,n),y); axis([1.1*umin 1.1*umax -1 1]);
   xlabel('U(y,t=0.765 s)','FontSize',8); ylabel('y','FontSize',8);
end
for n = 30
   subplot(3,4,12); plot(u(:,n),y); axis([1.1*umin 1.1*umax -1 1]);
   xlabel('U(y,t=0.820 s)','FontSize',8); ylabel('y','FontSize',8);
end

figure;

%pause
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% Proceed to the next figure by pressing Return in the Command Window
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

%  Plot time waveforms of flow, pressure gradient, wall shear stress, and centerline velocity
set(gca,'XTick',0:0.2:0.82)
subplot(2,2,1); plot(t,Q); xlabel('Time (sec)'); ylabel('Flow Rate (ml/s)');
subplot(2,2,2); plot(t,Pp); xlabel('Time (sec)'); ylabel('Pressure Gradient (dyn/cm^3)');
subplot(2,2,3); plot(KQphase); xlabel('Angle'); ylabel('Phase Lag');
subplot(2,2,4); plot(t,Tau,t,Tau_steady); xlabel('Time (sec)'); ylabel('Wall Shear Stress (dyn/cm^2)');
end