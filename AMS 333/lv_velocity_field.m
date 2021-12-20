function lv_velocity_field_solution
clf
close all
alpha = 1;
beta = 2/3;
gamma =1;
epsilon =3/4;
 
xMin = 0;
xMax = 2;
yMin = 0;
yMax = 3;
gWidth = 0.09;

range_U = xMin:gWidth:xMax;
range_V = yMin:gWidth:yMax;

[UU,VV]=meshgrid(range_U, range_V);

%% Use the meshgrid function to generate two matrices (UU and VV) of U and V values
vel_U = alpha.*UU - gamma.*UU.*VV;
vel_V = -beta.*VV + epsilon.*gamma.*UU.*VV;

quiver(UU,VV,vel_U,vel_V)
axis([xMin xMax yMin yMax])
end
