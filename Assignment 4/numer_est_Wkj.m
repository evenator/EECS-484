%do numerical estimation of derivatives dEsqd/dWkj
function  dWkj= numer_est_Wkj(Wji,Wkj,training_patterns,targets)
temp =size(targets);
P=temp(1); %number of training patterns
K=temp(2); %number of outputs
temp = size(Wji);
J=temp(1); %number of interneurons
I=temp(2); %dimension of input patterns
[rmserr,esqd] = err_eval(Wji,Wkj,training_patterns,targets);
dWkj=0*Wkj;
eps=0.000001;
%Wkj
for k=1:K
    for j=1:J
       % j
        Wtemp=Wkj;
        Wtemp(k,j)=Wtemp(k,j)+eps;
       % Wtemp
        [temp1,esqd2]=err_eval(Wji,Wtemp,training_patterns,targets);
        dout=esqd2-esqd;
        dWkj(k,j)=dout/eps;
    end
end
dWkj=0.5*dWkj; %deriv defined w/rt 1/2 * dEsqd/dwkj
