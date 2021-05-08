%Jesse Liu 111639610
function [wind_chill_factor]=fn_WCF(T,V)

wind_chill_factor=35.7+.6.*T-35.7.*V.^.16+.43.*T.*V.^.16
end