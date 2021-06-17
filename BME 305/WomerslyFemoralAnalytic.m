% WomerslyFemoralAnalytic.m
%
%		Produces animation of Womersly solution velocity profile at a single frequency for a typical 
%       femoral artery 
%		Also produces a plot of wall shear stress vs. time.  Hit return to move to animation.
%

T = 0.82;		% period, in seconds
a = 0.25;		% radius, in cm
nu = 0.04;	% kinematic viscosity, in cm2/s
rho = 1.0;	% density, g/ml
KQ = 100;	% Flow rate amplitude, in ml/s
Pp = -8*nu*KQ/(pi*a^4);	% initialize pressure gradient array with DC component
ny = 21;		% # points in profile (over diameter)
nt = 30;		% # time points to calculate over period

y = [-1: 2/(ny-1): 1]';	% column vector of y's
t = [0: T/nt : T]; 		% row vector of times

w = 2*pi/T;					% radian frequency
alpha = a*sqrt(w/nu);	% Womersly parameter, single frequency

j = sqrt(-1);
j32 = j^1.5;

K = -KQ*rho*j^3*w/(pi*a^2*(1 - 2*besselj(1,j32*alpha)/(j32*alpha*besselj(0,j32*alpha))));
Ktau = rho*K*a*besselj(1,j32*alpha)/(j32*alpha*besselj(0,j32*alpha));
J0y = besselj(0,(j32*alpha*y));
A1 = -K*a^2/(nu*alpha^2*i^3);
A2 = 1 - J0y/J0y(ny);
A3 = exp(i*w*t);

%  Compute and plot velocity profiles
ucomplex = A1*A2*A3;
u = real(ucomplex);
umin = min(min(u));  umax = max(max(u));
clear M;
for n = 1:nt
   plot(u(:,n),y); axis([1.1*umin 1.1*umax -1 1]);
   xlabel('U(y,t)'); ylabel('y');
   M(n) = getframe;
end

moviereps = 5;	% number of repetitions of the movie
speedratio = 0.5;	% ratio of movie speed to actual speed
movie(M,moviereps,speedratio*nt/T);

%  Plot from the movie velocity profiles at given time points in the cycle
%
figure;
for n = 1
   time = n*T/nt;
   subplot(3,4,1); plot(u(:,n),y); axis([1.1*umin 1.1*umax -1 1]);
   xlabel('U(y,t=0.025 s)','FontSize',8); ylabel('y','FontSize',8);
   set(gca,'FontSize',6)
end
for n = 3
   subplot(3,4,2); plot(u(:,n),y); axis([1.1*umin 1.1*umax -1 1]);
   xlabel('U(y,t=0.075 s)','FontSize',8); ylabel('y','FontSize',8);
   set(gca,'FontSize',6)
end
for n = 7
   subplot(3,4,3); plot(u(:,n),y); axis([1.1*umin 1.1*umax -1 1]);
   xlabel('U(y,t=0.175 s)','FontSize',8); ylabel('y','FontSize',8);
   set(gca,'FontSize',6)
end
for n = 10
   subplot(3,4,4); plot(u(:,n),y); axis([1.1*umin 1.1*umax -1 1]);
   xlabel('U(y,t=0.25 s)','FontSize',8); ylabel('y','FontSize',8);
   set(gca,'FontSize',6)
end
for n = 12
   subplot(3,4,5); plot(u(:,n),y); axis([1.1*umin 1.1*umax -1 1]);
   xlabel('U(y,t=0.3 s)','FontSize',8); ylabel('y','FontSize',8);
   set(gca,'FontSize',6)
end
for n = 15
   subplot(3,4,6); plot(u(:,n),y); axis([1.1*umin 1.1*umax -1 1]);
   xlabel('U(y,t=0.375 s)','FontSize',8); ylabel('y','FontSize',8);
   set(gca,'FontSize',6)
for n = 18
   subplot(3,4,7); plot(u(:,n),y); axis([1.1*umin 1.1*umax -1 1]);
   xlabel('U(y,t=0.45 s)','FontSize',8); ylabel('y','FontSize',8);
   set(gca,'FontSize',6)
end
for n = 20
   subplot(3,4,8); plot(u(:,n),y); axis([1.1*umin 1.1*umax -1 1]);
   xlabel('U(y,t=0.5 s)','FontSize',8); ylabel('y','FontSize',8);
   set(gca,'FontSize',6)
end
for n = 23
   subplot(3,4,9); plot(u(:,n),y); axis([1.1*umin 1.1*umax -1 1]);
   xlabel('U(y,t=0.575 s)','FontSize',8); ylabel('y','FontSize',8);
   set(gca,'FontSize',6)
end
for n = 26
   subplot(3,4,10); plot(u(:,n),y); axis([1.1*umin 1.1*umax -1 1]);
   xlabel('U(y,t=0.65 s)','FontSize',8); ylabel('y','FontSize',8);
   set(gca,'FontSize',6)
end
for n = 28
   subplot(3,4,11); plot(u(:,n),y); axis([1.1*umin 1.1*umax -1 1]);
   xlabel('U(y,t=0.7 s)','FontSize',8); ylabel('y','FontSize',8);
   set(gca,'FontSize',6)
end
for n = 30
   subplot(3,4,12); plot(u(:,n),y); axis([1.1*umin 1.1*umax -1 1]);
   xlabel('U(y,t=0.75 s)','FontSize',8); ylabel('y','FontSize',8);
   set(gca,'FontSize',6)
end
figure;
%  Plot time waveforms of flow, pressure gradient, wall shear stress, and centerline velocity
%  Compute and plot wall shear stress
 taucomplex = Ktau*A3;
 tau = real(taucomplex);
 KQ = KQ + real(KQ*A3);
 Pp = Pp + real(K*A3);
subplot(2,2,1); plot(t,KQ); xlabel('time (s)'); ylabel('Flow Rate (ml/s)');
subplot(2,2,2); plot(t,tau); xlabel('time (s)'); ylabel('Wall Shear Stress (Pa)');
subplot(2,2,3); plot(t,Pp); xlabel('time (s)'); ylabel('Pressure Gradient (dyn/cm^3)');
subplot(2,2,4); plot(t,u((ny+1)/2,:)); xlabel('time (s)'); ylabel('Centerline Velocity (cm/s)');
end
