% Jesse Liu 111639610
close all;clear all;clc;
v = [6 10.00001 19 26 32 38 51 63 76 88 100 109]; % voltages 
n0 = [0.318457082]; % smallest n0 value from the smallest g0 value

gk_max = 24.30728; % max gk value obtained using gk_inf = gk_max * n_inf^4

for i=1:length(v)
    [t, n] = ode15s(@gk_graph,[0 12],n0,[],v(i));  % ode equation
    gk = gk_max.*n.^4; % changing n from dn/dt to conductance
    hold on
    plot(t,gk,'-*')  % plotting each gk curve
end

xlabel('Time (msec)')
ylabel('g_K (mS/cm^2)')
legend('6 mV','10 mV','19 mV','26 mV','32 mV','38 mV','51 mV','63 mV','76 mV','88 mV','100 mV','109 mV','Location','NorthEastOutside') 


function f = gk_graph(t,n,v)

alpha = (.01*(10-v))/(exp((10-v)/10)-1);  % alpha equation
beta = .125*exp(-v/80);  % beta equation
f = alpha*(1-n) - beta*n;  % dn/dt equation
f=f';  % used to change output into column vectors

end