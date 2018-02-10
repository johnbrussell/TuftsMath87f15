function [Psteady, convergetime] = det_steady(T, n)

ssc = 2;
Psteady = zeros(n,1);
Psteady(1,1) = 1;
convergetime = 0;

while ssc > 1/n/n
    convergetime = convergetime + 1;
    ssc = 0;
    Psteadynew = zeros(n,1);
    Psteadynew = T * Psteady;
    
    for i = 1:n
        ssc = ssc + (Psteadynew(i,1) - Psteady(i,1))*(Psteadynew(i,1) - Psteady(i,1));
    end
    
    Psteady = Psteadynew;    
end

Psteady = transpose(Psteady);
disp(convergetime);
end