
beforeQ=esttransformed.*Q;
for i=1:4096
    estimage(:,:,i)=round(A^-1*beforeQ(:,:,i)*(A')^-1);
end
firstvalue=imread('lena.pgm');
estimage=estimage+128;
test=image+128;
qorig=reshape(test,512,512);
q=reshape(test,512,512);
