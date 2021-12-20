%Jesse Liu 111639610

function [x1pts,x2pts] = unif_over_rect(a1,b1,a2,b2,n)


for n=(1:2000);
    x1pts(n)=rand(1);
    x2pts(n)=rand(1);
    n=n+1;
end

end