x=linspace(-20,20,200);

for i=1:numel(x)
    if x(i)<-10
        y(i)=fn1(x(i))
    elseif x(i)>=10 && x(i)<=10
        y(i)=fn2(x(i))
    elseif x(i)>10
        y(i)=fn3(x(i))
    else
    end
end

plot(x,y(1:200))