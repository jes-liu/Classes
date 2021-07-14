% Jesse Liu 111639610

% variables: change when needed
length_constant = 1;
resistivity = 1:11;
diameter = 1;
z = 1;
current = 1;

% equation
voltage = current.*((length_constant.*resistivity)./(pi.*(diameter./2).^2).*pi).*(exp(-z./length_constant))