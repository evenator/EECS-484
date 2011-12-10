clear all
clc

%Begin Tunable Parameters
n_samples = 1000; %Number of pixels to sample in each image
over_sample = 30; %How many times to sample from each image
n_bins = 100;
%End Tunable Parameters

resample = 0;
if(resample)
    
    %Load Data and Sample From Images
    [patterns, targets] = load_training_bananas_bins(n_samples,n_bins, over_sample);
    
    %Create Validation Vectors by Sampling Yet Again
    [validation, val_targets] = load_training_bananas_bins(n_samples, n_bins, 1);
    
    save('data')
end

load('data')
%Classify with Self-Ordered Mapping
disp('Self-Ordered Mapping');
som_bananify

%Classify with K-Means
disp('K-Means');
k_means_bananify