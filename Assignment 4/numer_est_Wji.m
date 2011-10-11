%do numerical estimation of derivatives dEsqd/dWkj
function  dWji= numer_est_Wji(Wji,Wkj,training_patterns,targets)
temp =size(targets);
P=temp(1); %number of training patterns
K=temp(2); %number of outputs
temp = size(Wji);
J=temp(1); %number of interneurons
I=temp(2); %dimension of input patterns
[rmserr,esqd] = err_eval(Wji,Wkj,training_patterns,targets);
dWji=0*Wji;
eps=0.000001;
%Wji
for j=1:J
    for i=1:I
       % j
        Wtemp=Wji;
        Wtemp(j,i)=Wtemp(j,i)+eps;
       % Wtemp
        [temp1,esqd2]=err_eval(Wtemp,Wkj,training_patterns,targets);
        dout=esqd2-esqd;
        dWji(j,i)=dout/eps;
    end
end
dWji=0.5*dWji; %deriv defined w/rt 1/2 * dEsqd/dwji
