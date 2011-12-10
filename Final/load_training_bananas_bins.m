function [ patterns, targets ] = load_training_bananas_bins(n_samples, n_bins, over_sample)

%Load Ripe Bananas
file_list = ls('input/ripe');
[list_length, ~] = size(file_list);
ripe_data = zeros(over_sample * (list_length-2), n_bins);
for i = 3:list_length
    banana_image = imread(['input/ripe/' file_list(i,:)]);
    for j = 1:over_sample
        banana_vec = banana2binvec(banana_image,n_samples,  n_bins);
        ripe_data(j+over_sample*(i-3),:) = banana_vec;
    end
end
ripe_targets = ones( over_sample*(list_length-2), 1) * 1;

%Load Under Ripe Bananas
file_list = ls('input/under_ripe');
[list_length, ~] = size(file_list);
under_ripe_data = zeros(over_sample * (list_length-2), n_bins);
for i = 3:list_length
    banana_image = imread(['input/under_ripe/' file_list(i,:)]);
    for j = 1:over_sample
        banana_vec = banana2binvec(banana_image,n_samples,  n_bins);
        under_ripe_data(j+over_sample*(i-3),:) = banana_vec;
    end
end
under_ripe_targets = ones( over_sample*(list_length-2), 1) * 2;

%Load Over Ripe Bananas
file_list = ls('input/over_ripe');
[list_length, ~] = size(file_list);
over_ripe_data = zeros(over_sample * (list_length-2), n_bins);
for i = 3:list_length
    banana_image = imread(['input/over_ripe/' file_list(i,:)]);
    for j = 1:over_sample
        banana_vec = banana2binvec(banana_image,n_samples,  n_bins);
        over_ripe_data(j+over_sample*(i-3),:) = banana_vec;
    end
end
over_ripe_targets = ones( over_sample*(list_length-2), 1) * 3;

patterns = cat(1,ripe_data, under_ripe_data, over_ripe_data);
targets = cat(1,ripe_targets, under_ripe_targets, over_ripe_targets);