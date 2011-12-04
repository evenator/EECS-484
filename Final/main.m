clear all
clc

%Begin Tunable Parameters
n_samples = 1000; %Number of pixels to sample in each image
over_sample = 5; %How many times to sample from each image

%End Tunable Parameters

%Load Data and Sample From Images
[patterns, targets] = load_training_bananas(n_samples,over_sample);

%Classify with Self-Ordered Mapping
som_bananify
