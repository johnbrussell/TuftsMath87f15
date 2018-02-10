function [ dm ] = loop_divide( tm, vals_tested, equitable_range )
    interval = 1/sqrt(vals_tested); % Amount by which to increment d1 or d2
    if interval < 0
        print('bad vals_tested; increase value');
    end
    dm = [0 0; 0 0]; % division matrix
    minimax = 0; % Optimal value of min(v11, v22)
    difference = 1; % Difference between v11, v22 for that optimal value
    initial_add = 0; % See note below
    initial_interval = 0; % See note below
    
    % Check to ensure that the taste matrix contains no values that 
    %  are 0 or 1.  If it does, adjust the value by the largest equitable 
    %  amount.  This allows the program to find (max(min(v11,v22)) and 
    %  return that division as a Pareto-optimal and equitable division.
    for i = 1:2
        if tm(i,1) == 0
            tm(i,1) = equitable_range;
            tm(i,2) = 1 - equitable_range;
        elseif tm(i,1) == 1
            tm(i,1) = 1 - equitable_range;
            tm(i,2) = equitable_range;
        end
    end
    
    % These are the loops asked for in the problem.  The first one will 
    %  hopefully only run once, but will run more than once if the 
    %  problem as specified by the user fails to yield a solution.  
    % The second and third loops adjust d1 and d2, respectively.
    while(difference > equitable_range)
        dm = [0 0; 0 0]; % division matrix
        minimax = 0; % Optimal value of min(v11, v22)
        difference = 1;
        d1 = initial_add;
        while(d1 < 1)
            d2 = initial_add;
            while(d2 < 1)
                v11 = tm(1,1) * d1 + tm(1,2) * d2;
                v22 = tm(2,1) * (1-d1) + tm(2,2) * (1-d2);
                if(v11 > minimax && v22 > minimax)
                    dm = [d1 d2; (1-d1) (1-d2)];
                    difference = abs(v11 - v22);
                    if(v11 > v22)
                        minimax = v22;
                    else 
                        minimax = v11;
                    end
                end
                d2 = d2 + interval;
            end
            d1 = d1 + interval;
        end

        % This section of code to the end of the function deals with the 
        %  case in which the user specifies a number of d1/d2 values to 
        %  check and a range that is considered "equitable" in such a 
        %  manner that the optimal d1/d2 pair checked is not equitable.
        % 
        % The way I will deal with this situation is to do exactly the 
        %  same search, but instead shifted slightly so that instead of 
        %  starting at d1=d2=0, it will start where d1=d2= some number 
        %  called "initial_add".  initial_add will be a value that is 
        %  between 0 and interval, which is the amount to increment d1 or
        %  d2 as directly calculated from the number of tests to do, which
        %  is specified by the user.  For each iteration of the outer loop,
        %  the value of initial_add will be changed by an amount called
        %  "initial_interval", which is defined by the amount by which to 
        %  increment d1/d2 * the equitable_range / the difference between 
        %  v11 and v22 at the optimal point.  The outer loop of the three 
        %  loops will not terminate until the function has found a value 
        %  for d1 and d2 that is equitable as specified by the user.  Each
        %  time the loop runs, it will do no more searches than the user
        %  specifies.  
        if initial_interval == 0
            initial_interval = interval*equitable_range/difference;
        end
        initial_add = initial_add + initial_interval;
        if initial_add >= interval
            initial_interval = initial_interval / 2;
            initial_add = initial_interval;
        end
    end
end