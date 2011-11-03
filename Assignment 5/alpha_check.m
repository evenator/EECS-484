%Plot out alpha layer
figure(2)
clf;
stop_num = 20;
if stop_num>nalpha
    stop_num = nalpha;
end
plotdim = ceil(sqrt(stop_num));

%Plot out response surface
plot_steps = 20;
plot_inputs = zeros((plot_steps+1)^2,ninputs);
%Create an input set, the long way
n = 1;
x_pts = inputs_min(1) : (inputs_range(1)/plot_steps) : inputs_max(1);
y_pts = inputs_min(2):(inputs_range(2)/plot_steps) : inputs_max(2);
for i = x_pts
    for j = y_pts
        plot_inputs(n,:) = [j,i];
        n = n+1;
    end
end
%Simulate and plot
plot_output = sim_alpha(W_ai, plot_inputs);
for i=1:stop_num
    subplot(plotdim,plotdim,i);
    hold on
    z = plot_output(i,:);
    z_out = reshape(z, plot_steps+1, plot_steps+1);
    surf(x_pts, y_pts, z_out);
    %x = W_ai(i,1) * W_ai(i,2)/sqrt(W_ai(i,2)^2+W_ai(i,3)^2);
    %y = W_ai(i,1) * W_ai(i,3)/sqrt(W_ai(i,2)^2+W_ai(i,3)^2);
    %plot3(x, y, .1,'b*');
    plot3(inputs(:,1), inputs(:,2),ones(npatterns,1),'b*');
    %plot_perceptron(W_ai(i,:));
    hold off
    title('trained alpha node response')
end