global r tau_r alpha0 tau_alpha;

%Tunable Parameters
num_bins = 10;
training_time = 1000;
r = 3; %Influence Radius
tau_r = 1000; %Influence Radius Decay Time Constant
alpha0 = .2; %Influence at distance=0
tau_alpha = 1000; %Influence Decay Time Constant
%End Tunable Parameters

[n_pats pat_length] = size(patterns);

%Create bins
bins = random('unid', 100, [num_bins,pat_length] );

%Normalize Bin Feature Vectors
for i = 1:num_bins
    bins(i,:) = bins(i,:) ./ norm(bins(i,:));
end

%Train Bins
time=0;
while (time<training_time)
    time = time+1;
    ipat = ceil(rand*n_pats); %pick a pattern at random
    testvec = patterns(ipat,:); %extract the corresponding row vector
    
    %For the selected pattern, find the closest bin
    bin_index = som_find_closest_bin(testvec, bins);
    
    %Update the indentified bin and its neighbors
    for i = 1:num_bins
        alpha = som_alpha(i, bin_index, time);
        bins(i,:) = bins(i,:) + alpha * (testvec - bins(i,:));
        bins(i,:) = bins(i,:) ./ norm(bins(i,:));
    end
end