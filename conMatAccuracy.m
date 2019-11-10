function accuracy = conMatAccuracy(N, featureType, Shift)
    cmatrix = confusionMatrix('./images/train', './images/test', N, featureType, Shift);
    cmatrix .* eye(6);
    accuracy = sum(sum(cmatrix .* eye(6)))/sum(sum(cmatrix)) * 100;
end

