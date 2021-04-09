%% Jesse Liu 111639610
clear all; close all; clc;

%% pg.237
% Approximate the function y=1/(1+12x^2) with equally spaced P_10(x) and
% with V_10(x) between [-1 1], and compare error controls. Fig 4.17

x = linspace(-1, 1, 10+1);
y = 1./(1+12.*x.^2);

[C, X, Y] = cheby('1./(1+12.*x.^2)', length(x)-1);
[P_coef, P] = lagrange(x, y);
[V_coef, V] = lagrange(X, Y);

interval = -1:.001:1;
Py = polyval(P_coef, interval);
Vy = polyval(V_coef, interval);

figure()
hold on
plot(interval, Py)
plot(interval, Vy)
title('P(x) vs V(x)')
legend('P10(x)', 'V10(x)', 'location', 'best')

P_x = poly2sym(P_coef);
V_x = poly2sym(V_coef);

% Error
syms z
f = 1./(1+12.*z.^2);
P_Error = abs(double(subs(f, interval)) - double(subs(P_x, interval)));
V_Error = abs(double(subs(f, interval)) - double(subs(V_x, interval)));

figure()
hold on
plot(interval, P_Error)
plot(interval, V_Error)
title('P(x) Error vs V(x) Error')
legend('P(x) Error', 'V(x) Error', 'location', 'best')

fprintf('Max P(x) error is %s. Max V(x) error is %s\n', max(P_Error), max(V_Error))


%% Program 4.1
function [C, L] = lagrange(x, y)

% X is a vector that contains a list of abscissas
% Y is a vector that contains a list of ordinates
% C is a matrix that contains the coefficients of the Lagrange
% interpolatory polynomial
% L is a matrix that contains the coefficients of the Lagrange coefficient
% polynomials

n = length(x);
L = zeros(n, n);

% Form the lagrange coefficient polynomials
for k=1:n
    V = 1;
    for j=1:n
        if k~=j
            V = conv(V, poly(x(j)))/(x(k)-x(j));
        end
    end
    L(k,:) = V;
end

C = y*L;
end

%% Program 4.3
function [C, X, Y] = cheby(fun, n, a, b)

% fun is the string function to be approximated
% N is the degree of the Chebyshev interpolating polynomial
% a is the left end point
% b is the right end point
% C is the coefficient list for the polynomial
% X contains the abscissas
% Y contains the ordinates

if nargin==2
    a=-1;
    b=1;
end

d = pi/(2*n+2);
C = zeros(1, n+1);

for k=1:n+1
    X(k) = cos((2*k-1)*d);
end

X = (b-a)*X/2 + (a+b)/2;
x = X;
Y = eval(fun);

for k=1:n+1
    z = (2*k-1)/d;
    for j=1:n+1
        C(j) = C(j) + Y(k)*cos((j-1)*z);
    end
end

C = 2*C/(n+1);
C(1) = C(1)/2;
end