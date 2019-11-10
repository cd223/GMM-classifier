N= 20:40;
Acc = zeros(size(N));

for i = 1:length(N)
    Acc(i) = conMatAccuracy(6, 'FOURIER', N(i));
end

figure;
hold on;
title('Fourier Spectrum Shift Matrix Accuracy (4 Features)');
xlabel('Shift from N lowest frequencies');
ylabel('Confusion Matrix % Accuracy');
plot(N, Acc);