function out=zigzag_ahmed(in)
%scanning order of a zigzag matrix

z=  [1   2   6   7  15  16  28  29
     3   5   8  14  17  27  30  43
     4   9  13  18  26  31  42  44
    10  12  19  25  32  41  45  54
    11  20  24  33  40  46  53  55
    21  23  34  39  47  52  56  61
    22  35  38  48  51  57  60  62
    36  37  49  50  58  59  63  64];
x=zeros(1,64);
for i=1:8
    for  l=1:8
        x(z(i,l))=in(i,l);
    end
end
out=0;%first value is Dc

%counting process
for i=2:length(x)
    %something has to be done in here
end
end