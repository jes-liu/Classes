%Jesse Liu 111639610

function [hypotenuse,cosine_rule]=ams333_hw1_4(side1,side2,angle)

hypotenuse = sqrt(side1^2 + side2^2)
cosine_rule = sqrt(side1^2 + side2^2 - 2*side1*side2*cos(angle))
end