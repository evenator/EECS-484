%content_addressable_memory.m:
% read in files to memorize and cues to recover memories
%note: put bitmaps in /images directory

A = imread('images/happyworld.bmp'); % example file to read in.

[nrows,ncols]=size(A); %get bitmap dimensions;
                                         % need to remember these to convert vector back to matrix
nbits=nrows*ncols; %when string out matrix, will have this many bits in vector

Avec=matrix2vec(A); %convert image to a bipolar vector 

%create matrix memory from this vector
% EXPLORE ALTERNATIVES: suppress diagonal terms?
MatrixMem=Avec*Avec'; %outer product 

% read in some more images...
% experiment with how many and which images to read in...
A = imread('images/clubspade.bmp')
Avec = matrix2vec(A);
M=Avec*Avec'; % again, consider partial or full suppression of diagonal
MatrixMem=MatrixMem+M; %include more memories by merely adding them into matrix

%ditto for more bitmaps...
% A = imread('printtrash.bmp')
% A = imread('handheart.bmp')
% A = imread('clubspade.bmp')
% A = imread('computersum.bmp')
% A = imread('winhelp.bmp')
% A = imread('notespell.bmp')

size(MatrixMem) % debug--should be 512x512 for these examples

fname = input('enter filename of cue: ','s'); %prompt for a cue (flawed memory)
Aerr=imread(['images/' fname]);

Avec_err=matrix2vec(Aerr);
AVecRecall=Avec_err;

while 1>0 % infinite loop...
  nupdates = input('enter number of nodes to update:' );
  if nupdates <=0
      break
  end;
  numchanges=0;
  for iupdate=1:nupdates
    [AVecRecall,delta] = updateRandomNode(MatrixMem,AVecRecall); %WRITE THIS FUNCTION
    numchanges = numchanges+delta;
  end
   numchanges %print out how many nodes were changed
   AmatCorrected=vec2matrix(AVecRecall,nrows,ncols); %convert vector back to matrix

   imwrite(AmatCorrected,'processedMemory.bmp') %and write matrix as a bitmap
     %may view these bitmaps to observe progress.
end %runs forever...will have to ctl-C to halt