function [ cluster_rosters ] = k_means_seed_clusters( n_clusters, n_patterns)
%Creates a cluster roster and randomly seeds it

cluster_rosters = zeros(n_clusters, n_patterns);
pat_list = zeros(n_clusters, 1);
for icluster=1:n_clusters
    %Randomly choose a pattern
    ipat = random('unid',n_patterns);
    %If the pattern is already in a cluster, try again
    while ~isempty(find(pat_list==ipat ))
        ipat = random('unid',n_patterns);
    end
    %Add the chosen pattern to the list of chosen patterns
    pat_list(icluster) = ipat;
    %Add the pattern to the cluster roster
    cluster_rosters(icluster, ipat) = 1;
end
end