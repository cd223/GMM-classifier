N= 1:8;
Acc = zeros(size(N));
Shift = 0;
for i = 1:length(N)
    Acc(i) = conMatAccuracy(i, 'BW', Shift);
end

figure;
hold on;
title('Black/White Properties Matrix Accuracy');
xlabel('Number of Features');
ylabel('Confusion Matrix % Accuracy');
plot(N, Acc);