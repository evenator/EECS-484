max_nodes = 100;
eps_step = .001;
results = zeros(ceil(2 / eps_step), 4);
iterations = 10;

row_count = 1;
time_temp = zeros(iterations,1);
success_temp = zeros(iterations,1);

for node_count = 2:max_nodes
    for eps = (-1/(node_count-1)):eps_step:-eps_step
        for i = 1:iterations
            auto_maxnet;
            time_temp(i) = time;
            success_temp(i) = length(max_node);
        end
        %auto_maxnet;
        %success = length(max_node);
        time = mean(time_temp);
        success = max(success_temp);
        results(row_count,:) = [eps, node_count, time, length(max_node)];
        row_count = row_count + 1;
    end
end

xlswrite('results.xls',results);