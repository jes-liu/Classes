%% Jesse Liu 111639610
clear all; close all; clc;

%% pg.297 #3

x = [0, 1, 2, 3, 4, 5, 6];
y = [1, 0, 0, 1, 2, 2, 1];
dx0 = -0.6;
dxn = -1.6;
ddx0 = 1;
ddxn = -1;

S_clamped = csfit_clamped(x, y, dx0, dxn);
S_natural = csfit_natural(x, y, dx0, dxn);
S_extrapolate = csfit_extrapolate(x, y, dx0, dxn);
S_parabolically = csfit_parabolically(x, y, dx0, dxn);
S_adjusted = csfit_curvature(x, y, dx0, dxn, ddx0, ddxn);

hold on
plot(x, y, 'ok')
for i=1:length(x)-1
    X = x(i):.001:x(i+1);
    Y_clamped = polyval(S_clamped(i,:), X-x(i));
    Y_natural = polyval(S_natural(i,:), X-x(i));
    Y_extrapolate = polyval(S_extrapolate(i,:), X-x(i));
    Y_parabolically = polyval(S_parabolically(i,:), X-x(i));
    Y_adjusted = polyval(S_adjusted(i,:), X-x(i));
    plot(X, Y_clamped, 'c-')
    plot(X, Y_natural, 'r-')
    plot(X, Y_extrapolate, 'g-')
    plot(X, Y_parabolically, 'b-')
    plot(X, Y_adjusted, 'm-')
end
legend('points', 'Clamped', 'Natural', 'Extrapolated', 'Parabolically Terminated',... 
'End-Point Curvature-Adjusted', 'location', 'best')
title('pg.297 #3')


%% Program 5.3
function S = csfit_clamped(X, Y, dx0, dxn)

% X is the 1 x n abscissa vector
% Y is the 1 x n ordinate vector
% dx0 = S'(x0) first derivative boundary condition
% dxn = S'(xn) first derivative boundary condition
% S: rows of S are the coefficients, in descending order, for the cubic
% interpolants

N=length(X)-1;
H=diff(X);
D=diff(Y)./H;
A=H(2:N-1);
B=2*(H(1:N-1)+H(2:N));
C=H(2:N);
U=6*diff(D);

B(1)=B(1)-H(1)/2;
U(1)=U(1)-3*(D(1)-dx0);
B(N-1)=B(N-1)-H(N)/2;
U(N-1)=U(N-1)-3*(dxn-D(N));

for k=2:N-1
   temp=A(k-1)/B(k-1);
   B(k)=B(k)-temp*C(k-1);
   U(k)=U(k)-temp*U(k-1);
end

M(N)=U(N-1)/B(N-1);

for k=N-2:-1:1
   M(k+1)=(U(k)-C(k)*M(k+2))/B(k);
end

% endpoint constraints
M(1)=3*(D(1)-dx0)/H(1)-M(2)/2;
M(N+1)=3*(dxn-D(N))/H(N)-M(N)/2;

for k=0:N-1
   S(k+1,1)=(M(k+2)-M(k+1))/(6*H(k+1));
   S(k+1,2)=M(k+1)/2;
   S(k+1,3)=D(k+1)-H(k+1)*(2*M(k+1)+M(k+2))/6;
   S(k+1,4)=Y(k+1);
end
end

function S = csfit_natural(X, Y, dx0, dxn)

N=length(X)-1;
H=diff(X);
D=diff(Y)./H;
A=H(2:N-1);
B=2*(H(1:N-1)+H(2:N));
C=H(2:N);
U=6*diff(D);

B(1)=B(1)-H(1)/2;
U(1)=U(1)-3*(D(1)-dx0);
B(N-1)=B(N-1)-H(N)/2;
U(N-1)=U(N-1)-3*(dxn-D(N));

for k=2:N-1
   temp=A(k-1)/B(k-1);
   B(k)=B(k)-temp*C(k-1);
   U(k)=U(k)-temp*U(k-1);
end

M(N)=U(N-1)/B(N-1);

for k=N-2:-1:1
   M(k+1)=(U(k)-C(k)*M(k+2))/B(k);
end

% endpoint constraints
M(1)=0;
M(N+1)=0;

