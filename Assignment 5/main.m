clear all

%Load Data
load 'arm_x.txt' %data file containing columns of feature 1, feature 2 and targets
inputs = arm_x(:,1:2);
targets = arm_x(:,3);
[npatterns, ninputs] = size(inputs);
[~,ngamma] = size(targets);

%Scale inputs -1 to 1. Only affects weights onto alpha
inputs(:,1) = scale_inputs(inputs(:,1));
inputs(:,2) = scale_inputs(inputs(:,2));

inputs_min = min(inputs);
inputs_max = max(inputs);
inputs_range = range(inputs);

%TUNING PARAMETERS

%Use this many alpha-layer perceptrons:
nalpha = 10000;
%Use this many beta-layer basis functions (must be less than ninputs)
nbeta=100;
%Add this constant to the beta layer bias
epsilon_beta = 6200;
%gain on beta weights
beta_gain = .005;

%END TUNING PARAMETERS

%Plot out training data
figure(1)
clf
plot3(inputs(:,1),inputs(:,2),targets,'*')
title('Training Data')

%Initialize weights into alpha layer
%See report for derivations of these equations
W_ai = zeros(nalpha,ninputs+1);
W_ai(:,2:(ninputs+1)) = random('unif',-1,1,nalpha,ninputs);
W_ai(:,1) = random('unif', -sum(abs(W_ai),2), sum(abs(W_ai),2), nalpha, 1);
%W_ai(:,2:(ninputs+1)) = 2 * W_ai(:,2:(ninputs+1)) ./ (ones(nalpha, 1) * inputs_range);
%W_ai(:,1) = W_ai(:,1) - sum((inputs_max +inputs_min)./ inputs_range);

%Plot out alpha layer
%alpha_check;

%Initialize weights from alpha layer to beta layer
W_ba = zeros(nbeta,nalpha+1);
%Select weights by imprintings patterns onto each beta node
%Randomly select a pattern for each beta node, but do not repeat any
%patterns
pat_list = zeros(nbeta,1);
for ibeta=1:nbeta
    %Randomly choose a pattern
    ipat = random('unid',npatterns);
    %If the pattern is already used, try again
    while ~isempty(find(pat_list==ipat ))
        ipat = random('unid',npatterns);
    end
    
    %Add the chosen pattern to the list of chosen patterns
    pat_list(ibeta) = ipat;
    
    sig_a = sim_alpha(W_ai, inputs(ipat,:));
    
    %Set weights so positive inputs to beta node have 1, negative have -1
    wvec = [0; sign(sig_a)];
    bias = -nalpha + epsilon_beta;
    wvec(1) = bias;
    W_ba(ibeta,:) = beta_gain * wvec'; %install these weights in the weight matrix
end

%Plot out beta layer
%Simulate beta
xvals = -1:0.1:1;
yvals = -1:0.1:1;
imax = length(xvals);
jmax = length(yvals);
Zsig=zeros(imax,jmax,nbeta);
for i=1:imax
    for j=1:jmax
        sig_betas = sim_beta(W_ai, W_ba, [xvals(i),yvals(j)]);
        Zsig(j,i,:)= sig_betas;
    end
end
%Plot
figure(3)
clf;
plotdim = ceil(sqrt(nbeta));
for ibeta=1:nbeta
    ibeta;
    subplot(plotdim,plotdim,ibeta);
    hold on
    surf(xvals,yvals,Zsig(:,:,ibeta))
    title('beta node outputs')
    plot3(inputs(pat_list(ibeta),1),inputs(pat_list(ibeta),2),1,'r*');
    hold off
    title('trained beta node response')
end

%Do Algebraic Solution
%algebraic solution uses pseudoinverse to find  min-squared error solution for w_vec:
%want   target_vals' = w_vec*sig_betas
%need to match: target_vals' = w_vec*sig_betas = w_vec*F
% or, target_vals = F' * w_vec'
%or, w_vec' = F'\target_vals

F = sim_beta(W_ai, W_ba, inputs);
w_vec =F'\targets; %row vector of weights from beta to gamma
w_vec = w_vec'; %turn w_vec into a column vector

%Simulate:
x_sim = sim_gamma(W_ai, W_ba, w_vec, inputs);

%compute the sum squared error for simulation of all training data:
errvec = targets - x_sim';
Esqd_avg = norm(errvec)/npatterns;
rms_err = sqrt(Esqd_avg)

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
plot_output = sim_gamma(W_ai, W_ba, w_vec, plot_inputs);
plot_output = reshape(plot_output, plot_steps+1, plot_steps+1);
figure(4)
plot3(inputs(:,1),inputs(:,2),targets,'*',inputs(:,1),inputs(:,2),x_sim,'x')
title('Sample Points and Simulated Function (surface)')
hold on;
surf(x_pts, y_pts,plot_output)
hold off;
axis([inputs_min(1)-1, inputs_max(1)+1, inputs_min(2)-1, inputs_max(2)+1, min(targets)-1, max(targets)+1])


%Do Random Solution

%Initialize weights from beta layer to gamma layer
W_gb = zeros(ngamma,nbeta+1);