%function to evaluate a 2-input, single-output, 2-layer feedforward network
%and plot it as a surface plot
function ffwd_beta_surfplot(W_ai,W_ba,ibeta)

xvals = -1:0.1:1;
yvals = -1:0.1:1;
imax = length(xvals);
jmax = length(yvals);
Zu=zeros(imax,jmax);
Zsig=zeros(imax,jmax);

for i=1:imax
    for j=1:jmax
        sig_betas = sim_beta(W_ai, W_ba, [xvals(i),yvals(j)]);
        Zsig(i,j)= sig_betas(ibeta);
    end
end
surf(xvals,yvals,Zsig)
title('beta node outputs')