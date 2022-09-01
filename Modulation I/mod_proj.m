clc
clear all
[modulating,Fs] = audioread('test.wav');
%sound(modulating,Fs);
[modulatingf,fk,t]=frequency_domain(modulating,Fs);
figure (1)
plot(t,modulating)   %time domain modulatng signal
figure (2)
plot(fk,abs(modulatingf))   %frequency domain modulating signal
Ac=10;%carrier amplitude
ka=0.2;%sensitivity
Fc=3000;%carrier frequency
%signal to noise ratio values
nsnr10=-10;
zsnr=0;
snr15=15;
snr10=10;
%%
%conventional Am
time = (0:1/Fs:((length(modulating)-1)/Fs))';
modulated_conv=Ac*(1+modulating*ka).*cos(2*pi*Fc*time);
[modulated_convf,fk,t]=frequency_domain(modulated_conv,Fs);
figure (3)
plot(t,modulated_conv);%time domain modulated signal
figure (4)
plot(fk,abs(modulated_convf));%frequency domain modulated signal
Nmodulated_conv1=awgn(modulated_conv,nsnr10);
[Nmodulated_conv1f,fk,t]=frequency_domain(Nmodulated_conv1,Fs);
figure(5)
plot(t,Nmodulated_conv1);
figure (6)
plot(fk,abs(Nmodulated_conv1f));
Nmodulated_conv2=awgn(modulated_conv,zsnr);
[Nmodulated_conv2f,fk,t]=frequency_domain(Nmodulated_conv2,Fs);
figure (7)
plot(t,Nmodulated_conv2);
figure (8)
plot(fk,abs(Nmodulated_conv2f));
Nmodulated_conv3=awgn(modulated_conv,snr15);
[Nmodulated_conv3f,fk,t]=frequency_domain(Nmodulated_conv3,Fs);
figure (9)
plot(t,Nmodulated_conv3);
figure (10)
plot(fk,abs(Nmodulated_conv3f));

%extra snr 10
Nmodulated_conv4=awgn(modulated_conv,snr10);
[Nmodulated_conv4f,fk,t]=frequency_domain(Nmodulated_conv4,Fs);
figure (11)
plot(t,Nmodulated_conv4);
figure (12)
plot(fk,abs(Nmodulated_conv4f));

%demodulation
output=(((abs(hilbert(Nmodulated_conv1)))/Ac)-1)/ka;
%sound(output,Fs);
[outputf,fk,t]=frequency_domain(output,Fs);
figure (13)
plot(t,output);
figure(14)
plot(fk,abs(outputf))
output2=(((abs(hilbert(Nmodulated_conv2)))/Ac)-1)/ka;
%sound(output2,Fs);
[output2f,fk,t]=frequency_domain(output2,Fs);
figure (15)
plot(t,output);
figure(16)
plot(fk,abs(output2f))
output3=(((abs(hilbert(Nmodulated_conv3)))/Ac)-1)/ka;
%sound(output3,Fs);
[output3f,fk,t]=frequency_domain(output3,Fs);
figure (17)
plot(t,output);
figure(18)
plot(fk,abs(output3f))

%extra snr 10

output4=(((abs(hilbert(Nmodulated_conv4)))/Ac)-1)/ka;
%sound(output4,Fs);
[output4f,fk,t]=frequency_domain(output4,Fs);
figure (19)
plot(t,output);
figure(20)
plot(fk,abs(output4f))



%%
%DSB
modulated_dsb=(modulating*Ac).*cos(2*pi*Fc*time);
[modulated_dsbf,fk,t]=frequency_domain(modulated_dsb,Fs);
figure (21)
plot(t,modulated_dsb);
figure (22)
plot(fk,abs(modulated_dsbf));
Nmodulated_dsb1=awgn(modulated_dsb,nsnr10);
[Nmodulated_dsb1f,fk,t]=frequency_domain(Nmodulated_dsb1,Fs);
figure (23)
plot(t,Nmodulated_dsb1);
figure (24)
plot(fk,abs(Nmodulated_dsb1f));
Nmodulated_dsb2=awgn(modulated_dsb,zsnr);
[Nmodulated_dsb2f,fk,t]=frequency_domain(Nmodulated_dsb2,Fs);
figure (25)
plot(t,Nmodulated_dsb2);
figure (26)
plot(fk,abs(Nmodulated_dsb2f));
Nmodulated_dsb3=awgn(modulated_dsb,snr15);
[Nmodulated_dsb3f,fk,t]=frequency_domain(Nmodulated_dsb3,Fs);
figure (27)
plot(t,Nmodulated_dsb3);
figure (28)
plot(fk,abs(Nmodulated_dsb3f));
%extra snr 10
Nmodulated_dsb4=awgn(modulated_dsb,snr10);
[Nmodulated_dsb4f,fk,t]=frequency_domain(Nmodulated_dsb4,Fs);
figure (29)
plot(t,Nmodulated_dsb4);
figure (30)
plot(fk,abs(Nmodulated_dsb4f));

