imagename='kiel.pgm';
image=imread(imagename);
original=image;
imagesize=8*numel(image);
% segmentation
image=double(reshape(image,8,8,4096));
%% encoding
% Bits Decrementing
image=image-128;
% Dct
A=dctmtx(8);
for i=1:4096
    transformed(:,:,i)=A*image(:,:,i)*A';
end
% Quantization
Q =([
    16 11 10 16  24  40  51  61
    12 12 14 19  26  58  60  55
    14 13 16 24  40  57  69  56
    14 17 22 29  51  87  80  62
    18 22 37 56  68 109 103  77
    24 35 55 64  81 104 113  92
    49 64 78 87 103 121 120 101
    72 92 95 98 112 100 103 99]);
transformed=round(transformed./Q);

% Encoder DC
diff=zeros(1,4096);
x=transformed(:,:,1);
diff(1)=transformed(1,1);
for i=2:length(diff)
    x1=transformed(:,:,i);
    x2=transformed(:,:,i-1);
    diff(i)=x1(1,1)-x2(1,1);
end

dcvalue=cell(1,length(diff));
sizedc=0;
for i=1:length(dcvalue)
    x=dc_enc(diff(i));
    sizedc=sizedc+length(x);
    dcvalue(i)={x};
end
%Encoder Ac
Acvector=cell(1,4096);
for i=1:4096
    x=ZigZag(transformed(:,:,i));
    idx=find(x,1,'last');
    Acvector(i)={x(1:idx)};
end
acvalue=cell(1,4096);
sizeac=0;
for i=1:4096
    x=ac_enc(Acvector{i});
    sizeac=sizeac+length(x);
    acvalue(i)={x};
end
CR=imagesize/(sizeac+sizedc);%compression ratio
%% decoding

%Decoder DC
estdiff=zeros(1,length(diff));
for i=1:length(dcvalue)
    estdiff(i)=dc_dec(dcvalue{i});
end
estdcvalue=zeros(1,length(estdiff));
estdcvalue(1)=estdiff(1);
for i=2:length(estdcvalue)
    estdcvalue(i)=estdcvalue(i-1)+estdiff(i);
end
%Decoder AC
estAcvector=cell(1,4096);
for i=1:4096
    estAcvector(i)={ac_dec(acvalue{i})};
    i
end
estacvalue=zeros(4096,63);

for i=1:4096
    x=[];
    vector=estAcvector{i};
    if (~isempty(vector) &&vector(1)==0)
        for l=2:length(vector)
            if (mod(l,2)==0)
                x=[x vector(l)];
            else
                x=[x zeros(1,vector(l))];
            end
        end
    else
        for q=1:length(vector)
            if (mod(q,2)==0)
                x=[x vector(q)];
            else
                x=[x zeros(1,vector(q))];
            end
            
        end
    end
    x=[x zeros(1,63-length(x))];
    estacvalue(i,:)=x;
end
matrices=zeros(4096,64);
matrices(:,1)=estdcvalue;
matrices(:,2:end)=estacvalue;
esttransformed=zeros(8,8,4096);
for i=1:4096
    esttransformed(:,:,i)=izigzag(matrices(i,:));
end
beforeQ=esttransformed.*Q;
for i=1:4096
    estimage(:,:,i)=round(A^-1*beforeQ(:,:,i)*(A')^-1);
end
estimage=estimage+128;
compressedimage=uint8(reshape(estimage,512,512));
peaksnr = psnr(compressedimage,original);
%plotting the two photos
subplot(1,2,1)
imshow(imagename)
title('Original')
subplot(1,2,2)
imshow(compressedimage);
title('Compressed')