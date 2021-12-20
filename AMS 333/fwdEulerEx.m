function fwdEulerEx
% Numerically solve dx/dt = -2x with x(0)=1 to find x(3)
% Use Forward Euler method with step size 0.1

deltaTau = 0.1;
maxT = 3;
gamma = 2;

X = 1;
t = 0;
disp([t X]);
while t<maxT
    t = t+deltaTau;
    X = X-gamma*X*deltaTau
    disp([t X]);
end

