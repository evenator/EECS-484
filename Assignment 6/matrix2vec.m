%matrix2vec: converts a matrix to a vector by stacking all cols
function [Avec]=matrix2vec(A)

%first, string out the matrix into a vector
Avec = reshape(A,[],1);

%convert to bipolar 
Avec = Avec ~= 0;
Avec = Avec * 2 - ones(length(Avec),1);