%% Jesse Liu 111639610
clear all; close all; clc;

%% # pg.89 8a

change = 1;

x = input('Pick a guess for the x value: ');

while abs(change) >= 10^-10
    y = x^2;
    
    syms distance_squared(z)
    distance_squared(z) = (z-3)^2 + (z^2-1)^2;  % x = z; y = z^2
    
    dds = diff(distance_squared);  % f(x) equation
    dds_1 = diff(dds);  % f'(x) equation
    
    fx = double(subs(dds, x));
    fx1 = double(subs(dds_1, x));
    change = fx/fx1;
    x = x - change;
end

fprintf('The closest point is (%.10f, %.10f)\n', x, y)