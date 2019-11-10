N= 1:15;
Acc = zeros(size(N));
Shift = 0;
for i = 1:length(N)
    Acc(i) = conMatAccuracy(i, 'ZERNIKE', Shift);
end

figure;
hold on;
title('Zernike Moments Matrix Accuracy');
xlabel('Number of Features');
ylabel('Confusion Matrix % Accuracy');
plot(N, Acc);