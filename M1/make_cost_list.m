function [cost_matrix] = make_cost_list()
    cost_matrix = [2 5 5; 
                   2 6 2;
                   2 8 7;
                   3 5 4;
                   3 6 6; 
                   3 7 7;
                   4 5 7;
                   4 6 3; 
                   4 8 3;
                   4 9 6;
                   5 6 2;
                   5 7 5;
                   5 9 4;
                   6 5 2; 
                   6 7 6;
                   6 8 5;
                   6 9 4]
end

% Some notes: nodes are defined as follows: 
%  1 = source
%  2 = El Paso
%  3 = Tampa Bay
%  4 = Santa Fe
%  5 = Atlanta
%  6 = Houston
%  7 = New York
%  8 = Los Angeles
%  9 = Chicago
%  10 = sink

% Each row in the cost matrix is: 
%  [From_city  To_city  Cost]

% All nonzero transport costs MUST be included in this matrix.
%  Order is not important.