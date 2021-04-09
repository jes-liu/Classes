function [t, X] = ODE_solver_AUXIAAnew(t_end,dt,mrna,aux_iaa,arf,aux_iaa_arf,gfp)
%Solves a system of coupled ODEs via MATLAB solver (default: ode45)
%Inputs: t_end, dt, initial mrna,aux_iaa,arf,aux_iaa_arf,gfp
%Outputs: [t, X]

%Allows for a relative error of 1e-6
opts = odeset('RelTol',1.e-6);

%Solve the ODEs over a time period of 0 to 48, using the equations below
%and the initial concentrations of mrna,aux_iaa,arf,aux_iaa_arf,gfp
[t X] = ode15s(@equations,0:dt:t_end,[mrna aux_iaa arf aux_iaa_arf gfp],opts);

end

function dx = equations(t,x)
 
    %redefinition of the constants used in the equations
   global v1 v2 v3 k1 k2 k3 k4 d1 d2 d3 d4 n C
    
    %Create an array to store the concentrations of mrna,aux_iaa,arf,aux_iaa_arf,gfp
    dx = zeros(5,1);
    
    %Differential equations that model the gene circuit
    dx(1) = (v1*k1^n)/(k2^n+(x(4))^n) - d1*x(1); %mRNA
    dx(2) = v2*x(1) - d2*x(2) - k3*x(2)*x(3) + k4*x(4); %Aux/IAA
    dx(3) = v3*C - k3*x(2)*x(3) + k4*x(4) - d3*x(3); %ARF concentration
    dx(4) = k3*x(2)*x(3) - k4*x(4) - d4*x(4); %ARF complex concentration
    dx(5) = (v1*k1^n)/(k2^n+(x(5))^n) - d1*x(1); %Protein HGH-GFP human growth hormone and GFP 
   %ii: equations were changed base on the equations given in the literature
    
end