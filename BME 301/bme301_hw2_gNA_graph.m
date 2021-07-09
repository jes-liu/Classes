% Jesse Liu 111639610
close all;clear all;clc;

m0 = 0;  % proportion of open type 1 na channel at time 0
h0 = .6;  % proportion of open type 2 na channel at time 0
v = [6 10.00001 19 26 32 38 51 63 76 88 100 109]; % voltages

gna_max = 70.7;  % max na value given

voltage = ["6 mV","10 mV","19 mV","26 mV","32 mV","38 mV","51 mV","63 mV","76 mV","88 mV","100 mV","109 mV"];  % title names for each graph

for i=1:length(v)
    [t, mh] = ode15s(@gna_graph,[0 12],[m0 h0],[],v(i));
    gna = gna_max.*(mh(:,(1)).^3).*mh(:,(2));
    hold on
    plot(t,gna,'-*')
end

xlabel('Time (msec)')
ylabel('g_{NA} (mS/cm^2)')
legend(voltage)

function f = gna_graph(t,x,v)

m = x(1); % m = open type 1 na channel
h = x(2); % h = open type 2 na channel

alpha_m = (.1.*(25-v))./(exp((25-v)./10)-1);  % alpha equation for m
beta_m = 4.*exp(-v./18);  % beta equation for m
alpha_h = .07.*exp(-v./20);  % alpha equation for h
beta_h = 1./(exp((30-v)./10)+1);  % beta equation for h
f_m = alpha_m.*(1-m) - beta_m.*m;
f_h = alpha_h.*(1-h) - beta_h.*h;

f = [f_m f_h]';

end