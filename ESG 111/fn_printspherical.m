%Jesse Liu 111639610
function [radius_r,inclination,azimuth]=fn_printspherical(x,y,z)
[radius_r,inclination,azimuth]=fn_convert2spher(x,y,z)
end

function [radius_r,inclination,azimuth]=fn_convert2spher(x,y,z)
radius_r=sqrt(x.^2+y.^2+z.^2)
inclination=acos(z./radius_r)
azimuth=atan(y./x)
end