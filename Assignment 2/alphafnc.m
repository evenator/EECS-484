%neighborhood fnc; should decay in time and space
function [alpha,radius]=alphafnc(i,j,ictr,jctr,time)
%compute distance of cluster at i,j from "central" cluster located at
%ictr,jctr
dist = pdist([i, j; ictr, jctr], 'euclidean'); %uses Euclidean dist

%Influence radius
radius_init = 3;
tau = 1000;
radius = radius_init * exp(-time/tau);
%radius = radius_init; %*exp(-time/10000);% (1-time/100000);% * 1/(1+exp(time-1000));

%alpha decays linearly w/ radius
alpha_init = .1;
alpha = alpha_init * exp(-dist^2/(2*radius^2));
%alpha = alpha_init/(1+exp(dist-radius));%* 1/(time/10000*(1+exp(dist-radius)));

%return value of alpha=influence coefficient of current pattern vector on
%cluster at location i,j.  Also return the influence radius, "radius"