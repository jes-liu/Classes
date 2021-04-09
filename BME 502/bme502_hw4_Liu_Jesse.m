%% Jesse Liu 111639610
clear all; close all; clc;

%% pg.206 #2ii(a)

x = [0 .2 .4 .6 .8 1];
y = exp(x);

syms v0 v1 v2 v3 v4 v5
for i=1:length(x)
    eqn(i) = v0 + v1*x(i) + v2*x(i)^2 + v3*x(i)^3 + v4*x(i)^4 + v5*x(i)^5 == y(i);
end

[M, N] = equationsToMatrix(eqn, [v0 v1 v2 v3 v4 v5]);
A = linsolve(M, N);
A = double(A);

N = 5+1;

fprintf('pg.206 #2ii(a)\n')

for X=.3:.1:.5
    clear B
    B(N) = A(N);
    
    for K=N-1:-1:1
        B(K) = A(K) + B(K+1)*X;
    end
    %B
    
    f = exp(X);
    fprintf('The value of P(%.1f) = %.6f\n', X, B(1))
    fprintf('The value of f(%.1f) = %.6f\n', X, f)

end

fprintf('Both values are extremely close\n')


%% pg.220 #1

x = [0 .2 .4 .6 .8 1];
ya = exp(x);
yb = sin(x);
yc = (x+1).^(x+1);

[a_coef, ~] = lagrange(x, ya);
[b_coef, ~] = lagrange(x, yb);
[c_coef, ~] = lagrange(x, yc);

interval = 0:.001:1;
polyA = polyval(a_coef, interval);
A = poly2sym(a_coef);
polyB = polyval(b_coef, interval);
B = poly2sym(b_coef);
polyC = polyval(c_coef, interval);
C = poly2sym(c_coef);

hold on
plot(interval, polyA)
plot(interval, polyB)
plot(interval, polyC)
legend('0.0139x^5 + 0.0349x^4 + 0.1704x^3 + 0.499x^2 + x + 1', ...
    '0.0073x^5 + 0.0016x^4 - 0.1676x^3 + 0.0002x^2 + x', ...
    '0.3945x^5 - 0.0717x^4 + 0.7304x^3 + 0.9415x^2 + 1.0052x + 1', ...
    'location', 'best')
title('pg.220 #1')

%% pg.220 #2a

time = 1:6;
temp = [66 66 65 64 63 63];

[LA, ~] = lagrange(time, temp);
polyLA = polyval(LA, time);
polyLA = poly2sym(polyLA);

fprintf('\npg.220 #2a\nThe Lagrange interpolatory polynomial is %s\n', polyLA)

%% pg.220 #2b

clear N I X
N = 5;
C = LA(6);
X = 1;

I(N+1) = LA(N)/(N+1);
for K=N:-1:2
    I(K) = LA(K-1)/K + I(K+1)*X;
end
I(1) = C + I(2)*X;

fprintf('\npg.220 #2b\nThe value of I(x) is %.2f\n', I(1))

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