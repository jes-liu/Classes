%Jesse Liu 111639610

file=input('Enter the file name with extension: ','s');
data=load(file); 
x=data(:,1);
y=data(:,2);
z=data(:,3);

[radius_r,inclination,azimuth]=fn_printspherical(x,y,z);

for i=1:10
    fprintf('Cartesian Coorindate:[x,y,z] = [%.2f,%.2f,%.2f]:\n',x(i),y(i),z(i))
    fprintf('The radius is %.2f\n',radius_r(i))
    fprintf('The inclination angle is %.2f\n',inclination(i))
    fprintf('The azimuth angle is %.2f\n',azimuth(i))
    i=i+1;
end
