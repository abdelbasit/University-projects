clc
clear all
t=0:0.1:15;
xt=sin(0.2*pi*t);
xsample=xt(1:2:end);
[x_quantized,delta]=helper_quantize( xsample,16 );
err=(xsample-x_quantized);
var2=var(err);
sqnr2=(delta^2*2^2/4)/var2;
levels=unique(x_quantized)
levels_code=0:1:length(levels)-1;
for i=1:length(x_quantized)
    for k=1:length(levels)
        if (x_quantized(i)==levels(k))
            x_quantized(i)=levels_code(k);
        end
    end
end
probabilties=zeros(1,16);
for i=1:length(levels_code)
    probabilties(i)=sum(x_quantized==levels_code(i));
end
probabilties=probabilties/length(x_quantized);
%huffman coding
[dict,avglen]=huffmandict(levels_code,probabilties);
compressed_signal = huffmanenco(x_quantized,dict);
Compression_ratio=4/avglen;
entropy=sum(-1.*probabilties.*log2(probabilties));
efficiency=entropy/avglen;
%modulation
modulated_signal = pskmod(compressed_signal,4);
%demodulation
demodulated_signal = pskdemod(modulated_signal,4);
%decoding the signal
dsig = huffmandeco(demodulated_signal,dict);
for i=1:length(dsig)
    for k=1:length(levels)
        if (dsig(i)==levels_code(k))
            dsig(i)=levels(k);
        end
    end
end
plot(xsample)
hold on
plot(dsig)







