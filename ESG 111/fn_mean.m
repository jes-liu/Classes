function m=fn_mean(v)

for n=2:numel(v)
    v(n) = v(n) + v(n-1)
    m(1)=0
    m(n) = v(n)./length(v)
end

end