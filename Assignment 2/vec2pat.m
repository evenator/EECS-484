%input a 64x1 vector and output an 8x8 pattern
%NO EDITS NEEDES
function [pat8x8] = vec2pat(vec64x1)

pat8x8=[];
for (icol=1:8)
  pat8x8=[pat8x8,vec64x1( 1+(icol-1)*(8): 8+(icol-1)*(8))];
end
%bar3(pat8x8) %can test result this way