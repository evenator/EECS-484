function [ cluster_roster ] = k_means_cluster( cluster_roster, patterns )
%Reassigns patterns to clusters based on distance from centroid

[n_clusters, n_patterns] = size(cluster_roster);
[~, feature_length] = size(patterns);
cluster_centroids = zeros(n_clusters, feature_length);

%Calculate Cluster Centroids
for i = 1:n_clusters
    cluster_centroids(i,:) = k_means_cluster_centroid(cluster_roster(i,:),patterns);
end

for i = 1:n_patterns
    %Reassign this pattern
    cluster_index = k_means_closest_cluster(patterns(i,:), cluster_centroids);
    cluster_roster(:,i) = zeros(n_clusters, 1);
    cluster_roster(cluster_index, i) = 1;
    if cluster_index ~= find(cluster_roster(:,i))
        disp('error')
    end
    %Recalculate Cluster Centroid
    cluster_centroids(cluster_index, :) = k_means_cluster_centroid(cluster_roster(cluster_index,:),patterns);
    
end
end

