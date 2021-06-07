%Jesse Liu 111639610
Field = struct('Name','blank','Symbol','blank','Number','blank','Mass','blank');
c1 = struct('Name','Hydrogen','Symbol','H','Number',1,'Mass',1.0079);
c2 = struct('Name','Helium','Symbol','He','Number',2,'Mass',4.0026);
c3 = struct('Name','Lithium','Symbol','Li','Number',3,'Mass',6.941);
c4 = struct('Name','Beryllium','Symbol','Be','Number',4,'Mass',9.0122);
c5 = struct('Name','Boron','Symbol','B','Number',5,'Mass',10.811);
c6 = struct('Name','Carbon','Symbol','C','Number',6,'Mass',12.011);
c7 = struct('Name','Nitrogen','Symbol','N','Number',7,'Mass',14.007);
c8 = struct('Name','Oxygen','Symbol','O','Number',8,'Mass',15.999);
c9 = struct('Name','Fluorine','Symbol','F','Number',9,'Mass',18.998);
c10 = struct('Name','Neon','Symbol','Ne','Number',10,'Mass',20.180);
elementS = [c1,c2,c3,c4,c5,c6,c7,c8,c9,c10];

disp(fieldnames(Field))
for i=1:10
    disp(elementS(i))
end
