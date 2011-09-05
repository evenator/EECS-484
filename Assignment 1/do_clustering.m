%do_clustering.m  NO CHANGES REQUIRED
%call reassign_patterns until stable or until max number of iterations
 
nchanges=1;
num_passes=0;
while((nchanges>0) && (num_passes<max_passes))
    
  %reassign_patterns--sweeps through all patterns and returns number of
  %reassigned patterns
  %affects pattern_membership, cluster_members and cluster_properties
  %changes pattern membership of ipat to cluster zero; 
  %decrements number of members of cluster jclust; 
  %adjusts centroid of features and avg attribute value of cluster jclust 

    nchanges=0;
    reassign_patterns
    nchanges
    num_passes=num_passes+1
    cluster_centroids  %these statements merely echo the values in these variables--
    cluster_attributes  %useful for debugging and interpretation of results
    cluster_populations
    
end

   




