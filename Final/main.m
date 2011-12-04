clear all
clc

%Begin Tunable Parameters
n_samples = 10000; %Number of pixels to sample in each image
over_sample = 5; %How many times to sample from each image

%End Tunable Parameters

%Load Data and Sample From Images
[patterns, targets] = load_training_bananas(n_samples,over_sample);

%Create Validation Vectors by Sampling Yet Again
[validation, val_targets] = load_training_bananas(n_samples,1);

%Classify with Self-Ordered Mapping
som_bananify
