%%
%basic informations
clc
clear all
data = randi([0 1],10,1); %data bits
encoded = convenc(signal,poly2trellis([5 4],[23 35 0; 0 5 13])); %encoded bits
energy=1;
duration=0.05;
freq=10e6;
var=5;
noise=var.*randn(15,1);% ask about the noise !!!
%%
%Coherent BPSK modulation
codedsignal(codedsignal==0)=-1;
time = linspace(0,duration,15)';%???
carrier=sqrt(2*energy/duration).*cos(2*pi*freq*time);%???
modulated1=codedsignal.*carrier;


