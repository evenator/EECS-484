%neighborhood fnc; should decay in time and space
function [alpha,radius]=alphafnc(i,j,ictr,jctr,time)
%compute distance of cluster at i,j from "central" cluster located at
%ictr,jctr
dist = pdist([i, j; ictr, jctr], 'euclidean'); %uses Euclidean dist

%Influence radius
radius_init = 3;
tau_r = 16600;
radius = radius_init * exp(-time/tau_r);
%radius = radius_init; %*exp(-time/10000);% (1-time/100000);% * 1/(1+exp(time-1000));

%alpha decays linearly w/ radius
alpha_init = .2;
tau_a = 50000;
alpha = alpha_init * exp(-time/tau_a) * exp(-dist^2/(2*radius^2));