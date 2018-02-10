function [finalurls, finalprobs] = det_urls(urls, probabilities, n)

numbers = zeros(1,11);
finalprobs = zeros(1,11);
finalurls = [];
placeholder1 = 0;
placeholder2 = 0;
n1 = 0;
n2 = 0;

for i = 1:n
    if(probabilities(1,i) >= finalprobs(1,10))
        placeholder1 = probabilities(1,i);
        n1 = i;
        for j = 1:10
            if(placeholder1 >= finalprobs(1,j))
                placeholder2 = finalprobs(1,j);
                n2 = numbers(1,j);
                finalprobs(1,j) = placeholder1;
                numbers(1,j) = n1;
                placeholder1 = placeholder2;
                n1 = n2;
            end            
        end
    end
end

for i = 1:10
    finalurls = [finalurls urls(numbers(1,i),1)];
end

finalurls = transpose(finalurls);
finalprobs = transpose(finalprobs);

end