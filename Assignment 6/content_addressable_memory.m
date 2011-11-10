%content_addressable_memory.m:
% read in files to memorize and cues to recover memories
%note: put bitmaps in /images directory

nrows = 16;
ncols = 32;
nbits = nrows * ncols;

MatrixMem = zeros(nbits);
MatrixMem = addMemory(MatrixMem, 'happyworld.bmp');
MatrixMem = addMemory(MatrixMem, 'clubspade.bmp');
MatrixMem = addMemory(MatrixMem, 'printtrash.bmp');
MatrixMem = addMemory(MatrixMem, 'handheart.bmp');
%MatrixMem = addMemory(MatrixMem, 'computersum.bmp');
%MatrixMem = addMemory(MatrixMem, 'winhelp.bmp');
%MatrixMem = addMemory(MatrixMem, 'notespell.bmp');

fname = input('enter filename of cue: ','s'); %prompt for a cue (flawed memory)
Aerr = imread(['images/' fname]);

Avec_err = matrix2vec(Aerr);
AVecRecall = Avec_err;

while 1>0 %Infinite loop, runs until you choose 0 or fewer nodes to update
  nupdates = input('enter number of nodes to update:' );
  if nupdates <=0
      break
  end;
  numchanges = 0;
  for iupdate = 1:nupdates
    [AVecRecall, delta] = updateRandomNode(MatrixMem, AVecRecall); %WRITE THIS FUNCTION
    numchanges = numchanges + delta;
  end
   numchanges %print out how many nodes were changed
   AmatCorrected = vec2matrix(AVecRecall, nrows, ncols); %convert vector back to matrix

   imwrite(AmatCorrected, 'processedMemory.bmp') %and write matrix as a bitmap
     %may view these bitmaps to observe progress.
end