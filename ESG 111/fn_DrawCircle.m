% Jesse Liu 111639610
function fn_DrawCircle(C0,R,n,colors)

theta=linspace(0,2*pi,n);

for i=1:n
    x(i) = R.*cos(theta(i)) + C0(1);
    y(i) = R.*sin(theta(i)) + C0(2);
end
line(x,y,'color',colors)
end
