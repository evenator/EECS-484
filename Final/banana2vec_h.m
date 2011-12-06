function [ banana_vec ] = banana2vec_h( banana_im, sample_size )
mask = im2bw(banana_im, .99);
mask = ~mask;
banana_im = rgb2hsv(banana_im);
im_vec = reshape(banana_im(:,:,1),[],1);
banana_pixels = reshape(mask,[],1);
banana_arr = im_vec(banana_pixels);
[num_pixels ~] = size(banana_arr);
sample_indeces = random('unid',num_pixels,[sample_size,1]);
banana_vec = banana_arr(sample_indeces,:);
end