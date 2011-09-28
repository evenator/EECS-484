max_nodes = 100;
eps_step = .001;
results = zeros(ceil(2 / eps_step), 4);

row_count = 1;

for node_count = 2:max_nodes
    for eps = (-1/node_count):eps_step:-eps_step
        auto_maxnet;
        results(row_count,:) = [eps, node_count, time, length(max_node)];
        row_count = row_count + 1;
    end
end

xlswrite('results.xls',results);