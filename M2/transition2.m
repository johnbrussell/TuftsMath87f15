function [T, outlinks] = transition2(G, p, n)

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

% Count degrees of separation of farthest page from root page
countzero = n;
iteration = 1;
degrees = zeros(1,n);
degrees(1,1) = 1;
while countzero > 0
    for i = 1:n
        for j = 1:n
            if(degrees(1,j) == iteration)
                if(G(i,j) == 1)
                    if(degrees(1,i) == 0)
                        degrees(1,i) = iteration + 1;
                    end
                end
            end
        end
    end
    countzero = 0;
    for i = 1:n
        if(degrees(1,i) == 0)
            countzero = countzero + 1;
        end
    end
    iteration = iteration + 1;    
end

% Count degrees of separation of root page from every other page
countzero = n;
revdegrees = zeros(1,n);
revdegrees(1,1) = 1;
newiteration = 1;
while countzero > 0
    for i = 1:n
        for j = 1:n
            if(revdegrees(1,i) == newiteration)
                if(G(i,j) == 1)
                    if(revdegrees(1,j) == 0)
                        revdegrees(1,j) = newiteration + 1;
                    end
                end
            end
        end
    end

    % Pages from which the root is further separated than the pages are
    % from the root are given a value of degrees of separation equivalent
    % to the maximum distance of a non-root page from the root page
    if(newiteration > iteration)
        for i = 1:n
            if(revdegrees(1,i) == 0)
                revdegrees(1,i) = newiteration + 1;
            end
        end
    end
    
    countzero = 0;
    for i = 1:n
        if(revdegrees(1,i) == 0)
            countzero = countzero + 1;
        end
    end

    newiteration = newiteration + 1;    
end

% Average the degrees of separation for each page
avdegrees = (revdegrees + degrees)/2;

% Weight the transition matrix appropriately
for i = 1:n
    for j = 1:n
        T(i,j) = T(i,j) / avdegrees(1,i);
    end
end

% Renormalize
sumtotal = 0;
for j = 1:n
    sumtotal = 0;
    for i = 1:n
        sumtotal = sumtotal + T(i,j);
    end
    for i = 1:n
        T(i,j) = T(i,j) / sumtotal;
    end
end

end
