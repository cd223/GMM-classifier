trainDir = './images/train';
testDir = './images/custom';
N = 15;
featureType = 'PCA';
Shift = 0;
train(trainDir, N, featureType, Shift);
trainClasses = getClasses('./images/train');
testClasses = getClassList('./images/custom');

for idx = 1:length(testClasses)
    ClassifiedMatrix = zeros(6,1);
    class = testClasses{idx}
    imagelist = dir(sprintf('%s/%s*.gif', testDir, class));

    for imgidx = 1:length(imagelist)
        imagepath = sprintf('%s/%s', testDir, imagelist(imgidx).name);
        ClassifiedMatrix(classify(imagepath, 'SUPERVISED'), 1) = ClassifiedMatrix(classify(imagepath, 'SUPERVISED'), 1) + 1;
    end
    
    ClassifiedMatrix
end