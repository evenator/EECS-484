function [ sig_b ] = sim_beta( W_ai, W_ba, inputs )
%Simulates up through beta layer
    sig_a = sim_alpha(W_ai, inputs);
    [ninputs, ~] = size(inputs);
    stim_b = [ones(1,ninputs); sig_a];
    u_b = W_ba * stim_b; %Inputs to beta layer
    sig_b = logsig(u_b); %Outputs from beta layer
end

