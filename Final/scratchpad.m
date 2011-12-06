
file_list = ls('input/ripe');
[list_length, ~] = size(file_list);
ripe_data = zeros(over_sample * (list_length-2), n_samples*3);
for i = 3
    banana_image = imread(['input/ripe/' file_list(i,:)]);
    for j = 1
        banana_vec = banana2vec_hsv(banana_image, n_samples);
        ripe_data(j+over_sample*(i-3),:) = banana_vec;
    end
end