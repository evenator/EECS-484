function [ patterns, targets ] = load_training_bananas(n_samples, over_sample)

%Load Ripe Bananas
file_list = ls('input/ripe');
[list_length, ~] = size(file_list);
ripe_data = zeros(over_sample * (list_length-2), n_samples*3);
for i = 3:list_length
    banana_image = imread(['input/ripe/' file_list(i,:)]);
    for j = 1:over_sample
        banana_vec = banana2vec(banana_image, n_samples);
        ripe_data(j+over_sample*(i-3),:) = banana_vec;
    end
end
ripe_targets = ones( over_sample*(list_length-2), 1) * [1 0 0];

%Load Under Ripe Bananas
file_list = ls('input/under_ripe');
[list_length, ~] = size(file_list);
under_ripe_data = zeros(over_sample * (list_length-2), n_samples*3);
for i = 3:list_length
    banana_image = imread(['input/under_ripe/' file_list(i,:)]);
    for j = 1:over_sample
        banana_vec = banana2vec(banana_image, n_samples);
        under_ripe_data(j+over_sample*(i-3),:) = banana_vec;
    end
end
under_ripe_targets = ones( over_sample*(list_length-2), 1) * [0 1 0];

%Load Over Ripe Bananas
file_list = ls('input/over_ripe');
[list_length, ~] = size(file_list);
over_ripe_data = zeros(over_sample * (list_length-2), n_samples*3);
for i = 3:list_length
    banana_image = imread(['input/over_ripe/' file_list(i,:)]);
    for j = 1:over_sample
        banana_vec = banana2vec(banana_image, n_samples);
        over_ripe_data(j+over_sample*(i-3),:) = banana_vec;
    end
end
over_ripe_targets = ones( over_sample*(list_length-2), 1) * [0 0 1];

patterns = cat(1,ripe_data, under_ripe_data, over_ripe_data);
targets = cat(1,ripe_targets, under_ripe_targets, over_ripe_targets);