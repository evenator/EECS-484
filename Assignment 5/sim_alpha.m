function [ sig_a ] = sim_alpha( W_ai, inputs )
%Simulates up through alpha layer
    [ninputs, ~] = size(inputs);
    
    stim_a = [ones(ninputs,1), inputs];
    u_a = W_ai * stim_a'; %Inputs to alpha layer
    sig_a = tansig(u_a); %Outputs from alpha layer
end

