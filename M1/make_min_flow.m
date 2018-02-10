function [min_flow] = make_min_flow()
    min_flow = [1 2 200;
                1 3 200;
                1 4 700;
                5 10 150;
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
%  [From_city  To_city  Min_flow]

% All nonzero minimum flows MUST be included in this matrix.
%  Order is not important.