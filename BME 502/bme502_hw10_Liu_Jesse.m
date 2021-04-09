%% Jesse Liu 111639610
clear all; close all; clc;

%% #1

e = .5*10^-9;
x = .5;
f = @(x) sin(x);

[L2, n2] = difflimh2(f, x, e);
[L4, n4] = difflimh4(f, x, e);

fprintf('Question #1\n0(h^2): f''(x) = %.13f\n0(h^4): f''(x) = %.13f\n', L2(n2,2), L4(n4,2))

%% pg.338 #2
function  [L,n]=difflimh4(f,x,toler)

max1=15;
h=1;
H(1)=h;
D(1)=(-feval(f,x+2*h)-8*feval(f,x-h)+8*feval(f,x+h)+feval(f,x-2*h))/(12*h);
E(1)=0;
R(1)=0;

for n=1:2
   h=h/10;
   H(n+1)=h;
   D(n+1)=(-feval(f,x+2*h)-8*feval(f,x-h)+8*feval(f,x+h)+feval(f,x-2*h))/(12*h);
   E(n+1)=abs(D(n+1)-D(n));
   R(n+1)=2*E(n+1)*(abs(D(n+1))+abs(D(n))+eps);
end

n=2;

while((E(n)>E(n+1))&&(R(n)>toler))&&n<max1
   h=h/10;
   H(n+2)=h;
   D(n+2)=(-feval(f,x+2*h)-8*feval(f,x-h)+8*feval(f,x+h)+feval(f,x-2*h))/(12*h);
   E(n+2)=abs(D(n+2)-D(n+1));
   R(n+2)=2*E(n+2)*(abs(D(n+2))+abs(D(n+1))+eps);
   n=n+1;
end

n=length(D)-1;
L=[H' D' E'];
end

function  [L,n]=difflimh2(f,x,toler)
%Input       - f is the function input as a string 'f'
%            - x is the differentiation point
%            - toler is the desired tolerance
%Output - L=[H' D' E']: H is the vector of step sizes
%              D is the vector of approximate derivatives
%              E is the vector of error bounds
%            - n is the coordinate of the "best approimation"

max1=15;
h=1;
H(1)=h;
D(1)=(feval(f,x+h)-feval(f,x-h))/(2*h);
E(1)=0;
R(1)=0;

for n=1:2
   h=h/10;
   H(n+1)=h;
   D(n+1)=(feval(f,x+h)-feval(f,x-h))/(2*h);
   E(n+1)=abs(D(n+1)-D(n));
   R(n+1)=2*E(n+1)*(abs(D(n+1))+abs(D(n))+eps);
end

n=2;

while((E(n)>E(n+1))&&(R(n)>toler))&&n<max1
   h=h/10;
   H(n+2)=h;
   D(n+2)=(feval(f,x+h)-feval(f,x-h))/(2*h);
   E(n+2)=abs(D(n+2)-D(n+1));
   R(n+2)=2*E(n+2)*(abs(D(n+2))+abs(D(n+1))+eps);
   n=n+1;
end

n=length(D)-1;
L=[H' D' E'];
end