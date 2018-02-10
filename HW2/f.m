function [x] = f(x,b)
    x = -b + log((500-x)/.015/(2000-(x-500)/.015))/log(1.015);
end