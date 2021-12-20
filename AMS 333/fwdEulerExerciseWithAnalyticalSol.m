function fwdEulerExerciseWithAnalyticalSol

deltaTau = 0.2;
maxT = 3;
X_initial = 1;

t = 0:deltaTau:maxT;
X = zeros(size(t));
numIterations = maxT/deltaTau;

X(1) = X_initial;
for i=1:numIterations
	X(i+1) = X(i) + f(X(i))*deltaTau;
end

disp( X(end) )
  
plot(t,X);
xlabel('t');
ylabel('y');
  
hold on;
y = X_initial * exp(-2*t);
plot(t,y,'r');
hold off;


function dx_dt=f(x)
  gamma = 2;
  dx_dt = -gamma * x;
