%put_pattern_into_cluster.m NO CHANGES REQUIRED
%operates on indices closestClust and ipat
%affects pattern_assignments,
%cluster_rosters, 
%cluster_populations
%cluster_attributes 
%cluster_centroids

%do this only if current assignment of pattern ipat is to cluster 0-->
%either this pattern was not yet assigned, or it was recently unassigned
%in preparation for reassignment
if (pattern_assignments(ipat)==0) %only add if current pattern is not assigned (e.g. recently removed)
    pattern_assignments(ipat)=closestClust; %assign pattern ipat to cluster closestClust
    newpop=cluster_populations(closestClust)+1;
    cluster_populations(closestClust)=newpop;
    old_attribute=cluster_attributes(closestClust);
    new_attribute=attributes(ipat); %attribute value of pattern ipat
    cluster_attributes(closestClust)=old_attribute*(newpop-1)/newpop+new_attribute/newpop;
    cluster_centroids(closestClust,:)=cluster_centroids(closestClust,:)*(newpop-1)/newpop+feature_scaled_vals(ipat,:)/newpop; %include influence of weighted avg of new pattern features
    cluster_rosters(closestClust,ipat)=1; %record that ipat is a member of cluster closestCluster
 end  %end if--which may complete addition to this cluster
