N=3;
featureType='FOURIER';
Shift = 0;
testDir = './images/test';
trainDir = './images/train';
train(trainDir, N, featureType, Shift);
load('models');
classes = getClasses(trainDir);
files = dir(sprintf('%s/*.gif', testDir));
numImages = getNumImages(testDir);
numFiles = length(files);
allFeatures = zeros(numFiles, N);
predictedClasses = zeros(numFiles,1);
actualClasses = zeros(numFiles,1);
classifyColours = zeros(numFiles,3);

for idx = 1:numImages
    imgPath = sprintf('%s/%s', testDir, files(idx).name);
    classifiedIdx = classify(imgPath, 'SUPERVISED');
    predictedClasses(idx,1) = classifiedIdx;
    for indx = 1:length(classes)
        class = classes{indx};
        if findstr(class, imgPath) >0
            actualClasses(idx,1) = indx;
        end
    end
    features = getFeatures(imgPath, N, featureType, Shift)';
    allFeatures(idx, :) = features;
end

for i = 1:length(classifyColours)
    if(predictedClasses(i,1) == 1)
        classifyColours(i, :) = [1 0 0];
    end
    if(predictedClasses(i,1) == 2)
        classifyColours(i, :) = [0 1 0];
    end
    if(predictedClasses(i,1) == 3)
        classifyColours(i, :) = [0 0 1];
    end
    if(predictedClasses(i,1) == 4)
        classifyColours(i, :) = [1 1 0];
    end
    if(predictedClasses(i,1) == 5)
        classifyColours(i, :) = [0 1 1];
    end
    if(predictedClass	s(i,1) == 6)
        classifyColours(i, :) = [1 0 1];
    end
end

figure;
hold on;
title('Predicted Classifications');
[mapped_data, mapping] = compute_mapping(allFeatures, 'tSNE', 2);
scatter(mapped_data(:,1), mapped_data(:,2), 10, classifyColours)

for i = 1:length(classifyColours)
    if(actualClasses(i,1) == 1)
        classifyColours(i, :) = [1 0 0];
    end
    if(actualClasses(i,1) == 2)
        classifyColours(i, :) = [0 1 0];
    end
    if(actualClasses(i,1) == 3)
        classifyColours(i, :) = [0 0 1];
    end
    if(actualClasses(i,1) == 4)
        classifyColours(i, :) = [1 1 0];
    end
    if(actualClasses(i,1) == 5)
        classifyColours(i, :) = [0 1 1];
    end
    if(actualClasses(i,1) == 6)
        classifyColours(i, :) = [1 0 1];
    end
end

figure;
hold on;
title('Actual Classifications');
scatter(mapped_data(:,1), mapped_data(:,2), 10, classifyColours)
