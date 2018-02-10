function [profit, lost_cust, spaced_out, perished, targets, sold] = perishable(demand, storage_space, wait_time, lifespan, markup, sell)

num_days = 56;

%Constants
gross_profit = [markup(1)*sell(1) markup(2)*sell(2) markup(3)*sell(3)];
cost = sell - gross_profit;
%disp(gross_profit);
size = [4 16 3];
square_feet = [1/4 1/48 1/9];
profit_sf = [gross_profit(1)/square_feet(1) gross_profit(2)/square_feet(2) gross_profit(3)/square_feet(3)];
best = [0 0 0];

for i=1:3
    if profit_sf(i) > best(1)
        best(3) = best(2);
        best(2) = best(1);
        best(1) = i;
    elseif profit_sf(i) > best(2)
        best(3) = best(2);
        best(2) = i;
    else best(3) = i;
    end
end
placeholder = best(1);
best(1) = best(3);
best(3) = placeholder;

%Cumulatives 
lost = [0 0 0];
targets = [round(demand(1)/2)+1 round(demand(2)/2)+1 round(demand(3)/2)+1];
ftargets = targets;
profit = [0 0 0];
done = [0 0 0];
thrown = [0 0 0];
spaced_out = [0 0 0];
sold = [0 0 0];

% Initial inventory & order status
stock = [0 0 0];
lost_sim = lost;
lost_sim_prev = lost_sim;
thrown_sim = thrown;
thrown_sim_prev = thrown_sim;
spaced_out_sim = spaced_out;
spaced_out_sim_prev = spaced_out_sim;
deliveries = zeros(3,num_days+max(wait_time));
profit_sim = profit;
profit_sim_prev = profit_sim;
sold_sim = sold;
sold_sim_prev = sold_sim;
deviation = targets - stock;
age = zeros(3, max(lifespan));
space_used = 0;
customers = [0 0 0];
toOrder = [0 0 0];


