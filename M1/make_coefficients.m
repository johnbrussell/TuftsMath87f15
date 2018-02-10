function [coefficients, flow_limits] = make_coefficients ()
    cost_vector = make_cost_vector();
    num_points = sqrt(length(cost_vector));
    max_flow = make_max_flow();
    min_flow = make_min_flow();
    
    A = [];
    b = [];
    
    % Control for maximum flow between any two points
    seen = [];
    
    for i = 1:size(max_flow)[1]
        temp = zeros(1, num_points*num_points);
        temp((max_flow(i,1)-1)*num_points+max_flow(i,2)) = 1;
        seen = [seen ((max_flow(i,1)-1)*num_points+max_flow(i,2))];
        A = [A; temp];
        b = [b; max_flow(i, 3)];
    end
    
    seen = sort(seen);
    counter = 1;
    
    for i = 1:(num_points*num_points)
        if counter <= length(seen)
            if i == seen(counter)
                counter = counter + 1;
                continue;
            end
        end
        temp = zeros(1, num_points*num_points);
        temp(i) = 1;
        A = [A; temp];
        b = [b; 0];
    end

    % Control for minimum flow between any two points 
    seen = [];
    
    for i = 1:size(min_flow)[1]
        temp = zeros(1, num_points*num_points);
        temp((min_flow(i,1)-1)*num_points+min_flow(i,2)) = -1;
        seen = [seen ((min_flow(i,1)-1)*num_points+min_flow(i,2))];
        A = [A; temp];
        b = [b; (-1)*min_flow(i,3)];
    end
    
    seen = sort(seen);
    counter = 1;
    
    for i = 1:(num_points*num_points)
        if counter <= length(seen)
            if i == seen(counter)
                counter = counter + 1;
                continue;
            end
        end
    
        temp = zeros(1, num_points*num_points);
        temp(i) = -1;
        A = [A; temp];
        b = [b; 0];
    end
    
    % Add conservation of mass
    
    for i = 2:(num_points - 1)
        temp = zeros(1, num_points*num_points);
        for j = 1:num_points
            temp((i-1)*num_points+j) = 1;
        end
        for j = 1:num_points
            temp((j-1)*num_points+i) = -1;
        end
        
        A = [A; temp];
        b = [b; 0];
        
        temp = temp * (-1);
        
        A = [A; temp];
        b = [b; 0];        
    end
    
    coefficients = A;
    flow_limits = b;
end