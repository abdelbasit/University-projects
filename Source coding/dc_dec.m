function diff=dc_dec(b)
if length(b)==2
    %handling the 0 case
    diff=0;
    return
end
tbl=[0 1 0 0 0 0 0 0 0
     0 1 1 0 0 0 0 0 0
     1 0 0 0 0 0 0 0 0
     1 0 1 0 0 0 0 0 0
     1 1 0 0 0 0 0 0 0
     1 1 1 0 0 0 0 0 0
     1 1 1 1 0 0 0 0 0
     1 1 1 1 1 0 0 0 0
     1 1 1 1 1 1 0 0 0
     1 1 1 1 1 1 1 0 0
     1 1 1 1 1 1 1 1 0];
nobits=[3 3 3 3 3 4 5 6 7 8 9];%represents the number of bits for every category
totnobits=[4 5 6 7 8 10 12 14 16 18 20];%represents the number of bits for the encoded bits
cat=find(length(b)==totnobits);%represents the category number
% catb=b(1:nobits(cat));
b(1:nobits(cat))=[];
constant=1;
if(b(1)==0)%negativenumber
b=ones(1,length(b))-b;
constant=-1;
end
diff=bi2de(fliplr(b))*constant;
    
end

