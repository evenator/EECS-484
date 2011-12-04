function [ bin_index ] = som_find_closest_bin( test_vector, bins )
%Finds the index of the bin that is most similar to test_vector

[num_bins ~] = size(bins);

%Calculate the similarity to the first bin
best_sim = som_sim(test_vector,bins(1,:));
bin_index = 1;
%Calculate the similarity to each bin and find the most similar
for i = 2:num_bins
    sim = som_sim(test_vector,bins(i,:));
    if sim > best_sim
        best_sim = sim;
        bin_index = i;
    end
end

end

