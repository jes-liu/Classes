% Jesse Liu 111639610
close all;clear all;clc;

C0=input('Enter the center of the circle coordinate: ');
R=input('Enter the radius of the circle: ');
n=input('Enter the number of points: ');
colors=input('Enter a color: ','s');

theta=linspace(0,2*pi,n);
c0=C0;

hold on
for j=1:n
    fn_DrawCircle(C0,R,n,colors)
    C0(1) = R*cos(theta(j)) + c0(1);
    C0(2) = R*sin(theta(j)) + c0(2);
end
hold off
