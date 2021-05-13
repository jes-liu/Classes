% v=input('Enter a vector: ');

for n=1:50
    v(n)=randi([-100 100],1)
end

m=fn_mean(v)

plot(v,m)