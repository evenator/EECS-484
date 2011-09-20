%SOM routine: NEEDS EDITING
%uses the following scripts or functions:
%vec2pat(), pat2vec()
%find_closest_cluster()
%alphafnc(i,j,ictr,jctr,time)
%view_all_pattern_responses()
%eval_test_patterns

%load in training patterns
load scrambled_blobs
temp=size(scrambled_blobs);  %find the size and number of these patterns
npats=temp(1);
nrows=temp(2); %rows and patterns
ncols=temp(3); %of input images
vecdim=nrows*ncols; %image represented as a vector has this many elements

%input patterns are dimension nrows*ncols (8x8 for this PS).
%these patterns are to be organized into a set of clusters, which are
%organized in a grid of dimensions nclustrows*nclustcols
% each cluster has a normalized feature vector of nrows*ncols elements

%do NOT have to have cluster grid have same dims as patterns;
%e.g., try cluster grid 7x7 or 6x6
%but 8x8 is also allowed, e.g. to match number of input "fibers" to output "fibers" to discover
%coherence mapping
nclustrows=6; % specify cluster grid dimensions
nclustcols=6; %
%seed all clusters with random values, then normalize resulting cluster
%feature vecs
clusters = random('unid',100,[nclustrows,nclustcols,vecdim]);

%now normalize the feature vecs:
%note--may extract a vector from a 3-D matrix with:
%vec=squeeze(clusters(i,j,:))
for row = 1:nclustrows
    for col = 1:nclustcols
        clusters(row,col,:)=clusters(row,col,:)./norm(squeeze(clusters(row,col,:)));
    end
end

%convert all matrix patterns to pattern vectors
scrambled_vecs = zeros(npats,vecdim); %fill this matrix with vector versions of training patterns

for (ipat=1:npats)
    temp=pat2vec(squeeze(scrambled_blobs(ipat,:,:)));
    temp=temp/norm(temp); %normalize each training pattern
    scrambled_vecs(ipat,:)=temp;
end

eval_test_patterns; %script to view decoding of 3 test patterns, I, H and X
%at this point, I, H and X will be unrecognizable 

%Now, train the clusters.
%draw from input pattern vector pool at random--
%find closest cluster, which is indexed by ibest, jbest  
%update both the best-fit cluster as well as its neighbors
%neighborhood operator should shrink over time to influence fewer neighbors
%max influence of a training pattern may also decrease over time

time=0;
display_counter=0;
while (time<100000)  %set as infinite loop (and halt w/ control-C); or,  put cap on "time" for max iterations
    time=time+1;
    display_counter=display_counter+1;
    ipat=ceil(rand*npats); %pick a pattern at random
    testvec= squeeze(scrambled_vecs(ipat,:)); %extract the corresponding row vector
 
    %for the selected pattern, find which cluster is most similar.
    %Identify this cluster in terms of its grid location, ictr,jctr
    [ictr,jctr]=find_closest_cluster(testvec,clusters);
   
    %update the identified cluster and its neighbors:
    for i=1:nclustrows
        for j=1:nclustcols
            [alpha,radius] = alphafnc(i,j,ictr,jctr,time);
            testvecsize = size(testvec);
            clustervecsize = size(squeeze(clusters(i,j,:)));
            clusters(i,j,:) = squeeze(clusters(i,j,:)) + alpha * (testvec'-squeeze(clusters(i,j,:)));
            clusters(i,j,:)=clusters(i,j,:)./norm(squeeze(clusters(i,j,:)));
        end
    end
    %review results after each 1000 pattern updates
    if (display_counter>1000)
        time %display time for this batch
        [alpha,radius]=alphafnc(4,4,4,4,time) %report alpha and radius at this time
        %are clusters performing decoding?  Check cluster responses to I, H
        %and X scrambled test patterns
        view_all_pattern_responses(scrambled_vecs,clusters);
        eval_test_patterns
      display_counter=0;
      save('clusters','clusters'); %save cluster results to file clusters.mat
    end
end



