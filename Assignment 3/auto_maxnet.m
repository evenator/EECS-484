%maxnet simulation: for nnodes number of nodes, each node has a unity
%autapse and every pair of nodes has mutual inhibition of strength eps (<0)
% start w/ random initialization of the neural outputs, sigma_vec, then
% simulate the evolution of the network (with implicit time constant = 1)
%activation function is assumed to output zero for any negative input, but
%is linear (with slope=1) for any non-negative input

W = eps * ones(node_count, node_count) + (1 - eps) * eye(node_count);

%initialize a set of outputs:
sigma_vec = rand(node_count,1);
[true_max_val, true_max_node] = max(sigma_vec);
time = 0;

while length(find(sigma_vec))>1
    time = time+1; %implicitly sets the time delay of each neuron (stimulus to response) to be 1 unit
    
    net_inputs = W*sigma_vec; %make sure you understand what this means and why it is true

    %for each neuron, compute firing rate as a function of net voltage at soma
    for i=1:node_count
        sigma_vec(i) = activation_fnc(net_inputs(i)); %outputs follow from inputs and activation fnc
    end
end

time;
sigma_vec;
max_node = find(sigma_vec);
max_val = sigma_vec(max_node);