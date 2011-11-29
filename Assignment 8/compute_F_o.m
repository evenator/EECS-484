%function compute_F_o--compute ordered derivative F_o at time t
%return vector dF/dsigma at time t
function [F_o_vec] = compute_F_o(W,errs,F_u,t)

[Nneurons, T_time_steps] = size(F_u);
F_o_vec = zeros(Nneurons,1);

%step through all nodes, except bias and input;
%update all ordered derivs w/rt sigmas at time step t
% for t< final time, dE/dsigma(t) depends on dE/du(t+1)
if t<T_time_steps
    F_u_vec = F_u(:,t+1);
    F_o_vec = errs(t)*ones(4,1) + W*F_u_vec;
end

F_o_vec(1)=0; %don't change bias = neuron 1
F_o_vec(2)=0; %don't change input = neuron 2
%for output node, neuron 3, add in influences of partial deriv of errors w/rt sigmas at time t
%FIX THIS
