close all;clear all;clc;
K_in = [120];
K_out = [60 90 120 150 180];
K = K_in./K_out;

T = 37;  % degrees Celcius
R = 8.314; 
F = 96485.3321;
z = +1;  % potassium

N = ((R*T)/(z*F))*log10(K);

hold on
loglog(K, N, 'o-')
xlabel('K\_in/K\_out')
ylabel('Nernst potential')

p = polyfit(K,N,1);
equation=sprintf('%.4flog(x) + %.4f',p(1),p(2));
text(1.2,0,equation,'FontSize',14)