clc; clear all; close all;

tic

%parameters
global v1 v2 v3 k1 k2 k3 k4 d1 d2 n l C
v1 = 4; v2 = 0.01; v3= 0.04; k1 = 4; k2 = 1; k3 = 1; k4 = 10; 
d1 = 0.23; d2=0.003; n = 4; l=0.003225;     
t_end = 200; dt = 1;   
C_start=0; C_incr=0.1; C_end=6;     
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

%plot figures
hold on
plot(C_data,aux_aii_data/max(aux_aii_data),'r-','LineWidth',2) 
plot(C_data,arf_data/max(arf_data),'b-','LineWidth',2) 
plot(C_data,gfp_data/max(gfp_data),'k-','LineWidth',2) 
hold off
xlabel('ARF Concentration'); ylabel('Normalized concentration');
legend('Aux/IAA', 'ARF', 'HGF GFP Protein','Location','northwest')
title('NF Gene Circuit')
 
 toc