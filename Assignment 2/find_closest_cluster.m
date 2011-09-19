%function find_closest_cluster()
%given row vector invec, find which cluster feature vec is most similar
%NEED TO EDIT THIS
function [best_row,best_col]=find_closest_cluster(invec,clusters)

temp = size(clusters);
nrows=temp(1);
ncols=temp(2);
best_row = 1;
best_col = 1;
best_sim = calc_sim(invec,squeeze(clusters(best_row, best_col, :)));
for row = 1:nrows
    for col = 1:ncols
        sim = calc_sim(invec, squeeze(clusters(row, col, :)));
        if(sim > best_sim)
            best_row = row;
            best_col = col;
            best_sim = sim;
        end
    end
end