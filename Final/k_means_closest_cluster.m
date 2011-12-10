function [ closest_cluster_index ] = k_means_closest_cluster(pattern, cluster_centroids)
%Find the closest cluster using the Euclidean distance

[n_clusters, ~] = size(cluster_centroids);
closest_cluster_index = 1;
closest_cluster_distance = Inf;
for i=1:n_clusters
    cluster_distance = pdist([pattern; cluster_centroids(i,:)], 'euclidean');
    if(cluster_distance<closest_cluster_distance)
        closest_cluster_index = i;
        closest_cluster_distance = cluster_distance;
    end
end
end