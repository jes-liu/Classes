function [fx] = fn_exam(x)

if x==-2 | x==0
    fprintf('0\n')
else
    fx=1./(x.^2 + 2.*x)
end