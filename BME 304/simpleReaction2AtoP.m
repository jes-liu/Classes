close all;clear all;clc;
delta_t = 0.0001; 
maxT = 1;
k1 = 1;

t = 0:delta_t:maxT;
P = zeros(size(t));
A = zeros(size(t));

P(1) = 0.0;
A(1) = 100;

for i= 1:length(t)-1
    P(i+1)=P(i) + .5.*k1.*((A(i)).^2).*delta_t;
    A(i+1)=A(i) + -k1.*((A(i)).^2).*delta_t;
end

plot(t,A,'-r',t,P,'-g');
legend('A','P')

disp(P(end))