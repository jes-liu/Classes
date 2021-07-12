syms n(t) a b
ode = diff(n,t) == a*(1-n(t))-b*n(t);
nSol(t) = dsolve(ode);
disp(nSol(t))
