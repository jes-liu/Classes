%Jesse Liu 111639610

function [loutput]=ams333_hw1_7(n)

output=[];
tea=1;
    while n>1
        if rem(n,2)==0
            n=n./2;
        else
            n=3.*n+1;
        end
    output(tea)=n;
    tea=tea+1;
end
loutput=length(output);