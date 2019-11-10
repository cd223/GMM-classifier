function [bestidx] = classify(imagepath, type)
%Classify the image specified for the given image path
    
    if strcmp(type,'SUPERVISED')
        load('models');
        %Assume all models use the same number of features
        N = length(models(1).mean);
        features = getFeatures(imagepath, N, featureType, Shift)';
        maxscore = -inf;
        %Find out which class has the highest score
        for idx = 1:length(models)
            model = models(idx);
            score = log(model.prior) - 0.5*log(det(model.cov)) - 0.5*(features - model.mean)'*inv(model.cov)*(features - model.mean);
            if score > maxscore
                maxscore = score;
                bestidx = idx;
            end
        end
    end
    
    if strcmp(type,'UNSUPERVISED')
        load('unsupervised_models');
        %Assume all models use the same number of features
        N = length(unsupervised_models(1).mean);
        features = getFeatures(imagepath, N, featureType, Shift)';
        maxscore = -inf;
        %Find out which class has the highest score
        for idx = 1:length(unsupervised_models)
            model = unsupervised_models(idx);
            score = log(model.prior) - 0.5*log(det(model.cov)) - 0.5*(features - model.mean)'*inv(model.cov)*(features - model.mean);
            if score > maxscore
                maxscore = score;
                bestidx = model.closestLabel;
            end
        end
    end
    
end