X1=dataset('File','X1.txt');
Y1=dataset('File','Y1.txt');

X1Y1=join(X1,Y1)

K1=dataset('File','K1.txt');

exppositive=K1;
expnegative=K1;

i=7;
while i>0
    if K1.EXP(i)<0
        exppositive(i,:)=[]
    else
        K1.EXP(i)>0
        expnegative(i,:)=[]
    end
    i=i-1
end;


expabove50=K1
expbelow50=K1

i=7
while i>0
    if K1.EXP(i)<50
        expabove50(i,:)=[]
    else 
        K1.EXP(i)>50
        expbelow50(i,:)=[]
    end 
    i=i-1
end;
