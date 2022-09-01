%
%basic data
b=10^5+2;
data = randi([0 1],b,1)';
encoded = repmat(data,3,1);
encoded=encoded(:)';
temp=zeros(1,b);
a=length(encoded);
snr=0:1:30; %SNR DB
snrratio=10.^(snr./10);
%%
%coherent BPSK using channel coding
% generation s(t) of the BPSK with channel coding 0=-1 and 1=1
s1=encoded.*2-1;
s1without=data.*2-1;
% calculating the power of s(t)
ps1=sum(s1.*s1)/a;    %ps is the signal power
ps1without=sum(s1without.*s1without)/b;
pn=(ps1)./(10.^(snr./10));    %snr=10log(ps/pn)
pe1=qfunc(sqrt(2.*snrratio));  %theoritical probabilty of error values array
BER=zeros(1,length(snr));
BERwithout=zeros(1,length(snr));

for i=1:length(snr)
    noise=sqrt(pn(i))*(randn(1,a));
    c1=s1+noise;
    % demodulation
    c1=c1>0;
    l=1;
    for k=1:3:length(c1)
        if sum(c1(k:k+2))>=2
            temp(l)=1;
        else
            temp(l)=0;
        end
        l=l+1;
    end
    BER(i)=sum(temp~=data)/b;
end
for i=1:length(snr)
    noise=sqrt(pn(i))*(randn(1,b));
    c11=s1without+noise;
    % demodulation
    c11=c11>0;
    BERwithout(i)=sum(c11~=data)/b;
end
figure(1)
plot(snr,BER,snr,BERwithout,snr,pe1),legend('with channel coding', 'without channel coding','theortical');
title ('SNR Vs Probabolity of Error of BPSK ');
xlabel ('SNR (dB)');
ylabel ('Probability of Error');

%%
%coherent OOK
s2=encoded;   % modulated bits
s2without=data;
% calculating the power of s(t)
ps2=sum(s2.*s2)/a;    %ps is the signal power
ps2without=sum(s2without.*s2without)/b;
pn2=(ps2)./(10.^(snr./10));    %snr=10log(ps/pn)
pe2=qfunc(sqrt(snrratio./2));  %theoritical probabilty of error values array
BER=zeros(1,length(snr));
BERwithout=zeros(1,length(snr));
rec1without=zeros(1,b);
for i=1:length(snr)
    noise2=(sqrt(pn2(i))*(randn(1,a)));
    c2=s2+noise2;
    % demodulation
    c2=(c2>0.5);
    %decoding the bit
    l=1;
    for k=1:3:length(c2)
        if sum(c2(k:k+2))>=2
            temp(l)=1;
        else
            temp(l)=0;
        end
        l=l+1;
    end;
    BER(i)=sum(temp~=data)/b;
end
for i=1:length(snr)
    noise2=(sqrt(pn2(i)).*(randn(1,b)));
    c2=s2without+noise2;
    % demodulation
    c2=c2>0.5;
    BERwithout(i)=sum(c2~=data)/b;
end
figure(2)
plot(snr,BER,snr,BERwithout,snr,pe2),legend('with channel coding', 'without channel coding','theortical');
title ('SNR Vs  Probabolity of Error of OOK ');
xlabel ('SNR (dB)');
ylabel ('Probability of Error');
%%
% 8-psk assuming E=1
symbols=[1 sqrt(1/2)+1i*sqrt(1/2) 1i*1 -sqrt(1/2)+1i*sqrt(1/2) -1 -sqrt(1/2)-1i*sqrt(1/2)  -1*1i  sqrt(1/2)-1i*sqrt(1/2)];
s3=zeros(1,a/3);
s3without=zeros(1,b/3);
%mapping the bits to the symbols
j=1;
for i=1:3:b
    s3without(j)=symbols(binaryVectorToDecimal(data(i:i+2))+1);
    j=j+1;
