%%BME 304 Example
%%Tyler Guinn
%%Problem Example for ODE
clear all; close all; clc %%Clear variables, close plot, clear workspace

t = linspace(0,1); %%100 linearly equally spaced time points between 0 & 1.
y0 = 5 %%Initial conditions
[t1,y1]= ode15s(@odefun,t,y0) %%Call ODE function

plot(t1,y1,'-o','LineWidth',3) %%plot (y vs t)
set(gca,'FontSize',30,'LineWidth',3,'fontname','arial') %%Specify plot parameters
xlabel('time') %%Label x axis
ylabel('Y') %%Label y axis

function dydt = odefun(t,y) %%Integration function
k = 5; %%constant
dydt = -k*y; %%eqn
end


% [t,y] = ode15s(odefun,tspan,y0), where tspan = [t0 tf], integrates the 
% system of differential equations y'=f(t,y) from t0 to tf with initial 
% conditions y0. Each row in the solution array y corresponds to a value 
% returned in column vector t. All MATLAB® ODE solvers can solve systems 
% of equations of the form y'=f(t,y), or problems that involve a mass 
% matrix, M(t,y)y'=f(t,y). The solvers all use similar syntaxes. The ode23s 
% solver only can solve problems with a mass matrix if the mass matrix is 
% constant. ode15s and ode23t can solve problems with a mass matrix that 
% is singular, known as differential-algebraic equations (DAEs). Specify 
% the mass matrix using the Mass option of odeset.