while sum(done) < 3  
    stock = [0 0 0];
    deliveries = zeros(3, num_days+max(wait_time));
    deviation = targets - stock;
    age = zeros(3, max(lifespan));
    storage1 = [deliveries(1,1) deliveries(2,1) deliveries(3,1)];
    storage2 = storage1;

    for i=1:num_days
        %Get deliveries
        stock = stock + [deliveries(1,i) deliveries(2,i) deliveries(3,i)];
        
        %Adjust age of inventory
        storage1 = [deliveries(1,i) deliveries(2,i) deliveries(3,i)];
        for j=1:max(lifespan)
            storage2 = [age(1,j) age(2,j) age(3,j)];
            age(1,j) = storage1(1); age(2,j) = storage1(2); age(3,j) = storage1(3);
            storage1 = storage2;
        end
        %Remove inventory that has perished
        for k = 1:3
            if age(k,lifespan(k)) > 0
                if(lifespan(k) < max(lifespan))
                    thrown_sim(k) = thrown_sim(k) + age(k, lifespan(k)+1);
                    stock(k) = stock(k) - age(k, lifespan(k)+1);
                    age(k,lifespan(k)+1) = 0;
                else
                    thrown_sim(k) = thrown_sim(k) + storage2(k);
                    stock(k) = stock(k) - storage2(k);
                end
            end
        end
        %Remove inventory that takes up too much storage space
        if storage_space >= 0
            space_used = dot(stock, square_feet);
            while space_used > storage_space
                if stock(best(1)) > 0
                    stock(best(1)) = stock(best(1)) - 1;
                    for k=1:lifespan(best(1))
                        if age(best(1), lifespan(best(1))-k+1) > 0
                            age(best(1), lifespan(best(1))-k+1) = age(best(1), lifespan(best(1))-k+1) - 1;
                            spaced_out_sim(best(1)) = spaced_out_sim(best(1)) + 1;
                            break;
                        end
                    end
                elseif stock(best(2)) > 0
                    stock(best(2)) = stock(best(2)) - 1;
                    for k=1:lifespan(best(2))
                        if age(best(2), lifespan(best(2))-k+1) > 0
                            spaced_out_sim(best(2)) = spaced_out_sim(best(2)) + 1;
                            age(best(2), lifespan(best(2))-k+1) = age(best(2), lifespan(best(2))-k+1) - 1;
                            break;
                        end
                    end
                else 
                    stock(best(3)) = stock(best(3)) - 1;
                    for k=1:lifespan(best(3))
                        if age(best(3), lifespan(best(3))-k+1) > 0
                            spaced_out_sim(best(3)) = spaced_out_sim(best(3)) + 1;
                            age(best(3), lifespan(best(3))-k+1) = age(best(3), lifespan(best(3))-k+1) - 1;
                            break;
                        end
                    end
                end
                space_used = dot(stock, square_feet);
            end
        end
        
        % Sell goods up to demand 
        customers = [poissrnd(demand(1)) poissrnd(demand(2)) poissrnd(demand(3))];
        for k=1:3
            if customers(k) >= stock(k)
                % Count number of customers lost due to insufficient goods
                if i > wait_time(k)
                    lost_sim(k) = customers(k) - stock(k);
                end
                for j=1:max(lifespan)
                    age(k, j) = 0;
                end
                % Count profit from the goods that were sold
                profit_sim(k) = profit_sim(k) + stock(k) * gross_profit(k);
                sold_sim(k) = sold_sim(k) + stock(k);
                stock(k) = 0;
            else
                % Sell goods FIFO; count profit then adjust stock and ages
                profit_sim(k) = profit_sim(k) + customers(k) * gross_profit(k);
                
                while customers(k) > 0
                    for j=1:lifespan(k)
                        if(age(k, lifespan(k)-j+1) > 0)
                            age(k, lifespan(k)-j+1) = age(k, lifespan(k)-j+1) - 1;
                            break;
                        end
                    end
                    customers(k) = customers(k) - 1;
                    stock(k) = stock(k) - 1;
                    sold_sim(k) = sold_sim(k) + 1;
                end         
            end
        end
        
        % Order inventory to bring what you have back up to the target
        deviation = targets - stock;
        for j = 1:3
            toOrder(j) = max(round(deviation(j) / size(j)) * size(j), 0);
            deliveries(j, i+wait_time(j)) = deliveries(j, i+wait_time(j)) + toOrder(j);
        end
    end
    
    for i=1:3    
        % Adjust profit figure to account for perished and overstocked
        % inventory
        profit_sim(i) = profit_sim(i) - cost(i) * (spaced_out_sim(i) + thrown_sim(i));
        
        if(done(i) < 1) 
            targets(i) = targets(i) + 1;
        else
            targets(i) = ftargets(i) + 1;
        end
        
        % If we have reached a local maximum
        if profit_sim(i) < profit_sim_prev(i)
            if done(i) < 1
                % Check to make sure we have searched enough
                if targets(i) > 1.5*demand(i)
                    done(i) = 1;
                end
                if profit_sim_prev(i) > profit(i) % If it is the best max found so far
                    profit(i) = profit_sim_prev(i);
                    lost(i) = lost_sim_prev(i);
                    thrown(i) = thrown_sim_prev(i);
                    spaced_out(i) = spaced_out_sim_prev(i);
                    sold(i) = sold_sim_prev(i);
                    ftargets(i) = targets(i) - 2;
                end
                % Advance the profit figures
                profit_sim_prev(i) = profit_sim(i);
                lost_sim_prev(i) = lost_sim(i);
                thrown_sim_prev(i) = thrown_sim(i);
                spaced_out_sim_prev(i) = spaced_out_sim(i);
                sold_sim_prev(i) = sold_sim(i);
            end
        else %Not a local maximum
            if done(i) < 1
                profit_sim_prev(i) = profit_sim(i);
                lost_sim_prev(i) = lost_sim(i);
                thrown_sim_prev(i) = thrown_sim(i);
                spaced_out_sim_prev(i) = spaced_out_sim(i);
                sold_sim_prev(i) = sold_sim(i);
            end
        end
        
        profit_sim(i) = 0;
        lost_sim(i) = 0;
        thrown_sim(i) = 0;
        spaced_out_sim(i) = 0; 
        sold_sim(i) = 0;
    end    
end

lost_cust = lost;
perished = thrown;
targets = ftargets;

