function discrete1

numIterations = 5;
R0 = 1.5;
t = 0:numIterations;
N = zeros(size(t));
N(1) = 100;

for i = 2:6
  N(i)=N(i-1).*R0
end

plot(t,N,'o');
xlabel('t')
ylabel('N')
