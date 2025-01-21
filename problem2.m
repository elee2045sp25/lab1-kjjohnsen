% Load the cuts data
cuts = readtable('cuts.csv');

% Initialize variables
last_x = cuts{1, 1};
last_y = cuts{1, 2};
total_cut_distance = 0;
total_travel_distance = 0;

% Initialize bounds for padding
min_x = inf;
max_x = -inf;
min_y = inf;
max_y = -inf;

% Iterate over each row in the table
for index = 1:height(cuts)
    % Get the current row
    row = cuts(index, :);

    % Calculate the cutting distance for the current segment
    cut_distance = sqrt((row.x2 - row.x1)^2 + (row.y2 - row.y1)^2);

    % Calculate the travel distance to the start of the current segment
    travel_distance = sqrt((row.x1 - last_x)^2 + (row.y1 - last_y)^2);

    % Update total distances
    total_cut_distance = total_cut_distance + cut_distance;
    total_travel_distance = total_travel_distance + travel_distance;

    % Update the last position
    last_x = row.x2;
    last_y = row.y2;

    % Update bounds for padding
    min_x = min([min_x, row.x1, row.x2]);
    max_x = max([max_x, row.x1, row.x2]);
    min_y = min([min_y, row.y1, row.y2]);
    max_y = max([max_y, row.y1, row.y2]);

    % Plot the current cut segment
    plot([row.x1, row.x2], [row.y1, row.y2]);
    hold on;
end

% Add 1-unit padding (so we can see all of the cuts)
xlim([min_x - 1, max_x + 1]);
ylim([min_y - 1, max_y + 1]);

% Display the plot
hold off;

% Calculate total distance and efficiency
total_distance = total_cut_distance + total_travel_distance;
efficiency = (total_cut_distance / total_distance) * 100;

% Print the efficiency and distances
fprintf('%.2f%% efficiency, %.2f units cut, %.2f traveled.\n', ...
        efficiency, total_cut_distance, total_distance);
