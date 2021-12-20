a1 = -1;
b1 = 1;
a2 = -1;
b2 = 1;
n = 2000;
counter = 0;

[s1, s2] = p1_8(a1, b1, a2, b2, n);

for i = 1:1:n
    a = s1(i);
    b = s2(i); 
    hypo = sqrt(a^2 + b^2);
    if hypo >= 1
        counter = counter + 1;
    end
end

counter = n - counter;
frac_in_circle = counter/n;
        

        
            
    