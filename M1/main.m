cost_vector = make_cost_vector();
[A, b] = make_coefficients();
[cost_vector, A, b] = adjust(cost_vector, A, b, 5);
flow = linprog(cost_vector, A, b);
total_cost = cost_vector * flow;
flow_matrix = create_flow_matrix(flow);