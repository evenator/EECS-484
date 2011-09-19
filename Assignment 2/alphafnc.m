%neighborhood fnc; should decay in time and space
function [alpha,radius]=alphafnc(i,j,ictr,jctr,time)
%compute distance of cluster at i,j from "central" cluster located at
%ictr,jctr
dist = pdist([i, j; ictr, jctr], 'euclidean'); %uses Euclidean dist

%Influence radius
radius_init = 6;
radius = radius_init / time;

%alpha decays linearly w/ radius
alpha_init = .1;
if dist > radius
    alpha = 0;
else
    alpha = alpha_init * (dist-radius)/radius;
end
%return value of alpha=influence coefficient of current pattern vector on
%cluster at location i,j.  Also return the influence radius, "radius"