N=8;
Shift = 0;
featureType='BW';
testDir = './images/test';
trainDir = './images/train';
train(trainDir, N, featureType, Shift);
load('models');
classes = getClasses(testDir);
Shift = 0;

for idx = 1:length(classes)
    class = classes{idx};
    dataMatrix = getDataMatrix(testDir, class, N, featureType, Shift);
    [mapped_data, mapping] = compute_mapping(dataMatrix, 'KernelPCA', 2);
    gridX1 = -5:0.5:4.5;
    gridX2 = -5:0.5:4.5;
    [x1, x2] = meshgrid(gridX1, gridX2);
    x1 = x1(:);
    x2 = x2(:);
    xi = [x1 x2];
    figure;
    ksdensity(mapped_data, xi);
end