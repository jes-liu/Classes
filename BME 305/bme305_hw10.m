% Homework 10 BME 305
clear all;close all;clc;
%this program will numerically integrate an expression describing blood
%flow through a diseased artery using Simpson's Rule, i.e. radius is not constant; flow rate (Q)
%is constant; normalized or nondimensional parameters are used
z=[0 .1 .2 .3 .4 .5 .6 .7 .8 .9 1];
r=[1 .73 .67 .65 .67 .80 .80 .71 .73 .77 1];
for i=1:10
    p(i)=((z(i+1)-z(i))/6)*(r(i)^-4+4*0.5*(r(i)^-4+r(i+1)^-4)+r(i+1)^-4);
    t(i)=(z(i+1)-z(i))*((r(i)^-4+r(i+1)^-4)/2);
end
simpson=sum(p);
trapezoidal=sum(t);
plot(z,r)
fprintf('Simpson: %.4f\nTrapezoidal: %.4f\nRatio needed: %.4f\n',simpson,trapezoidal,trapezoidal)