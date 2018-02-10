function [cost_vector, A, b] = adjust(cost_vector, A, b, type)
    num_points = sqrt(length(cost_vector));
    % Shipping costs to LA double
    if type == 1
        for i = 1:num_points
            cost_vector((i-1)*num_points + 8) = cost_vector((i-1)*num_points + 8) * 2;
        end
    end

    % Capacity on all shipping routes to LA is less than or equal to 100
    if type == 2
        for i = 1:num_points
            temp = zeros(1, num_points*num_points);
            temp((i-1)*num_points + 8) = 1;
            A = [A; temp];
            b = [b; 100];
        end
    end
    
    % Shipping costs to/from Houston double
    if type == 3
        for i = 1:num_points
            cost_vector((i-1)*num_points + 6) = cost_vector((i-1)*num_points + 6) * 2;
            cost_vector((6-1)*num_points + i) = cost_vector((6-1)*num_points + i) * 2;
        end
    end
    
    % Shipping capacity to/from Houston capped at 100
    if type == 4
        for i = 1:num_points
            temp = zeros(1, num_points*num_points);
            temp((i-1)*num_points + 6) = 1;
            A = [A; temp];
            b = [b; 100];
            
            if i < 10
                temp = zeros(1, num_points*num_points);
                temp((6-1)*num_points + i) = 1;
                A = [A; temp];
                b = [b; 100];
            end
        end
    end
    
    % Add in cost to produce and sell
    if type == 5
        cost_vector(4) = 8;
        cost_vector(2) = 5;
        cost_vector(3) = 10;
        cost_vector(90) = -15;
        cost_vector(70) = -25;
        cost_vector(60) = -10;
        cost_vector(50) = -10;
        cost_vector(80) = -20;
    end
end
