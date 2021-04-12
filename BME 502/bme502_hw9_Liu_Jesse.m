%% Jesse Liu 111639610
clear all; close all; clc;

%% pg.377 #6a

M=1;
f = @(x) sin(1/x);
a=1/7*pi;
b=1/4*pi;

s = traprl(f, a, b, M);

fprintf('pg.377 #6a\nComposite Trapezoidal gives %.10f\n', s)

%% pg.392 #2a

a=0;
b=2;
f = @(x) sqrt(4*x - x^2);
tol = 1e-10;
n = 6;

[R,quad,err,h]=romber(f,a,b,n,tol);

fprintf('\npg.392 #2a\nThe Romberg Approximation gives %.10f\nThe error is %.10f\n', quad, err)

%% pg.406 Optional

f = @(t) (t.^2).*exp(-t.^2);
a = 0;
b = 2;
A_2 = [-.5773502692, .5773502692];
W_2 = [1, 1];
A_3 = [.7745966692, -.7745966692, 0];
W_3 = [.5555555556, .5555555556, .8888888888];

quad_2=gauss(f,a,b,A_2,W_2);
quad_3=gauss(f,a,b,A_3,W_3);

fprintf('\npg.406 Optional\nThe Gauss Legendre Quadrature for\nN=2 is %.10f\nN=3 is %.10f\n', quad_2, quad_3)

%% Program 7.1
function s=traprl(f,a,b,M)
%Input      - f is the integrand 
%              - a and b are upper and lower limits of integration
%              - M is the number of subintervals
%Output   - s is the trapezoidal rule sum

h=(b-a)/M;
s=0;
for k=1:(M-1)
   x=a+h*k;
   s=s+feval(x);
end
s=h*(feval(f,a)+feval(f,b))/2+h*s;
end

% Program 7.4
function [R,quad,err,h]=romber(f,a,b,n,tol)
%Input    - f is the integrand 
%            - a and b are upper and lower limits of integration
%            - n is the maximum number of rows in the table
%            - tol is the tolerance
%Output - R is the Romberg table
%           - quad is the quadrature value
%           - err is the error estimate
%           - h is the smallest step size used

M=1;
h=b-a;
err=1;
J=0;
R=zeros(4,4);
R(1,1)=h*(feval(f,a)+feval(f,b))/2;
while((err>tol)&&(J<n))||(J<4)
   J=J+1;
   h=h/2;
   s=0;
   for p=1:M
      x=a+h*(2*p-1);
      s=s+feval(f,x);
   end
   R(J+1,1)=R(J,1)/2+h*s;
   M=2*M;
   for K=1:J
      R(J+1,K+1)=R(J+1,K)+(R(J+1,K)-R(J,K))/(4^K-1);
   end
   err=abs(R(J,J)-R(J+1,K+1));
end
quad=R(J+1,J+1);
end

% Program 7.7
function quad=gauss(f,a,b,A,W)
%Input     - f is the integrand 
%             - a and b upper and lower limits of integration
%             - A is the 1 x N vector of abscissas from Table 7.9
%             - W is the 1 x N vector of weights from Table 7.9
%Output  - quad is the quadrature value

N=length(A);
T=zeros(1,N);
T=((a+b)/2)+((b-a)/2)*A;
quad=((b-a)/2)*sum(W.*feval(f,T));
end