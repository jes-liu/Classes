function hassel1
 clear all; close all

numIterations = 50;
R0 = 1;
t = 0:numIterations;
N = zeros(size(t)); 
N(1) = 1; 
Nc = 1e6;  %  maximal # of individuals that the environment can successfully support.
a = R0/Nc;
b = 1;

for i=1:numIterations
  N(i+1) = (R0*N(i)) / (1+a*N(i))^b;
end

N(end)

plot(t,N,'-o');
xlabel('t')
ylabel('N')
