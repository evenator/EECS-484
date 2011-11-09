%vec2mat: converts a vector to a matrix by extracting cols of length nrows
%and inserting them as parallel columns in a matrix
%need to know the dimensions of the desired matrix, nrows x ncols
function [Amat]=vec2matrix(Avec,nrows,ncols)

%convert bipolar vector to logic (0,1)
Avec = Avec > 0;

%now, chop up vector and stack sections side by side to make matrix
Amat = reshape(Avec,nrows,ncols);