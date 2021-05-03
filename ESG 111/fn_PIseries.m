function p=fn_PIseries(N)

for k=1:N+1
    p(k)=((factorial(4.*(k-1))).*(1103+26390.*(k-1)))/(((factorial(k-1)).^4).*(396.^(4.*(k-1))));
end

p=((2*sqrt(2))/9801)*sum(p);
end