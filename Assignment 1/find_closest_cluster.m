%find_closest_cluster.m  EDIT THIS
%given assigned value for ipat, cycle through all clusters and find which
%cluster is closest to ipat.  Resulting cluster index is set in  closestClust

%Iterate through clusters, calculating euclidean distance of centroids.
%The cluster whose centroid has the smallest Euclidean distance is the 
%   closest cluster.
best_dist = -1;
pattern = feature_scaled_vals(ipat,:);

for clust = 1:nclusters
   centroid = cluster_centroids(clust,:);
   dist = pdist([centroid; pattern], 'euclidean');
   if best_dist<0 || best_dist>dist
       closestClust = clust;
       best_dist = dist;
   end
end
%closestClust=random('unid',nclusters);  %DO SOMETHING SMARTER THAN THIS!
