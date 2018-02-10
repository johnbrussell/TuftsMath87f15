function [M] = create_flow_matrix(vector)
    num_points = sqrt(length(vector));
    M = [];
    for i=1:num_points
        temp = [];
        for j=1:num_points
            if abs(vector((i-1)*num_points+j) > .00001)
                temp = [temp vector((i-1)*num_points+j)];
            else
                temp = [temp 0];
            end
        end
        M = [M; temp];
    end
end