%demodulation
Ndmodulated_dsb1=Nmodulated_dsb1.*cos(2*pi*Fc*time);
[b,a] = butter(6,0.75);
output = filter(b,a,Ndmodulated_dsb1);
[outputf,fk,t]=frequency_domain(output,Fs);
%sound(output,Fs)
figure(31)
plot(t,output)
figure (32)
plot (fk,abs(outputf))
Ndmodulated_dsb2=Nmodulated_dsb2.*cos(2*pi*Fc*time);
[b,a] = butter(6,0.75);
output2 = filter(b,a,Ndmodulated_dsb2);
[output2f,fk,t]=frequency_domain(output2,Fs);
%sound(output2,Fs)
figure(33)
plot(t,output2)
figure (34)
plot (fk,abs(output2f))
Ndmodulated_dsb3=Nmodulated_dsb3.*cos(2*pi*Fc*time);
[b,a] = butter(6,0.75);
output3 = filter(b,a,Ndmodulated_dsb3);
[output3f,fk,t]=frequency_domain(output3,Fs);
%sound(output3,Fs)
figure(35)
plot(t,output3)
figure (36)
plot (fk,abs(output3f))
%extra demod snr10

Ndmodulated_dsb4=Nmodulated_dsb4.*cos(2*pi*Fc*time);
[b,a] = butter(6,0.75);
output4 = filter(b,a,Ndmodulated_dsb4);
[output4f,fk,t]=frequency_domain(output4,Fs);
%sound(output4,Fs)
figure(37)
plot(t,output4)
figure (38)
plot (fk,abs(output4f))

%%
%SSB
%USB
modulated_ssb = Ac*modulating .* cos(2 * pi * Fc * time ) - Ac*imag(hilbert(modulating)) .* sin(2 * pi * Fc * time);
[modulated_ssbf,fk,t]=frequency_domain(modulated_ssb,Fs);
figure (39)
plot(t,modulated_ssb);
figure (40)
plot(fk,abs(modulated_ssbf));
Nmodulated_ssb1=awgn(modulated_ssb,nsnr10);
[Nmodulated_ssb1f,fk,t]=frequency_domain(Nmodulated_ssb1,Fs);
figure (41)
plot(t,Nmodulated_ssb1);
figure (42)
plot(fk,abs(Nmodulated_ssb1f));
Nmodulated_ssb2=awgn(modulated_ssb,zsnr);
[Nmodulated_ssb2f,fk,t]=frequency_domain(Nmodulated_ssb2,Fs);
figure (43)
plot(t,Nmodulated_ssb2);
figure (44)
plot(fk,abs(Nmodulated_ssb2f));
Nmodulated_ssb3=awgn(modulated_ssb,snr15);
[Nmodulated_ssb3f,fk,t]=frequency_domain(Nmodulated_ssb3,Fs);
figure (45)
plot(t,Nmodulated_ssb3);
figure (46)
plot(fk,abs(Nmodulated_ssb3f));

% extra snr10
Nmodulated_ssb4=awgn(modulated_ssb,snr10);
[Nmodulated_ssb4f,fk,t]=frequency_domain(Nmodulated_ssb4,Fs);
figure (47)
plot(t,Nmodulated_ssb4);
figure (48)
plot(fk,abs(Nmodulated_ssb4f));


%demodulation
Ndmodulated_ssb1=Nmodulated_ssb1.*cos(2*pi*Fc*time);
[b,a] = butter(6,0.75);
output = filter(b,a,Ndmodulated_ssb1);
[outputf,fk,t]=frequency_domain(output,Fs);
%sound(output,Fs)
figure(49)
plot(t,output)
figure (50)
plot (fk,abs(outputf))
Ndmodulated_ssb2=Nmodulated_ssb2.*cos(2*pi*Fc*time);
[b,a] = butter(6,0.75);
output2 = filter(b,a,Ndmodulated_ssb2);
[output2f,fk,t]=frequency_domain(output2,Fs);
%sound(output2,Fs)
figure(51)
plot(t,output2)
figure (52)
plot (fk,abs(output2f))
Ndmodulated_ssb3=Nmodulated_ssb3.*cos(2*pi*Fc*time);
[b,a] = butter(6,0.75);
output3 = filter(b,a,Ndmodulated_ssb3);
[output3f,fk,t]=frequency_domain(output3,Fs);
sound(output3,Fs)
figure(53)
plot(t,output3)
figure (54)
plot (fk,abs(output3f))

%extra snr10

Ndmodulated_ssb4=Nmodulated_ssb4.*cos(2*pi*Fc*time);
[b,a] = butter(6,0.75);
output4 = filter(b,a,Ndmodulated_ssb4);
[output4f,fk,t]=frequency_domain(output4,Fs);
%sound(output4,Fs)
figure(55)
plot(t,output4)
figure (55)
plot (fk,abs(output4f))








