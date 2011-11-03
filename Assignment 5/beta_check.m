%Plot out beta layer
%Simulate beta
xvals = -1:0.1:1;
yvals = -1:0.1:1;
imax = length(xvals);
jmax = length(yvals);
Zsig=zeros(imax,jmax,nbeta);
for i=1:imax
    for j=1:jmax
        sig_betas = sim_beta(W_ai, W_ba, [xvals(i),yvals(j)]);
        Zsig(j,i,:)= sig_betas;
    end
end
%Plot
figure(3)
clf;
plotdim = ceil(sqrt(nbeta));
for ibeta=1:nbeta
    ibeta;
    subplot(plotdim,plotdim,ibeta);
    hold on
    surf(xvals,yvals,Zsig(:,:,ibeta))
    title('beta node outputs')
    %plot3(inputs(pat_list(ibeta),1),inputs(pat_list(ibeta),2),1,'r*');
    hold off
    title('trained beta node response')
end