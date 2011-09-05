%remove_pattern_from_cluster.m  YOU NEED TO WRITE THIS
%MAY EMULATE put_pattern_into_cluster
%operates on indices current_cluster and ipat
%affects pattern_assignments,
%cluster_rosters, 
%cluster_populations
%cluster_attributes 
%cluster_centroids

%unassign if and only if pattern is currently assigned
%or need to change assignment

current_cluster=pattern_assignments(ipat)
if (current_cluster>0) %remove only if currently assigned
    pattern_assignments(ipat)=0; %unassign pattern ipat from any cluster
    %FINISH THIS...
    %UPDATE ASSOCIATED CLUSTER POPULATION, CLUSTER ATTRIBUTE and 
    %CLUSTER CENTROID
 
    cluster_rosters(current_cluster,ipat)=0; %remove this pattern from the current_cluster's roster
 end  %end if--which may complete addition to this cluster