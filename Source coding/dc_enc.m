function b=dc_enc(x)
if x ==0
    b=[0 0];
    return
else
    c = floor(log2(abs(x)))+1;
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
nobits=[3 3 3 3 3 4 5 6 7 8 9];
b=tbl(c,1:nobits(c));
tmp=fliplr(de2bi(abs(x),c));
if x>0 % if x > 0
    b=[b tmp];
elseif x<0 % if x < 0
    b=[b ones(1,c)-tmp];
end