%Jesse Liu 111639610

mph=input('Enter the mph: ');
[knots,kmh]=fn_speedconv(mph);

if knots>=64
    fprintf('Beaufort Wind Scale Force: 12\nWind(knots): %d\n',round(knots))
    fprintf('Wind(km/h): %d\nClassification: Hurricane\n',round(kmh))
elseif knots>=56
    fprintf('Beaufort Wind Scale Force: 11\nWind(knots): %d\n',round(knots))
    fprintf('Wind(km/h): %d\nClassification: Violent Storm\n',round(kmh))
elseif knots>=48
    fprintf('Beaufort Wind Scale Force: 10\nWind(knots): %d\n',round(knots))
    fprintf('Wind(km/h): %d\nClassification: Storm\n',round(kmh))
elseif knots>=41   
    fprintf('Beaufort Wind Scale Force: 9\nWind(knots): %d\n',round(knots))
    fprintf('Wind(km/h): %d\nClassification: Strong Gale\n',round(kmh))
elseif knots>=34
    fprintf('Beaufort Wind Scale Force: 8\nWind(knots): %d\n',round(knots))
    fprintf('Wind(km/h): %d\nClassification: Gale\n',round(kmh))
elseif knots>=28
    fprintf('Beaufort Wind Scale Force: 7\nWind(knots): %d\n',round(knots))
    fprintf('Wind(km/h): %d\nClassification: Near Gale\n',round(kmh))
elseif knots>=22
    fprintf('Beaufort Wind Scale Force: 6\nWind(knots): %d\n',round(knots))
    fprintf('Wind(km/h): %d\nClassification: Strong Breeze\n',round(kmh))
elseif knots>=17
    fprintf('Beaufort Wind Scale Force: 5\nWind(knots): %d\n',round(knots))
    fprintf('Wind(km/h): %d\nClassification: Fresh Breeze\n',round(kmh))
elseif knots>=11
    fprintf('Beaufort Wind Scale Force: 4\nWind(knots): %d\n',round(knots))
    fprintf('Wind(km/h): %d\nClassification: Moderate Breeze\n',round(kmh))
elseif knots>=7
    fprintf('Beaufort Wind Scale Force: 3\nWind(knots): %d\n',round(knots))
    fprintf('Wind(km/h): %d\nClassification: Gently Breeze\n',round(kmh))
elseif knots>=4
    fprintf('Beaufort Wind Scale Force: 2\nWind(knots): %d\n',round(knots))
    fprintf('Wind(km/h): %d\nClassification: Light Breeze\n',round(kmh))
elseif knots>=1
    fprintf('Beaufort Wind Scale Force: 1\nWind(knots): %d\n',round(knots))
    fprintf('Wind(km/h): %d\nClassification: Light Air\n',round(kmh))
else
    fprintf('Beaufort Wind Scale Force: 0\nWind(knots): %d\n',round(knots))
    fprintf('Wind(km/h): %d\nClassification: Calm\n',round(kmh))
end