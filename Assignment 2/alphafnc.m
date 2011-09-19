%neighborhood fnc; should decay in time and space
function [alpha,radius]=alphafnc(i,j,ictr,jctr,time)
%compute distance of cluster at i,j from "central" cluster located at
%ictr,jctr
radius = pdist([i, j; ictr, jctr], 'euclidean'); %uses Euclidean dist

%alpha decays linearly w/ radius
alpha_init = .1;
alpha = alpha_init / radius;
alpha = alpha / time;
%return value of alpha=influence coefficient of current pattern vector on
%cluster at location i,j.  Also return the influence radius, "radius"