%seed_clusters.m  EDIT THIS TO RANDOMIZE SEED VALUES FOR ALL CLUSTERS
%uses training_data members to initialize clusters
%affects pattern_assignments,
%cluster_rosters, 
%cluster_populations
%cluster_attributes 
%cluster_centroids

%pick a random pattern number:
for icluster=1:nclusters
     ipat=icluster; %POOR CHOICE--NEED TO RANDOMIZE SEED VALUES
 
            pattern_assignments(ipat)=icluster; %assign this pattern to belong to icluster
            cluster_populations(icluster)=1; %this cluster now has one pattern
            cluster_attributes(icluster)=attributes(ipat); %save the attribute value verbatim
            cluster_centroids(icluster,:)=feature_scaled_vals(ipat,:); %copy sclaed feature values = centroid for single member
            cluster_rosters(icluster,ipat)=1; %put tick in this cluster/pattern correspondence

end %end for--complete the initialization for every cluster
%summarize seed results:
cluster_populations
cluster_attributes
cluster_centroids
%suspend execution here until user presses "enter"
dummy=input ('done seeding; enter <CR> to continue');
        
   

