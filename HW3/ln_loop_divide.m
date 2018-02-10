function [ dm ] = ln_loop_divide( tm, vals_tested, equitable_range )
    maxtest = sqrt(vals_tested)-2; 
    if maxtest < 0
        disp('bad vals_tested, increase value');
    end
    count1 = 0;
    count2 = 0;
    
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

    % Test for a value of the equitable region that is incompatible with 
    %  the given value number of comparisons requested.
    if vals_tested < ((log(equitable_range/4)/log(3/4)) + 2)^2
        disp('Solution might not be equitable or pareto optimal.');
        disp('Increase value of vals_tested or increase value of'); 
        disp('equitable_range to make equitable and pareto optimal.');
    end

    % Initialize variables.  Will need left, center, right, and new 
    %  values for both d1 and d2.  Will also need to know whether to 
    %  put the new value on the left or right of center.
    d1_left = 0;
    d2_left = 0;
    d1_right = 1;
    d2_right = 1;
    d1_center = 0.5;
    d2_center = 0.5;
    d1_new = 0;
    d2_new = 0;
    d1_l = 1;
    d2_l = 1;

    % Initialize the minimax values
    d1_center_value = 0;
    d1_new_value = 0;

    % We need to find the optimal value of d1_center when it is at 0.5.
    % The first while loop does this.
    
    % Calculate the known value of d2_center based on d1_center = 0.5
    d2_center_value = min(d1_center*tm(1,1) + d2_center*tm(1,2), tm(2,1)*(1-d1_center) + tm(2,2)*(1-d2_center)); 
    while count2 < maxtest
        count2 = count2 + 1;
        if d2_l == 1
            d2_new = (d2_center + d2_left) / 2;
        else 
            d2_new = (d2_center + d2_right) / 2;
        end
        
        % Calculate the value of d2_new based on the value of d1_center
        d2_new_value = min(d1_center*tm(1,1) + d2_new*tm(1,2), tm(2,1)*(1-d1_center) + tm(2,2)*(1-d2_new));

        % We now know the value of d2_new and d2_center.  If they are very
        % close, there is no point in continuing.
        if abs(d2_center_value - d2_new_value) < equitable_range/40
            count2 = maxtest;
        end

        % We can determine where the optimal values of the function are
        % relative to the values we know based on which is greater. 
        if d2_center_value > d2_new_value
            if d2_l == 1
                d2_left = d2_new;
                d2_l = 0;
            else
                d2_right = d2_new;
                d2_l = 1;
            end
        else
            if d2_l == 1
                d2_right = d2_center;
            else
                d2_left = d2_center;
                d2_l = 1;
            end
            d2_center = d2_new;
            d2_center_value = d2_new_value;
        end
    end


    % At the end of the loop, we know what the optimal value of the
    % function is for d1_center = 0.5.  Record this value.
    d1_center_value = d2_center_value;

    % Reinitialize everything.
    d2_center_value = 0;
    d1_left = 0;
    d2_left = 0;
    d1_right = 1;
    d2_right = 1;
    d1_center = 0.5;
    d2_center = 0.5;
    d1_new = 0;
    d2_new = 0;
    d1_l = 1;
    d2_l = 1;
    
    % Now we can do the same process repeatedly.
    % This loop finds the best value of d1 by repeated division of the
    %  interval into parts.  Each iteration at least 1/4 of the interval is
    %  eliminatd from consideration.
    while count1 < maxtest
        count1 = count1 + 1;
        if d1_l == 1
            d1_new = (d1_center + d1_left) / 2;
        else 
            d1_new = (d1_center + d1_right) / 2;
        end

        % Initialize values for the inner loop used to calculate the
        %  optimal value of d1_new
        count2 = 0;
        d2_left = 0;
        d2_center = 0.5;
        d2_right = 1;
        d2_center_value = min(d1_new*tm(1,1) + d2_center*tm(1,2), tm(2,1)*(1-d1_new) + tm(2,2)*(1-d2_center));
        % This inner loop is exactly the same as the loop above except it
        %  calculates values for d1_new_value instead of d1_center_value.
        %  A function would make this more readable, but for the sake of
        %  keeping everything in one file I did not use one.
        while count2 < maxtest
            count2 = count2 + 1;
            if d2_l == 1
                d2_new = (d2_center + d2_left) / 2;
            else 
                d2_new = (d2_center + d2_right) / 2;
            end
            d2_new_value = min(d1_new*tm(1,1) + d2_new*tm(1,2), tm(2,1)*(1-d1_new) + tm(2,2)*(1-d2_new));
        
            if abs(d2_center_value - d2_new_value) < equitable_range/40 
                count2 = maxtest;
            end
               
            if d2_center_value > d2_new_value
                if d2_l == 1
                    d2_left = d2_new;
                    d2_l = 0;
                else
                    d2_right = d2_new;
                    d2_l = 1;
                end
            else
                if d2_l == 1
                    d2_right = d2_center;
                else
                    d2_left = d2_center;
                    d2_l = 1;
                end
                d2_center = d2_new;
                d2_center_value = d2_new_value;
            end
        end
        d1_new_value = d2_center_value;
           
        if abs(d1_center_value - d1_new_value) < equitable_range/40
            count1 = maxtest;
        end

        if d1_center_value > d1_new_value
            if d1_l == 1
                d1_left = d1_new;
                d1_l = 0;
            else
                d1_right = d1_new;
                d1_l = 1;
            end
        else
            if d1_l == 1
                d1_right = d1_center;
            else
                d1_left = d1_center;
                d1_l = 1;
            end
            d1_center = d1_new;
            d1_center_value = d1_new_value;
        end
    end

    % This final loop is used to ensure that the value of d2_center that is
    %  returned is in fact the optimal d2_center for the d1 that will be 
    %  returned.  (As opposed to the optimal center for the last value of
    %  d1_new.  Of course, these values are extremely close, but I figure
    %  it would be better to make sure the answer is as right as possible).
    count2 = 0;
    d2_left = 0;
    d2_center = 0.5;
    d2_right = 1;
    d2_center_value = min(d1_center*tm(1,1) + d2_center*tm(1,2), tm(2,1)*(1-d1_center) + tm(2,2)*(1-d2_center)); 
    while count2 < maxtest
        count2 = count2 + 1;
        if d2_l == 1
            d2_new = (d2_center + d2_left) / 2;
        else 
            d2_new = (d2_center + d2_right) / 2;
        end
        
        % Calculate the value of d2_new based on the value of d1_center
        d2_new_value = min(d1_center*tm(1,1) + d2_new*tm(1,2), tm(2,1)*(1-d1_center) + tm(2,2)*(1-d2_new));

        % We now know the value of d2_new and d2_center.  If they are very
        % close, there is no point in continuing.
        if abs(d2_center_value - d2_new_value) < equitable_range/40
            count2 = maxtest;
        end

        % We can determine where the optimal values of the function are
        % relative to the values we know based on which is greater.  
        if d2_center_value > d2_new_value
            if d2_l == 1
                d2_left = d2_new;
                d2_l = 0;
            else
                d2_right = d2_new;
                d2_l = 1;
            end
        else
            if d2_l == 1
                d2_right = d2_center;
            else
                d2_left = d2_center;
                d2_l = 1;
            end
            d2_center = d2_new;
            d2_center_value = d2_new_value;
        end
    end
    
    dm = [d1_center d2_center; (1-d1_center) (1-d2_center)];
    
end