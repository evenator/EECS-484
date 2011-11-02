%Plot out response surface
plot_steps = 10;
plot_inputs = zeros((plot_steps+1)^2,ninputs);
%Create an input set, the long way
n = 1;
x_pts = inputs_min(1) : (inputs_range(1)/plot_steps) : inputs_max(1);
y_pts = inputs_min(2):(inputs_range(2)/plot_steps) : inputs_max(2);
for i = x_pts
    for j = y_pts
        plot_inputs(n,:) = [i, j];
        n = n+1;
    end
end
%Simulate and plot
plot_output = sim_gamma(W_ai, W_ba, W_gb, plot_inputs);
plot_output = reshape(plot_output, plot_steps+1, plot_steps+1);
figure(4)
plot3(inputs(:,1),inputs(:,2),targets,'*',inputs(:,1),inputs(:,2),x_sim,'x')
title('Sample Points and Simulated Function (surface)')
hold on;
surf(x_pts, y_pts,plot_output)
hold off;
axis([inputs_min(1)-1, inputs_max(1)+1, inputs_min(2)-1, inputs_max(2)+1, min(targets)-1, max(targets)+1])