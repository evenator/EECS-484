%input an 8x8 matrix and create a 64x1 vector, strung out vertically
%NO EDITS NEEDED
function [vec64x1] = pat2vec(pat8x8)
grab_cols=eye(8,8);
vec64x1=[];
for (icol=1:8)
vec64x1=[vec64x1;pat8x8*grab_cols(:,icol)];
end