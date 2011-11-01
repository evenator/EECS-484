%function to evaluate a 2-input, single-output, 2-layer feedforward network
%and plot it as a surface plot
function ffwd_beta_surfplot(W1p,W21,ibeta)
%try surface plot; theta1 range from 0.15 to 0.25
%0.22 to 0.384


xvals=[0:0.1:1]*0.1 +0.157;
yvals=[0:0.1:1]*0.16 +0.22;
Zu=zeros(11,11); %holder for 11x11 grid of outputs
Zsig=zeros(11,11);
for (i=1:11)
    for(j=1:11)
        stim = [1;xvals(i);yvals(j)]; %stimulate network at this set of inputs, including bias
        u_alphas = W1p*stim; %vector of alpha-node inputs
        sig_alphas=tansig(u_alphas); %outputs of alpha layer
        sig_alphas = [1;sig_alphas]; %insert bias node in alpha layer
        u_betas=W21*sig_alphas; %inputs to beta nodes
        sig_betas=logsig(u_betas); %outputs of beta nodes--not including bias
        
        %gamma = F*sig_betas;
        Zu(i,j)=u_betas(ibeta);
        Zsig(i,j)= sig_betas(ibeta); %gamma;
    end
end
figure(1)
surf(xvals,yvals,Zu)
title('beta node inputs')
figure(2)
surf(xvals,yvals,Zsig)
title('beta node outputs')