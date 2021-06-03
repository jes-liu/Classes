% Jesse Liu 111639610
% randi([-10 10],5,10)

data=input('Enter data you would like sorted: ');

sorttype=input('Which sorting type would you like?(Enter 1 for row-wise or 2 for column-wise): ');
sortorder=input('What sorting order would you like?(Enter 1 for ascending or 2 for descending): ');

if sorttype==1
    if sortorder==1  % row-wise ascending
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
    elseif sortorder==2 % row-wise descending
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
elseif sorttype==2
    if sortorder==1  % column-wise ascending
        for j=1:size(data,2)
            for k=1:size(data,2)
                for i=1:size(data,1)-1
                    if data(i+1,j)<data(i,j)
                        sub=data(i+1,j);
                        data(i+1,j)=data(i,j);
                        data(i,j)=sub;
                    end
                end
            end
        end
    elseif sortorder==2  %column-wise descending
        for j=1:size(data,2)
            for k=1:size(data,2)
                for i=1:size(data,1)-1
                    if data(i+1,j)>data(i,j)
                        sub=data(i+1,j);
                        data(i+1,j)=data(i,j);
                        data(i,j)=sub;
                    end
                end
            end
        end
    end
end
disp(data)
