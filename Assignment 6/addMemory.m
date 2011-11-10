function [ memMatrix ] = addMemory( memMatrix, fileName )
%addMemory Adds an image with file name fileName (in outputs folder) to the
%memory matrix

A = imread(['images/' fileName]);
[nrows,ncols] = size(A);
nbits = nrows*ncols;
Avec = matrix2vec(A);
memMatrix = Avec*Avec' + memMatrix - eye(nbits);
end

