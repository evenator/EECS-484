clc
clear all
tic
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
nalpha = 100;
%Use this many beta-layer basis functions (must be less than ninputs)
nbeta = 50;
%Add this constant to the beta layer bias
epsilon_beta = 10;
%gain on beta weights
beta_gain = .125;
%Max Perturbation Step (uniform dist)
max_delta = .5;
%Perturbation Std Dev (norm dist)
delta_std = 1;
%END TUNING PARAMETERS
disp('Data Loaded')
toc

%Plot out training data
% figure(1)
% clf
% plot3(inputs(:,1),inputs(:,2),targets,'*')
% title('Training Data')

%Initialize weights into alpha layer
%See report for derivations of these equations
W_ai = zeros(nalpha,ninputs+1);
W_ai(:,2:(ninputs+1)) = random('unif',-1,1,nalpha,ninputs);
W_ai(:,1) = random('unif', -sum(abs(W_ai),2), sum(abs(W_ai),2), nalpha, 1);
%W_ai(:,2:(ninputs+1)) = 2 * W_ai(:,2:(ninputs+1)) ./ (ones(nalpha, 1) * inputs_range);
%W_ai(:,1) = W_ai(:,1) - sum((inputs_max +inputs_min)./ inputs_range);

disp('Alpha Weights Set')
toc

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
    
    %Set bias
    bias = -nalpha + epsilon_beta;
    wvec(1) = bias;
    
    %Multiply entire thing by a gain <1 to soften the Gaussian
    W_ba(ibeta,:) = beta_gain * wvec'; %install these weights in the weight matrix
end

disp('Beta Weights Set')
toc

%Plot out beta layer
%beta_check;

%Do Algebraic Solution
%algebraic solution uses pseudoinverse to find  min-squared error solution for w_vec:
%want   target_vals' = w_vec*sig_betas
%need to match: target_vals' = w_vec*sig_betas = w_vec*F
% or, target_vals = F' * w_vec'
%or, w_vec' = F'\target_vals
F = sim_beta(W_ai, W_ba, inputs);
w_vec =F'\targets; %row vector of weights from beta to gamma
W_gb = w_vec'; %turn w_vec into a column vector

%Simulate:
x_sim = sim_gamma(W_ai, W_ba, W_gb, inputs);

%compute the sum squared error for simulation of all training data:
rms_err = output_error(x_sim,targets);
opt_err = rms_err;
disp('Algebraic Solution Computed')
disp(['RMS Error: ' num2str(rms_err)]);
toc

%Plot out response surface
figure(4)
clf;
gamma_check;

%Do Random Solution

%Initialize weights from beta layer to gamma layer
rms_hist = zeros(10000,1);
    
W_gb = zeros(ngamma,nbeta);
count = 1;
rms_err = inf;
last_hit = 0;
while(count<10000)
    %Generate perturbation vector
    %delta = random('norm',0,delta_std,ngamma,nbeta);
    delta = random('unif',-max_delta,max_delta,ngamma,nbeta);
    %Simulate with perturbed weights
    output = sim_gamma(W_ai,W_ba,W_gb+delta,inputs);
    %Calculate error
    new_err = output_error(output, targets);
    %If error is less than before, keep these weights
    if new_err<rms_err
        W_gb = W_gb + delta;
        rms_err = new_err;
        %disp(['RMS Error: ' num2str(rms_err)]);
        last_hit = count;
    end
    rms_hist(count) = rms_err;
    count = count +1;
end
disp([num2str(count) ' Random Perturbations Completed']);
if(count-last_hit<100)
    disp('Successful convergence');
else
    disp('Failed to converge');
end
disp(['RMS Error: ' num2str(rms_err)]);
toc

%Plot Out Results
figure(5)
clf;
gamma_check;

%Plot Out RMS History
figure(6)
clf;
plot(1:count,rms_hist(1:count));