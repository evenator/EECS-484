%function compute_F_u computes ordered derivatives at time t
%with respect to u's
function  F_u_vec = compute_F_u(F_o,gprimes,t)
[Nneurons, T_time_steps] = size(F_o);

F_u_vec = zeros(Nneurons,1); %initialize vector of dE/du(t) to zeros
for i=3:Nneurons %only care about neurons 3 through final
    F_u_vec(i) = gprimes(i,t)*F_o(i,t);
end
