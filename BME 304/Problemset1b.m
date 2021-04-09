clc; clear all; close all;

tic

%these are the parameters found in the literature. The v represents the
%rate of the formation of each protein, denoted by the numbers. k1 and k2
%represents coefficients for the protein and the complex, respectively
%while k3 and k4 are rate constants for the formation and disassociation of
%the complex, respectively. d represents degredation of each protein
%denoted by the number and n is the hill coefficient.
global v1 v2 v3 k1 k2 k3 k4 d1 d2 d3 d4 n l C
v1 = 4; v2 = 0.01; v3 = 0.04; k1 = 4; k2 = 1; k3 = 1; k4 = 10; 
d1 = 0.23; d2 = 0.003; d3 = 0.003; d4 = 0.003; n = 4; 
%i: variable were changed to fit the literature

%t is the time it take for the complex to reach the cusp of its graph, in
%minutes
t_end = 200; dt = 1;   
%iv: time scales were adjusted to match the circuit
C_start=0; C_incr=0.1; C_end=6; 
%iii: concentration were adjusted to match the circuit
C_data=C_start:C_incr:C_end;
C_cnt=0;

for C=C_start:C_incr:C_end
   
    C_cnt=C_cnt+1;
    
    %initial numbers for each chemical species
    aux_iaa = 0; arf = 0; gfp = 0; aux_iaa_arf = 0; mrna = 0;
    
    %call to ODEsolver 
    [t, X] = ODE_solver_AUXIAAnew(t_end,dt,mrna,aux_iaa,arf,aux_iaa_arf,gfp);
    
    %save steady-state (48 hrs) data for each ARF concentration
    aux_aii_data(C_cnt)=X(end,2);
    arf_data(C_cnt)=X(end,3);
    gfp_data(C_cnt)=X(end,5);
    
    
end

%save data
save('ODE_solver_AUXIAA_data.mat','C_data','aux_aii_data','arf_data','gfp_data');

%plot figures: hold on will plot every graph previously created onto the
%same graph. xlabel and ylabel labels the axis, legend gives information
%about which line represents which plot, and title gives the title.
hold on
plot(C_data,aux_aii_data./max(aux_aii_data),'r-','LineWidth',2) 
plot(C_data,arf_data./max(arf_data),'b-','LineWidth',2) 
plot(C_data,gfp_data/max(gfp_data),'k-','LineWidth',2)  
%v: new variables were plotted to match the equations from the literature
hold off
xlabel('ARF Concentration'); ylabel('Normalized concentration');
legend('Aux/IAA', 'ARF', 'HGF GFP Protein','Location','northwest')
title('NF Gene Circuit')
 
 toc 