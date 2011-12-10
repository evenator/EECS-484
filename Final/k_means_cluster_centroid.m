function [ centroid ] = k_means_cluster_centroid( cluster, patterns )
%Calculates the centroid of the cluster listed in cluster
    cluster_members = cluster==1;
    [~, feature_length] = size(patterns);
    if(sum(cluster_members)>0)
        centroid = mean(patterns(cluster_members,:),1);
    else
        centroid = zeros(1, feature_length);
    end
end

