function train(imagedir, N, featureType, Shift)
%Train a GMM models uses shapes in imagedir using N features
    if strcmp(imagedir,'./images/custom')
        classes = getClassList(imagedir);
    else
        classes = getClasses(imagedir);
    end
    totalImages = getNumImages(imagedir);
    for idx = 1:length(classes)
        class = classes{idx};
        models(idx).name = class;
        dataMatrix = getDataMatrix(imagedir, class, N, featureType, Shift);
        models(idx).mean = transpose(calcMean(dataMatrix));
        models(idx).cov = ensurePSD(calcCov(dataMatrix));
        models(idx).prior = numImagesForClass(imagedir, class)/totalImages;        
    end
    save('models');
end