function [flow_matrix] = make_max_flow()
    flow_matrix = [1 2 200;
                   1 3 200;
                   1 4 700;
                   2 5 200;
                   2 6 200;
                   2 8 200;
                   3 5 200;
                   3 6 200;
                   3 7 200;
                   4 5 200;
                   4 6 200;
                   4 8 200;
                   4 9 200;
                   5 6 200;
                   5 7 200;
                   5 9 200;
                   5 10 150;
                   6 5 200;
                   6 7 200;
                   6 8 200;
                   6 9 200;
                   6 10 300;
                   7 10 250;
                   8 10 200;
                   9 10 200]
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

% Each row in the flow matrix is: 
%  [From_city  To_city  Max_flow]

% All nonzero maximum flows MUST be included in this matrix.
%  Order is not important.