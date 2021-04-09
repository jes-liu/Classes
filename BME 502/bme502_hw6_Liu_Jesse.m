%% Jesse Liu 111639610
clear all; close all; clc;

%% pg.262 #4a

k = 1:50;
x = .1*k;
y = x + cos(sqrt(k));
[A, B] = lsline(x, y);
new_y = A*x + B;

hold on
plot(x, y)
plot(x, new_y)
title('pg.262 #4a')
legend('function', 'ls line', 'location', 'best')
fprintf('pg.262 #4a\nThe least squares line is y = %.4fx + %.4f\n', A, B)

%% pg.278 #1a

u = fminsearch(@E, [1 1 1 1]);

A = u(1);
B = u(2);
C = u(3);
D = u(4);

fprintf(['\npg.278 #1a\nThe least-squares curve of the form is\n', ...
    'f(x) = %.4fcos(%.4fx) + %.4fsin(%.4fx)\n'], A, B, C, D)

function z = E(u)

A = u(1);
B = u(2);
C = u(3);
D = u(4);

temp = [66, 66, 65, 64, 63, 63, 62, 61, 60, 60, 59, 58, 58, 58, ...
    58, 58, 57, 57, 57, 58, 60, 64, 67, 68];
time = 1:24;

f = A*cos(B.*time) + C*sin(D.*time);
z = sum((f-temp).^2);
end

%% Program 5.1
function [A, B] = lsline(X, Y)

% X is the 1 x n absissa vector
% Y is the 1 x n ordinate vector
% A is the coefficient of x in Ax + B
% B is the constant coefficient in Ax + B

xmean = mean(X);
ymean = mean(Y);
sumx2 = (X-xmean)*(X-xmean)';
sumxy = (Y-ymean)*(X-xmean)';
A = sumxy/sumx2;
B = ymean - A*xmean;

end