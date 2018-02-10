function [V, V1, D, counter, P] = eigen(T, n)

[V1, D] = eig(T);
V = zeros(1,n);
absval = 0;
counter = 0;

for i = 1:n
    if(abs(real(D(i,i))-1) < 0.01)
        counter = counter + 1;
    end
end


for i = 1:n
    if(abs(real(D(i,i))) > absval)
        absval = abs(real(D(i,i)));
        for j=1:n
            V(1,j) = real(V1(j,i));
        end
    end
end

sumof = 0;
for i = 1:n
    sumof = sumof + V(1,i);
end

P = V;
for i = 1:n
    P(1,i) = P(1,i) / sumof;
end

counter = 0;

for i = 1:n
    counter = counter + P(1,i);
end

end