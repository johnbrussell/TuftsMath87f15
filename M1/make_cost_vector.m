function [cost_vector] = make_cost_vector ()
    num_points = 10;
    constraint_list = make_cost_list();
    cost_vector = zeros(1, num_points*num_points);
    for i = 1:size(constraint_list)[1]
        cost_vector((constraint_list(i,1) - 1)*num_points+constraint_list(i,2))=constraint_list(i,3);
    end   
end