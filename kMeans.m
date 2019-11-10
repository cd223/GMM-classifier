numFeatures=15;
featureType='PCA';
Shift = 0;
testDir = './images/test';
trainDir = './images/train';
train(trainDir, numFeatures, featureType, Shift);
numImages = getNumImages(testDir);
allFeatures = zeros(numImages, numFeatures);
actualClasses = zeros(numImages,1);
files = dir(sprintf('%s/*.gif', testDir));
numClusters = 6;
classes = getClasses(trainDir);
classifyColours = zeros(numImages,3);
load('models');

for idx = 1:numImages
    imgPath = sprintf('%s/%s', testDir, files(idx).name);
    for indx = 1:length(classes)
        class = classes{indx};
        if findstr(class, imgPath) >0
            actualClasses(idx,1) = indx; 
        end
    end
    img_features = getFeatures(imgPath, numFeatures, featureType, Shift)';
    allFeatures(idx, :) = img_features;
end

[mapped_data, mapping] = compute_mapping(allFeatures, 'tSNE', 2);

opts = statset('Display','final');
[idx,C] = kmeans(mapped_data,numClusters,'Distance','cityblock', 'Replicates',5,'Options',opts);

% Plot confusion matrix:
conMatrix = zeros(length(classes));

% Plot the clusters and the cluster centroids.
figure;
plot(mapped_data(idx==1,1),mapped_data(idx==1,2),'y.','MarkerSize',12)
hold on
plot(mapped_data(idx==2,1),mapped_data(idx==2,2),'m.','MarkerSize',12)
hold on
plot(mapped_data(idx==3,1),mapped_data(idx==3,2),'c.','MarkerSize',12)
hold on
plot(mapped_data(idx==4,1),mapped_data(idx==4,2),'r.','MarkerSize',12)
hold on
plot(mapped_data(idx==5,1),mapped_data(idx==5,2),'b.','MarkerSize',12)
hold on
plot(mapped_data(idx==6,1),mapped_data(idx==6,2),'g.','MarkerSize',12)

plot(C(:,1),C(:,2),'kx',...
     'MarkerSize',15,'LineWidth',3)
legend('Cluster 1','Cluster 2', 'Cluster 3', 'Cluster 4', 'Cluster 5', 'Cluster 6','Centroids',...
       'Location','NW')
title 'Cluster Assignments and Centroids'
hold off

figure;
hold on;
title('Actual Classifications');
scatter(mapped_data(:,1), mapped_data(:,2), 10, actualClasses)
hold off

% You can determine how well separated the clusters are by passing |idx| to
% silhouette function
silhouette(mapped_data,idx,'cityblock')

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

numClus1 = 0;
numClus2 = 0;
numClus3 = 0;
numClus4 = 0;
numClus5 = 0;
numClus6 = 0;

for i=1:numImages
    if(idx(i)==1)
        numClus1 = numClus1 + 1;
    end
    if(idx(i)==2)
        numClus2 = numClus2 + 1;
    end
    if(idx(i)==3)
        numClus3 = numClus3 + 1;
    end
    if(idx(i)==4)
        numClus4 = numClus4 + 1;
    end
    if(idx(i)==5)
        numClus5 = numClus5 + 1;
    end
    if(idx(i)==6)
        numClus6 = numClus6 + 1;
    end
end

allFeaturesCluster1 = zeros(numClus1, numFeatures);
allFeaturesCluster2 = zeros(numClus2, numFeatures);
allFeaturesCluster3 = zeros(numClus3, numFeatures);
allFeaturesCluster4 = zeros(numClus4, numFeatures);
allFeaturesCluster5 = zeros(numClus5, numFeatures);
allFeaturesCluster6 = zeros(numClus6, numFeatures);

countCluster1 = 1;
countCluster2 = 1;
countCluster3 = 1;
countCluster4 = 1;
countCluster5 = 1;
countCluster6 = 1;

