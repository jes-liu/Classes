% Jesse Liu 111639610

K=dataset('File','K.txt');
positivelog2ratio=K;
negativelog2ratio=K;

i=10;
while i>0
    if K.Log2Ratio(i)<0
        positivelog2ratio(i,:)=[]
    else 
        K.Log2Ratio(i)>0
        negativelog2ratio(i,:)=[]
    end
    i=i-1
end 