% Jesse Liu 111639610

%%%% the equations below are just for easy copy+paste
% fn_fnPlot(@(x)exp(4.*x).*sin(1./x),.01,.2,500)
% fn_fnPlot(@(x)humps(x),0,2,200)
function fn_fnPlot(f,a,b,n)

x=linspace(a,b,n);
y=f(x);
diff=range(y);
fprintf('The difference is %.2f\n',diff)

fplot(@(x)f(x),[a b])
end

