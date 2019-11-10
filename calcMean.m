function meanVec = calcMean(allData)
%A function to calculate the mean of an arbitrary data matrix.
    numDataPoints = size(allData, 1);
    numFeatures = size(allData, 2);
    meanVec = zeros(1, numFeatures);
   
    for i = 1:numFeatures
        coloumnTotal = 0;
        for j = 1:numDataPoints
            coloumnTotal = coloumnTotal + allData(j, i);
        end
        meanVec(:, i) = coloumnTotal/numDataPoints;
    end

end