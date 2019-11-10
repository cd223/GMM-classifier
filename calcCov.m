function covMat = calcCov(allData)
%A function to calculate the covariance of an arbitrary data matrix.
    numFeatures = size(allData, 2);
    numDataPoints = size(allData, 1);
    mu = calcMean(allData);
    
    covMat = zeros(numFeatures);
    for i = 1:numDataPoints
       covMat = covMat + (allData(i,:) - mu)' * (allData(i,:) - mu);
    end
    
    % Covariance matrix (without Bessel's correction applied)
    %covMat = covMat / (numDataPoints);
    
    % Covariance matrix (with Bessel's correction applied)
    covMat = covMat / (numDataPoints-1);
end