%Jesse Liu 111639610
clear all;clc;

x=[];
j=1;
for T=-20:5:55
    for V=5:5:55
        wind_chill_factor=35.7+.6.*T-35.7.*V.^.16+.43.*T.*V.^.16;
        x(j,V./5)=wind_chill_factor;
    end
    j=j+1;
end

fprintf('%80s\n','Wind Speed[mph]')
fprintf('%12s %9s %10s %10s %10s %10s %10s %10s %10s %10s %10s %10s\n',...
    'Temp[F]','5mph','10mph','15mph','20mph','25mph','30mph','35mph',...
    '40mph','45mph','50mph','55mph')

for T=-20
    for index=1:16
        fprintf('%11.2f',T,x(index,:))
        fprintf('\n')
        T=T+5;
    end
end