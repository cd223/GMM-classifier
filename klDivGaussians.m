load 'models'

for class_idx = 1:6
    models(class_idx).name
    mu_0 = models(class_idx).mean;
    cov_0 = models(class_idx).cov;
    
    for gaussian_idx = 1:6
        mu_1 = models(gaussian_idx).mean;
        cov_1 = models(gaussian_idx).cov;
        kldiv = abs(klDivergence(mu_1, mu_0, cov_1, cov_0))
    end
end