end
j=1;
for i=1:3:a
    s3(j)=symbols(binaryVectorToDecimal(encoded(i:i+2))+1);
    j=j+1;
end
ps3=sum(abs(s3.*s3))/a;    %ps is the signal power
ps3without=sum(abs(s3without.*s3without))/b;
pn3=(ps3)./(10.^(snr./10));    %snr=10log(ps/pn)
pe3=(2).*qfunc(sqrt(2.*snrratio)*sin(pi/8));  %theoritical probabilty of error values array
BER3=zeros(1,length(snr));
BER3without=zeros(1,length(snr));
rec3=zeros(1,length(s3));
for i=1:length(snr)
    noise=sqrt(pn3(i))*(randn(1,a/3))+1i*sqrt(pn3(i))*(randn(1,a/3));
    c1=s3+noise;
    % demodulation
    x=angle(c1);
    x(x<0)=x(x<0)+2*pi;
    rec3=zeros(1,length(s3));
    rec3(x>=15*pi/8 & x<=pi/8)=0;
    rec3( x>pi/8 & x<=3*pi/8)=1;
    rec3( x>3*pi/8 & x<=5*pi/8)=2;
    rec3(x>5*pi/8 & x<=7*pi/8)=3;
    rec3(x>7*pi/8 & x<9*pi/8)=4;
    rec3( x>9*pi/8 & x<=11*pi/8)=5;
    rec3( x>11*pi/8 & x<=13*pi/8)=6;
    rec3( x>13*pi/8 & x<=15*pi/8)=7;
    
    y= decimalToBinaryVector(rec3,3);
    rec3=reshape(y.',1,numel(y));
    %decoding the bit
    l=1;
    for k=1:3:length(rec3)
        if sum(rec3(k:k+2))>=2
            temp(l)=1;
        else
            temp(l)=0;
        end
        l=l+1;
    end
error=0;
for t=1:3:length(temp)
    if temp(t)~=data(t) ||temp(t+1)~=data(t+1)|| temp(t+2)~=data(t+2)
        error=error+1;
    end
end
BER3(i)=error/length(s3);
end

for i=1:length(snr)
    noise=sqrt(pn3(i))*(randn(1,b/3))+1i*sqrt(pn3(i))*(randn(1,b/3));
    c1=s3without+noise;
    % demodulation
    x=angle(c1);
    x(x<0)=x(x<0)+2*pi;
    rec3=zeros(1,length(s3without));
    rec3(x>=15*pi/8 & x<=pi/8)=0;
    rec3( x>pi/8 & x<=3*pi/8)=1;
    rec3( x>3*pi/8 & x<=5*pi/8)=2;
    rec3(x>5*pi/8 & x<=7*pi/8)=3;
    rec3(x>7*pi/8 & x<9*pi/8)=4;
    rec3( x>9*pi/8 & x<=11*pi/8)=5;
    rec3( x>11*pi/8 & x<=13*pi/8)=6;
    rec3( x>13*pi/8 & x<=15*pi/8)=7;
    
    y= decimalToBinaryVector(rec3,3);
    rec3=reshape(y.',1,numel(y));
    error=0;
for t=1:3:length(rec3)
    if rec3(t)~=data(t) ||rec3(t+1)~=data(t+1)|| rec3(t+2)~=data(t+2)
        error=error+1;
    end
end
BER3without(i)=error/length(s3without);
    
end
figure(3)
plot(snr,BER3,snr,BER3without,snr,pe3),legend('with channel coding', 'without channel coding','theortical');
title ('SNR Vs  Probabolity of Error of 8-psk');
xlabel ('SNR (dB)');
ylabel ('Probability of Error');
figure(4)
plot(snr,pe1,snr,pe2),legend('BPSK', 'OOK');
title ('SNR Vs  Probabolity of Error');
xlabel ('SNR (dB)');
ylabel ('Probability of Error');
