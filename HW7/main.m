quiet = 0;
cost_day = 1;
arrival_day = 1;
p = 1;
probs = [p (1-p)/6 (1-p)/6 (1-p)/6 (1-p)/6 (1-p)/6 (1-p)/6];
pnpt1 = 0;
pnpt2 = 0;
pnpt1mod = 0;
pnpt2mod = 0;

for i=1:10000
%    pnpt1 = (pnpt1 * (i-1) + strategy1(cost_day,quiet)) / i;
 %   pnpt2 = (pnpt2 * (i-1) + strategy2(cost_day,quiet)) / i;
    pnpt1mod = (pnpt1mod * (i-1) + strategy1mod(cost_day,quiet,probs,arrival_day)) / i;
    pnpt2mod = (pnpt2mod * (i-1) + strategy2mod(cost_day,quiet,probs)) / i;
end