for k=0:N-1
   S(k+1,1)=(M(k+2)-M(k+1))/(6*H(k+1));
   S(k+1,2)=M(k+1)/2;
   S(k+1,3)=D(k+1)-H(k+1)*(2*M(k+1)+M(k+2))/6;
   S(k+1,4)=Y(k+1);
end
end

function S = csfit_extrapolate(X, Y, dx0, dxn)

N=length(X)-1;
H=diff(X);
D=diff(Y)./H;
A=H(2:N-1);
B=2*(H(1:N-1)+H(2:N));
C=H(2:N);
U=6*diff(D);

B(1)=B(1)-H(1)/2;
U(1)=U(1)-3*(D(1)-dx0);
B(N-1)=B(N-1)-H(N)/2;
U(N-1)=U(N-1)-3*(dxn-D(N));

for k=2:N-1
   temp=A(k-1)/B(k-1);
   B(k)=B(k)-temp*C(k-1);
   U(k)=U(k)-temp*U(k-1);
end

M(N)=U(N-1)/B(N-1);

for k=N-2:-1:1
   M(k+1)=(U(k)-C(k)*M(k+2))/B(k);
end

% endpoint constraints
M(1)=M(2)-H(1)*(M(3)-M(2))/H(2);
M(N+1)=M(N)+(H(N)*(M(N)-M(N-1))/H(N-1));

for k=0:N-1
   S(k+1,1)=(M(k+2)-M(k+1))/(6*H(k+1));
   S(k+1,2)=M(k+1)/2;
   S(k+1,3)=D(k+1)-H(k+1)*(2*M(k+1)+M(k+2))/6;
   S(k+1,4)=Y(k+1);
end
end

function S = csfit_parabolically(X, Y, dx0, dxn)

N=length(X)-1;
H=diff(X);
D=diff(Y)./H;
A=H(2:N-1);
B=2*(H(1:N-1)+H(2:N));
C=H(2:N);
U=6*diff(D);

B(1)=B(1)-H(1)/2;
U(1)=U(1)-3*(D(1)-dx0);
B(N-1)=B(N-1)-H(N)/2;
U(N-1)=U(N-1)-3*(dxn-D(N));

for k=2:N-1
   temp=A(k-1)/B(k-1);
   B(k)=B(k)-temp*C(k-1);
   U(k)=U(k)-temp*U(k-1);
end

M(N)=U(N-1)/B(N-1);

for k=N-2:-1:1
   M(k+1)=(U(k)-C(k)*M(k+2))/B(k);
end

% endpoint constraints
M(1)=M(2);
M(N+1)=M(N);

for k=0:N-1
   S(k+1,1)=(M(k+2)-M(k+1))/(6*H(k+1));
   S(k+1,2)=M(k+1)/2;
   S(k+1,3)=D(k+1)-H(k+1)*(2*M(k+1)+M(k+2))/6;
   S(k+1,4)=Y(k+1);
end
end

function S = csfit_curvature(X, Y, dx0, dxn, ddx0, ddxn)

N=length(X)-1;
H=diff(X);
D=diff(Y)./H;
A=H(2:N-1);
B=2*(H(1:N-1)+H(2:N));
C=H(2:N);
U=6*diff(D);

B(1)=B(1)-H(1)/2;
U(1)=U(1)-3*(D(1)-dx0);
B(N-1)=B(N-1)-H(N)/2;
U(N-1)=U(N-1)-3*(dxn-D(N));

for k=2:N-1
   temp=A(k-1)/B(k-1);
   B(k)=B(k)-temp*C(k-1);
   U(k)=U(k)-temp*U(k-1);
end

M(N)=U(N-1)/B(N-1);

for k=N-2:-1:1
   M(k+1)=(U(k)-C(k)*M(k+2))/B(k);
end

% endpoint constraints
M(1)=ddx0;
M(N+1)=ddxn;

for k=0:N-1
   S(k+1,1)=(M(k+2)-M(k+1))/(6*H(k+1));
   S(k+1,2)=M(k+1)/2;
   S(k+1,3)=D(k+1)-H(k+1)*(2*M(k+1)+M(k+2))/6;
   S(k+1,4)=Y(k+1);
end
end