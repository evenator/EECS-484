%maxnet simulation: for nnodes number of nodes, each node has a unity
%autapse and every pair of nodes has mutual inhibition of strength eps (<0)
% start w/ random initialization of the neural outputs, sigma_vec, then
% simulate the evolution of the network (with implicit time constant = 1)
%activation function is assumed to output zero for any negative input, but
%is linear (with slope=1) for any non-negative input
clear all %delete any old variables still hanging around

eps = -0.02 %choose mutual inhibition strength
node_count = 5 %choose a number of interconnected nodes
W = eps * ones(node_count, node_count) + (1 - eps) * eye(node_count)

%initialize a set of outputs:
sigma_vec = rand(node_count,1)
[true_max_val, true_max_node] = max(sigma_vec)

sigma_history = [sigma_vec];
time =0; %create time vector to enable plotting
time_vec=[time];
%plot evolution of all outputs up to this point...
figure(1)
clf
hold all %allow adding new data to figure 1
for i=1:node_count
    plot(time,sigma_vec(i))
end

while length(find(sigma_vec))>1
    time = time+1; %implicitly sets the time delay of each neuron (stimulus to response) to be 1 unit
    time_vec = [time_vec,time]; %add an element to the time vector
 
    net_inputs = W*sigma_vec; %make sure you understand what this means and why it is true

    %for each neuron, compute firing rate as a function of net voltage at soma
    for i=1:node_count
        sigma_vec(i) = activation_fnc(net_inputs(i)); %outputs follow from inputs and activation fnc
    end
    sigma_vec; %display the output values
    sigma_history = [sigma_history,sigma_vec]; %keep track of this for plotting history
end

time
sigma_vec
max_node = find(sigma_vec)
max_val = sigma_vec(max_node)
 
%rest of this is just plotting--overwrite the figure to show current status
hold off %clear the figure
clf
hold all %allows adding multiple lines to the plot
for i=1:node_count
    y_vec=sigma_history(i,:); %strip off i'th row of neural responses (for i'th neuron's responses)
    plot(time_vec,y_vec) %plot this neural response vs time
end
title('Maxnet time history of outputs')
xlabel('time')
ylabel('sigma outputs')
% done with plot