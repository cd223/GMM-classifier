function [ conMatrix ] = confusionMatrix(traindir, testdir, N, featureType, Shift)
    train(traindir, N, featureType, Shift);
    conMatrix = zeros(length(getClasses(traindir)));
    classes = getClasses(traindir);
    
    for idx = 1:length(classes)
        class = classes{idx};
        imagelist = dir(sprintf('%s/%s*.gif', testdir, class));
       
        for imgidx = 1:length(imagelist)
            imagepath = sprintf('%s/%s', testdir, imagelist(imgidx).name);
            conMatrix(idx, classify(imagepath, 'SUPERVISED')) = conMatrix(idx, classify(imagepath, 'SUPERVISED')) + 1;
        end
    end
end