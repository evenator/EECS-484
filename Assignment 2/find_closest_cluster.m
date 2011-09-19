%function find_closest_cluster()
%given row vector invec, find which cluster feature vec is most similar
%NEED TO EDIT THIS
function [ibest,jbest]=find_closest_cluster(invec,clusters)

temp = size(clusters);
nrows=temp(1);
ncols=temp(2);
ibest=1;
jbest=1;
test_clust=squeeze(clusters(ibest,jbest,:)); %extract a feature vector from the array of clusters
%COMPARE "INVEC" TO ALL CLUSTER VECS--FIND BEST MATCH (SIMILARLITY) AND ASSIGN 
%CORRESPONDING CLUSTER INDICES IBEST,JBEST


        