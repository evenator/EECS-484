function [ sig_g ] = sim_gamma( W_ai, W_ba, W_gb, inputs )
%Simulates up through gamma layer
    sig_b = sim_beta(W_ai, W_ba, inputs);
    stim_g = sig_b;
    u_g = W_gb * stim_g; %Inputs to gamma layer
    sig_g = u_g; %Outputs from gamma layer
end

