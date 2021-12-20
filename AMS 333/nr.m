function nr

tol = 1e-8;
x = pi/4;
i = 0;
disp([ i x f(x) ])

while( abs(f(x)) > tol)
       x=x-(f(x)/df(x));
       i = i + 1;
       disp([ i x f(x) ]);
end

function y = f(x)
	 y = cos(x) - x;

function y = df(x)
	 y = -sin(x) - 1;

