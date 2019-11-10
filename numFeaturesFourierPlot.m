N= 20:30;
Shift =0;
Acc = zeros(size(N));
for i = 1:length(N)
    Acc(i) = conMatAccuracy(i, 'FOURIER', Shift);
end

figure;
hold on;
title('Fourier Transform of Chain Code Matrix Accuracy');
xlabel('Number of Features');
ylabel('Confusion Matrix % Accuracy');
plot(N, Acc);
