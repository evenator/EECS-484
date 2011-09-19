%neighborhood fnc; should decay in time and space
function [alpha,radius]=alphafnc(i,j,ictr,jctr,time)
%alpha decays linearly w/ radius
%compute distance of cluster at i,j from "central" cluster located at
%ictr,jctr
%return value of alpha=influence coefficient of current pattern vector on
%cluster at location i,j.  Also return the influence radius, "radius"
%YOU MUST EDIT THIS FUNCTION
alpha=0.1; %poor choices for alpha and radius, which should vary in time
radius=2;





