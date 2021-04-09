% Jesse Liu 111639610

Z=dataset('File','Z.txt');
above1log2ratio=Z;

i=10
while i>0
    if Z.Log2Ratio(i)<1
        above1log2ratio(i,:)=[]
    end
    i=i-1
end 
