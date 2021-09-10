function response = truncate(data, threshold)
    truncated_data = [];
    for index = 1:length(data)
        if data(index) >= threshold;
            truncated_data = [truncated_data 1];
        else
            truncated_data = [truncated_data 0];
        end
    end
    response = truncated_data';
end
