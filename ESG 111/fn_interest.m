%Jesse Liu 111639610
function [Interest,X]=fn_interest(x_0,r,n,k);

X=x_0.*((1+(r./k)).^(k.*n));
Interest=x_0.*((1+(r./k)).^(k.*n))-x_0;
end

