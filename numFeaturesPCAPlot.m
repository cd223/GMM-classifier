N=30:60;
Shift =0;
Acc = zeros(size(N));
for i = 1:length(N)
    Acc(i) = conMatAccuracy(i, 'PCA', Shift);
end

figure;
hold on;
title('PCA Matrix Accuracy');
xlabel('Number of Features');
ylabel('Confusion Matrix % Accuracy');
plot(N, Acc);