function [ alpha ] = som_alpha(target_bin, chosen_bin, time)
%Compute influence alpha of chosen_bin on target_bin

global r tau_r alpha0 tau_alpha;
dist = abs(chosen_bin - target_bin); %Linear distance in 1D space

%Influence radius
radius = r * exp(-time/tau_r);

%alpha decays linearly w/ radius
alpha = alpha0 * exp(-time/tau_alpha) * exp(-dist^2/(2*radius^2));
end

