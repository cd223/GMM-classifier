function [ conMatrix ] = unsupervised_con_matrix(traindir, testdir)  
    conMatrix = zeros(length(getClasses(traindir)));
    classes = getClasses(traindir);
    
    for idx = 1:length(classes)
        class = classes{idx};
        imagelist = dir(sprintf('%s/%s*.gif', testdir, class));
        
        for imgidx = 1:length(imagelist)
            imagepath = sprintf('%s/%s', testdir, imagelist(imgidx).name);
            conMatrix(idx, classify(imagepath, 'UNSUPERVISED')) = conMatrix(idx, classify(imagepath, 'UNSUPERVISED')) + 1;
        end
    end
    
    conMatrix
    matrixSpread(conMatrix)
end