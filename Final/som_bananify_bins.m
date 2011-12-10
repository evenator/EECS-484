global r tau_r alpha0 tau_alpha;

%Tunable Parameters
num_bins = 5;
training_time = 10000;
r = .2; %Influence Radius
tau_r = 100; %Influence Radius Decay Time Constant
alpha0 = .9; %Influence at distance=0
tau_alpha = 100; %Influence Decay Time Constant
%End Tunable Parameters

[n_pats pat_length] = size(patterns);

%Create bins and initialize with random patterns (initializing randomly
%results in all patterns being binned together)
bins = zeros(num_bins, pat_length);
pat_list = zeros(num_bins,1);
%pick a random pattern number:
for i = 1:num_bins
    %Randomly choose a pattern
    ipat = random('unid',n_pats);
    %If the pattern is already in a bin, try again
    while ~isempty(find(pat_list==ipat ))
        ipat = random('unid',n_pats);
    end
    %Add the pattern to the list
    pat_list(i) = ipat;
    %Initialize the bin
    bins(i,:) = ipat;
end

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

%Assign patterns to bins
[num_validation_pats ~] = size(validation);
bin_list = zeros(num_validation_pats, 1);
for i = 1:num_validation_pats
    bin_list(i) = som_find_closest_bin(validation(i,:),bins);
end

%Debug results
cat(2,bin_list,val_targets)