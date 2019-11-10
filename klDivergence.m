function [ klDiv ] = klDivergence(mu_0, mu_1, cov_0, cov_1)
    k = length(mu_0);
    tmp = inv(cov_1)*cov_0;
    invcov_1= inv(cov_1);
    mu_diff = mu_1-mu_0;
    klDiv = 0.5*(trace(tmp)+(mu_diff)'*invcov_1*(mu_diff)-k-log(det(cov_1)/det(cov_0)));
end
