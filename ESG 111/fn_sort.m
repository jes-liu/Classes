% Jesse Liu 111639610
function output=fn_sort(data)

data=input('Enter data you would like sorted: ');

sortorder=input('What sorting order would you like?(Enter 1 for ascending or 2 for descending): ');

if sortorder==1
    for i=1:size(data,1)
        for k=1:size(data,2)
            for j=1:size(data,2)-1
                if data(i,j+1)<data(i,j)
                    sub=data(i,j+1);
                    data(i,j+1)=data(i,j);
                    data(i,j)=sub;
                end
            end
        end
    end
elseif sortorder==2
    for i=1:size(data,1)
        for k=1:size(data,2)
            for j=1:size(data,2)-1
                if data(i,j+1)>data(i,j)
                    sub=data(i,j+1);
                    data(i,j+1)=data(i,j);
                    data(i,j)=sub;
                end
            end
        end
    end
end
output=data;
end
        