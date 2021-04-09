%% Jesse Liu 111639610
clear all; close all; clc;

%% #1 
syms x
fx = sin(x);
pa_0 = taylor(sin(x), x, 'ExpansionPoint', 0, 'Order',11);
pa_2pi = taylor(sin(x), x, 'ExpansionPoint', 2*pi, 'Order',11);

x = 0:.001:2*pi;
fx = subs(fx, x);
pa_0 = subs(pa_0, x);
pa_2pi = subs(pa_2pi, x);

figure
hold on
plot(x, fx)
plot(x, pa_0)
title('Problem 1: x_0=0')
xlabel('x')
ylabel('y')
legend('f(x)', 'P_a(x)', 'location', 'best')
hold off

figure
hold on
plot(x, fx)
plot(x, pa_2pi)
title('Problem 1: x_0=2*pi')
xlabel('x')
ylabel('y')
legend('f(x)', 'P_a(x)', 'location', 'best')
hold off

%% #2
clear all;

x = -1:.001:2;
fx = x.^2 - 3.*x + 1;

y = 0:.001:2*pi;
gx = cos(y).^2 - sin(y);

figure
plot(x, fx)
title('Problem 2: f(x)')
xlabel('x')
ylabel('y')

figure
plot(y, gx)
title('Problem 2: g(x)')
xlabel('x')
ylabel('y')

[fx_ymax, fxmax_index] = max(fx);
[fx_ymin, fxmin_index] = min(fx);
fx_xmax = x(fxmax_index);
fx_xmin = x(fxmin_index);

[gx_ymax, gxmax_index] = max(gx);
[gx_ymax2, gxmax_index2] = max(gx(gxmax_index+1:end));
[gx_ymin, gxmin_index] = min(gx);
gx_xmax = y(gxmax_index);
gx_xmax2 = y(gxmax_index + gxmax_index2);
gx_xmin = y(gxmin_index);

fprintf('f(x): Max occurs at (%.2f, %.3f)\n', fx_xmax, fx_ymax)
fprintf('f(x): Min occurs at (%.2f, %.3f)\n', fx_xmin, fx_ymin)
fprintf('g(x): Max occurs at (%.2f, %.3f) and (%.2f, %.3f)\n', gx_xmax, gx_ymax, gx_xmax2, gx_ymax2)
fprintf('g(x): Min occurs at (%.2f, %.3f)\n', gx_xmin, gx_ymin)