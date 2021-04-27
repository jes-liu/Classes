function [roll]=fn_dice

one = randi([1 6],1)
two = randi([1 6],1)
roll = one + two
throw=1;

while throw>=1
    if one==two
        three = randi([1 6],1)
        roll = roll + three
        throw=throw+1;
        for throw=throw+1
            if one==two
                one=randi([1 6],1)
                two=randi([1 6],1)
                roll = roll + one + two
                throw=throw+1;
            end
        end
    elseif one+two==7
        roll = 2*(roll + one + two)
        throw=throw+1;
    elseif one+two==5
        roll = 0
        throw=throw+1;
    end
end

end