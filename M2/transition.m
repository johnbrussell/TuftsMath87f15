function [T, outlinks] = transition(G, p, n)

G = full(G)*1.0;
outlinks = zeros(1,n);

% Count the outlinks for each page
for i = 1:n
    for j = 1:n
        outlinks(1,i) = outlinks(1,i) + G(j, i);
    end
end

T = G;

% Pages with no outlinks get equal probability of going to each other page,
% pages with outlinks get a smaller but equal probability of the same
for i = 1:n
    if outlinks(1,i) == 0
        for j = 1:n
            T(j,i) = 1/n;
        end
    else
        for j = 1:n
            T(j,i) = G(j,i)*p/outlinks(1,i) + (1-p)/n;
        end
    end
end

outlinks = zeros(1,n);
for i = 1:n
    for j = 1:n
        outlinks(1,i) = outlinks(1,i) + T(j, i);
    end
end


end
