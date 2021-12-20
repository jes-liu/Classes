function sis_model

delta_t = 0.001; 
maxT = 100;
beta = 5e-7; gamma = 5e-2;
N = 1e6; 

t = 0:delta_t:maxT;
I = zeros(1,length(t));
I(1) = 10.0/N;

for i=1:length(t)-1
	I(i+1)=I(i)+(beta.*N.*I(i).*(1-(I(i)./N))).*delta_t;
end

S = N-I;
plot(t,S,'-r');
hold on
plot(t,I,'-g');
plot([0 maxT],[gamma/(beta*N)  gamma/(beta*N)],':k');
plot([0 maxT],[1-gamma/(beta*N)  1-gamma/(beta*N)],':k');
hold off;

title('SIS Model (fractional population)');
legend('Suscept','Infect');

end