for k=1:numImages
    if(idx(k)==1)
        allFeaturesCluster1(countCluster1, :) = allFeatures(k, :);
        countCluster1 = countCluster1 + 1;
    end
    if(idx(k)==2)
        allFeaturesCluster2(countCluster2, :) = allFeatures(k, :);
        countCluster2 = countCluster2 + 1;
    end
    if(idx(k)==3)
        allFeaturesCluster3(countCluster3, :) = allFeatures(k, :);
        countCluster3 = countCluster3 + 1;
    end
    if(idx(k)==4)
        allFeaturesCluster4(countCluster4, :) = allFeatures(k, :);
        countCluster4 = countCluster4 + 1;
    end
    if(idx(k)==5)
        allFeaturesCluster5(countCluster5, :) = allFeatures(k, :);
        countCluster5 = countCluster5 + 1;
    end
    if(idx(k)==6)
        allFeaturesCluster6(countCluster6, :) = allFeatures(k, :);
        countCluster6 = countCluster6 + 1;
    end

    unsupervised_models(1).kMeansIdx = '1';
    dataMatrix = allFeaturesCluster1;
    unsupervised_models(1).mean = transpose(calcMean(dataMatrix));
    unsupervised_models(1).cov = ensurePSD(calcCov(dataMatrix));
    unsupervised_models(1).prior = numClus1/numImages;
    
    unsupervised_models(2).kMeansIdx = '2';
    dataMatrix = allFeaturesCluster2;
    unsupervised_models(2).mean = transpose(calcMean(dataMatrix));
    unsupervised_models(2).cov = ensurePSD(calcCov(dataMatrix));
    unsupervised_models(2).prior = numClus2/numImages;
    
    unsupervised_models(3).kMeansIdx = '3';
    dataMatrix = allFeaturesCluster3;
    unsupervised_models(3).mean = transpose(calcMean(dataMatrix));
    unsupervised_models(3).cov = ensurePSD(calcCov(dataMatrix));
    unsupervised_models(3).prior = numClus3/numImages;
    
    unsupervised_models(4).kMeansIdx = '4';
    dataMatrix = allFeaturesCluster4;
    unsupervised_models(4).mean = transpose(calcMean(dataMatrix));
    unsupervised_models(4).cov = ensurePSD(calcCov(dataMatrix));
    unsupervised_models(4).prior = numClus4/numImages;
    
    unsupervised_models(5).kMeansIdx = '5';
    dataMatrix = allFeaturesCluster5;
    unsupervised_models(5).mean = transpose(calcMean(dataMatrix));
    unsupervised_models(5).cov = ensurePSD(calcCov(dataMatrix));
    unsupervised_models(5).prior = numClus5/numImages;
    
    unsupervised_models(6).kMeansIdx = '6';
    dataMatrix = allFeaturesCluster6;
    unsupervised_models(6).mean = transpose(calcMean(dataMatrix));
    unsupervised_models(6).cov = ensurePSD(calcCov(dataMatrix));
    unsupervised_models(6).prior = numClus6/numImages;
    save('unsupervised_models');
    
    min_klDivVal = inf;
    closestClassIdx = 0;
    
    for cluster = 1:6
        mu_0 = unsupervised_models(1).mean;
        mu_1 = models(cluster).mean;
        cov_0 = unsupervised_models(1).cov;
        cov_1 = models(cluster).cov;
        klDiv = klDivergence(mu_1, mu_0, cov_1, cov_0);
        
        if(abs(klDiv) < min_klDivVal)
            min_klDivVal = klDiv;
            closestClassIdx = cluster;
        end
    end
    
    unsupervised_models(1).closestLabel = closestClassIdx;
    unsupervised_models(1).closestClass = classes(closestClassIdx);
    
    min_klDivVal = inf;
    closestClassIdx = 0;
    
    for cluster = 1:6
        mu_0 = unsupervised_models(2).mean;
        mu_1 = models(cluster).mean;
        cov_0 = unsupervised_models(2).cov;
        cov_1 = models(cluster).cov;
        klDiv = klDivergence(mu_1, mu_0, cov_1, cov_0);
        
        if(abs(klDiv) < min_klDivVal)
            min_klDivVal = klDiv;
            closestClassIdx = cluster;
        end
    end
    
    unsupervised_models(2).closestLabel = closestClassIdx;
    unsupervised_models(2).closestClass = classes(closestClassIdx);
    
    min_klDivVal = inf;
    closestClassIdx = 0;
    
    for cluster = 1:6
        mu_0 = unsupervised_models(3).mean;
        mu_1 = models(cluster).mean;
        cov_0 = unsupervised_models(3).cov;
        cov_1 = models(cluster).cov;
        klDiv = klDivergence(mu_1, mu_0, cov_1, cov_0);
        
        if(abs(klDiv) < min_klDivVal)
            min_klDivVal = klDiv;
            closestClassIdx = cluster;
        end
    end
    
    unsupervised_models(3).closestLabel = closestClassIdx;
    unsupervised_models(3).closestClass = classes(closestClassIdx);
    
    min_klDivVal = inf;
    closestClassIdx = 0;
    
    for cluster = 1:6
        mu_0 = unsupervised_models(4).mean;
        mu_1 = models(cluster).mean;
        cov_0 = unsupervised_models(4).cov;
        cov_1 = models(cluster).cov;
        klDiv = klDivergence(mu_1, mu_0, cov_1, cov_0);
        
        if(abs(klDiv) < min_klDivVal)
            min_klDivVal = klDiv;
            closestClassIdx = cluster;
        end
    end
    
    unsupervised_models(4).closestLabel = closestClassIdx;
    unsupervised_models(4).closestClass = classes(closestClassIdx);
    
    min_klDivVal = inf;
    closestClassIdx = 0;
    
    for cluster = 1:6
        mu_0 = unsupervised_models(5).mean;
        mu_1 = models(cluster).mean;
        cov_0 = unsupervised_models(5).cov;
        cov_1 = models(cluster).cov;
        klDiv = klDivergence(mu_1, mu_0, cov_1, cov_0);
        
        if(abs(klDiv) < min_klDivVal)
            min_klDivVal = klDiv;
            closestClassIdx = cluster;
        end
    end
    
    unsupervised_models(5).closestLabel = closestClassIdx;
    unsupervised_models(5).closestClass = classes(closestClassIdx);
    
    min_klDivVal = inf;
    closestClassIdx = 0;
    
    for cluster = 1:6
        mu_0 = unsupervised_models(6).mean;
        mu_1 = models(cluster).mean;
        cov_0 = unsupervised_models(6).cov;
        cov_1 = models(cluster).cov;
        klDiv = klDivergence(mu_1, mu_0, cov_1, cov_0);
        
        if(abs(klDiv) < min_klDivVal)
            min_klDivVal = klDiv;
            closestClassIdx = cluster;
        end
    end
    
    unsupervised_models(6).closestLabel = closestClassIdx;
    unsupervised_models(6).closestClass = classes(closestClassIdx);
end