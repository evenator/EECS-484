%function to evaluate a 2-input, single-output, 2-layer feedforward network
%and plot it as a surface plot
function ffwd_beta_surfplot(W1p,W21,ibeta)

xvals = -1:0.1:1;
yvals = -1:0.1:1;
imax = length(xvals);
jmax = length(yvals);
Zu=zeros(imax,jmax);
Zsig=zeros(imax,jmax);

for i=1:imax
    for j=1:jmax
        stim = [1;xvals(i);yvals(j)]; %stimulate network at this set of inputs, including bias
        u_alphas = W1p*stim; %vector of alpha-node inputs
        sig_alphas = [1;tansig(u_alphas)]; %outputs of alpha layer
        u_betas = W21*sig_alphas; %inputs to beta nodes
        sig_betas = logsig(u_betas); %outputs of beta nodes--not including bias
        
        %gamma = F*sig_betas;
        Zu(i,j)= u_betas(ibeta);
        Zsig(i,j)= sig_betas(ibeta); %gamma;
    end
end
%figure(1)
%surf(xvals,yvals,Zu)
%title('beta node inputs')
surf(xvals,yvals,Zsig)
title('beta node outputs')