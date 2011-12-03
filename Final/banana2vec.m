function [ banana_vec ] = banana2vec( banana_im, sample_size )
im_mat = cat(2,reshape(banana_im(:,:,1),[],1),reshape(banana_im(:,:,2),[],1),reshape(banana_im(:,:,3),[],1));
sum_im_mat = sum(im_mat,2);
banana_pixels = sum_im_mat<765;
banana_mat = im_mat(banana_pixels,:);
[num_pixels ~] = size(banana_mat);
sample_indeces = random('unid',num_pixels,[sample_size,1]);
sample_mat = banana_mat(sample_indeces,:);
banana_vec = reshape(sample_mat,1,[]);
end

