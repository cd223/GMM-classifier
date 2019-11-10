function [features] = getFeatures(imagePath, N, featureType, Shift)
    %Directory where images can be found---ensure this is correct
    verifyImageDir('images');
    image = logical(imread(imagePath));
    
    if strcmp(featureType,'ZERNIKE')
    % Use the absolute value of the Zernike Moments up to degree 6 as a feature vector
        imageSize = 60;
        % The image needs to be centred on a unit square
        m = centersquare(image,imageSize);
        % abs() gets rid of the phase component (the complex argument)
        % Calculate the Zernike moments up to degree 6
        featureVector = abs(zernike_mom(m,zernike_bf(imageSize,6)));
        features = featureVector / sum(featureVector);
        features = features(1:N)';
    end
    if strcmp(featureType,'FOURIER')
        % Get the chain code for the image
        c = chainCode(image);
        angles = c(3,:)*(2*pi/8);
        anglesFFT = fft(angles); %fast fourier transform

        % Filter using a 'top hat' filter.
        filter = zeros(size(angles));
        
        %Both the positive and negative low frequencies must be kept
        %filter(1) is the zero (DC) frequency, so there will be (N*2)-1 ones in total
        filter(1:N) = 1; 
        filter(end-N+2:end) = 0;
        filteredFFT = anglesFFT .* filter;

        % abs() gets rid of the phase component (the complex argument)
        features = abs(filteredFFT(1+Shift:N+Shift));
        features = abs(anglesFFT(1+Shift:N+Shift));
    end
    if strcmp(featureType,'BW')
        b = 0; % number of black pixels
        w = 0; % number of white pixels
        aspRatio = size(image,2)/size(image,1); % aspect ratio of the image
        objects = bwconvhull(image,'objects'); % Generate convex hull image from binary image
        D = bwdist(image); % Distance transform of binary image
        bwdistance = sum(calcMean(D));
        
        % count number of black and white pixels respectively
        for i = 1:size(image,1)
            for j = 1:size(image,2)
                if image(i,j) == 0
                    b = b+1;
                else
                    w = w+1;
                end
            end
        end
 
        features = [b w b/w  w/b bwarea(image) bwarea(objects) aspRatio bwdistance];
        features = features(1:N);
    end
    if strcmp(featureType,'PCA')
        % reduce the dimensionality of the data to dimension N
        [mapped_data, mapping] = compute_mapping(image, 'PCA', N);
        features = mapped_data(1:N);
    end
end