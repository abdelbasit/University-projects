function [ xq ,delta] = helper_quantize( xi,l )
maxi=max(xi);
mini=min(xi);
step=(maxi-mini)/l;
delta=step;
levels=mini+0.5*step:step:maxi-0.5*step
xq=zeros(size(xi));
for i=1:length(levels)
    for k=1:length(xi)
        if (((levels(i)-step/2)<=xi(k)&&((levels(i)+step/2)>=xi(k))))
            xq(k)=levels(i);
        end
    end
end
if(mod(l,2)==0)
    xq(xq==0)=levels(length(levels)/2);
end
end