%Jesse Liu 111639610
clear all;clc

T=input('What is the air temperature(in Fahrenheit)? ');
V=input('What is the wind speed(in mph)? ');

while (T>50 | V<3) | (T>50 & V<3)
    fprintf('Air temperature or wind speed did not meet the threshold\n')
    T=input('What is the air temperature(in Fahrenheit)? ');
    V=input('What is the wind speed(in mph)? ');
end

wind_chill_factor=35.7+.6.*T-35.7.*V.^.16+.43.*T.*V.^.16;
fprintf('The wind chill factor is %.0fF*mph\n',wind_chill_factor)

if wind_chill_factor>-20
    fprintf('NO frostbite warning\n')
elseif wind_chill_factor>-35
    fprintf('Skin can freeze in 30 minutes\n')
elseif wind_chill_factor>-50
    fprintf('Skin can freeze in 10 minutes\n')
else
    fprintf('Skin can freeze in 5 minutes\n')
end


