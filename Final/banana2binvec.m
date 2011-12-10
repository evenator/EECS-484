function [ bin_vec ] = banana2binvec( banana_im, sample_size, n_bins )
mask = im2bw(banana_im, .99);
mask = ~mask;
banana_im = rgb2hsv(banana_im);
im_vec = reshape(banana_im(:,:,1),[],1);
banana_pixels = reshape(mask,[],1);
banana_arr = im_vec(banana_pixels);
[num_pixels ~] = size(banana_arr);
sample_indeces = random('unid',num_pixels,[sample_size,1]);
banana_vec = banana_arr(sample_indeces,:);
bin_vec = zeros(n_bins, 1);
for i = 1:n_bins
    bin_min = (i-1)/n_bins;
    bin_max = i/n_bins;
    bin_vec(i) = sum((banana_vec<bin_max) & (banana_vec>=bin_min));
end
end