 _____ ___  ______  ___  _____  _                   _  __ _           
|  __ \|  \/  ||  \/  | /  __ \| |                 (_)/ _(_)          
| |  \/| .  . || .  . | | /  \/| |     __ _ ___ ___ _| |_ _  ___ _ __ 
| | __ | |\/| || |\/| | | |    | |    / _` / __/ __| |  _| |/ _ \ '__|
| |_\ \| |  | || |  | | | \__/\| |___| (_| \__ \__ \ | | | |  __/ |   
 \____/\_|  |_/\_|  |_/  \____/\_____/\__,_|___/___/_|_| |_|\___|_|   
                                                                      
          ___  ___    _    ___   __  __  ___ 
         | _ \| __|  /_\  |   \ |  \/  || __|
         |   /| _|  / _ \ | |) || |\/| || _| 
         |_|_\|___|/_/ \_\|___/ |_|  |_||___|
         
    A MATLAB implementation of a binary image GMM classifier.
         
       ___ _      _   ___ ___ ___ ___ ___   _ _____ ___ ___  _  _ 
      / __| |    /_\ | _ \_ _| __|_ _/ __| /_\_   _|_ _/ _ \| \| |
     | (__| |__ / _ \|   /| || _| | | (__ / _ \| |  | | (_) | .` |
      \___|____/_/ \_\_|_\___|_| |___\___/_/ \_\_| |___\___/|_|\_|

  **** All code from third party sources which was not provided in lab material is credited **** 
  Code was used from the following sources:
    * L.J.P. van der Maaten. (c2017). Matlab Toolbox for Dimensionality Reduction. [online] 
    Available at:  https://lvdmaaten.github.io/drtoolbox/ [Accessed 14 Apr. 2017].
    * Wolf C,. Matlab code for Zernike moments. [online] 
    Available at: http://liris.cnrs.fr/christian.wolf/software/zernike/  [Accessed 14 Apr. 2017].
    * Spruyt, V. "How to draw an error ellipse representing the covariance matrix?". [online] 
    Available at: http://www.visiondummy.com/2014/04/draw-error-ellipse-representing-covariance-matrix/ [Accessed 14 Apr. 2017]

--------------------------------------* 1 *--------------------------------------
                        Packaging and execution instructions.
---------------------------------------------------------------------------------
* Extract all files from the GMM_Classifier_cjd47.zip folder. This expands as a directory of files:
    * calcCov.m - Calculates the covariance matrix of a data matrix.
    * calcMean.m - Calculates the mean vector of a data matrix.
    * centersquare.m - Used in Zernike feature extraction (Wolf. C).
    * chainCode.m - Calculates image chain code.
    * classify.m - Classifies image using models.mat or unsupervised_models.mat
            Example use: classify('./images/train/Alien001', 'SUPERVISED')
    * CM20220 Coursework Report.pdf - Report on findings.
    * confusionMatrix.m - Confusion matrix for supervised GMM classification.
            Example use: confusionMatrix('./images/train', './images/custom', 8, 'BW', 0)
    * conMatAccuracy.m  - Computes classifier accuracy for given conditions.
            Example use: conMatAccuracy(15, 'PCA', 0)
    * customTestImages.m - Script - Classifies the custom image set.
    * ensurePSD.m  - Ensures matrix is positive semi definite (provided in Lab material)
    * equalVec.m - Tests if 2 vectors are equal (provided in Lab material)
    * error_elipse.m - Script - produces covariance error elipse (Spruyt, V).
    * findBlackSpot.m - Finds first black spot in an image
    * findWhiteSpot.m - Finds first white spot in an image (provided in Lab material)
    * getClasses.m - Gets list of classes in an image directory (provided in Lab material)
    * getClassList.m - Gets list of classes in an image directory
    * getDataMatrix.m - Gets data matrix of all features of certain class (provided in Lab material)
    * getFeatures.m - Gets features of a given image. 
            Example use: getFeatures('./images/test/Alien043.gif', 8, 'BW', 0)
    * getNumImages.m - Counts images in an image directory (provided in Lab material)
    * klDivergence.m - Calculates the KL divergence between 2 Normal distributions.
    * klDivGaussians.m - Script - Calculates the KL Divergence betwteen the Gaussians of the supervised GMM.
    * kMeans.m - Script - Clusters data using k-means and creates an unsupervised GMM.
    * matrixSpread.m - Calculates the spread of a given matrix - classifier % accuracy for confusion matrix.
    * numFeaturesBWPlot.m - Script - Plots number of BW Features against resultant % classifier accuracy.
    * numFeaturesFourierPlot.m - Script - Plots number of Fourier Features against resultant % classifier accuracy.
    * numFeaturesPCAPlot.m - Script - Plots number of PCA Features against resultant % classifier accuracy.
    * numFeaturesZernikePlot.m - Script - Plots number of Zernike Features against resultant % classifier accuracy.
    * numImagesForClass.m - Calculates the number of images belonging to a certain class in a directory (provided in Lab material)
    * plotFourierSpectrum.m - Script - Plots shift in Fourier Spectrum against resultant % classifier accuracy.
    * plotKernelDensityEstimation.m - Script - Plots probability distribution estimation for each class.
    * README.txt - Instructions.
    * train.m - Trains a supervised GMM based on a chosen feature extraction type.
            Example use: train('./images/train', 6, 'FOURIER', 0)
    * tsnePlot.m - Script - Plots predicted vs actual classes for a given feature extraction type.
    * unsupervised_con_matrix.m - Confusion matrix for unsupervised GMM classification.
            Example use: unsupervised_con_matrix('./images/train', './images/test')
    * verifyImageDir.m - Verifies an image directory (provided in Lab material)
    * zernike_bf.m - Used in Zernike feature extraction (Wolf. C).
    * zernike_mom.m - Used in Zernike feature extraction (Wolf. C).
    * zernike_orderlist.m - Used in Zernike feature extraction (Wolf. C).
    * zernike_rec.m - Used in Zernike feature extraction (Wolf. C).

--------------------------------------* 2 *--------------------------------------
                                   Images used.
---------------------------------------------------------------------------------
1. "training set" - provided with Lab material ('./images/train')
2. "test set" - provided with Lab material ('./images/test')
3. "custom set" - taken from the MPEG7 CE Shape-1 Part B database ('./images/custom')

--------------------------------------* 3 *--------------------------------------
                              Training the classifier.
---------------------------------------------------------------------------------
The supervised GMM classifier can be trained using train.m which saves a MATLAB struct 'models' as a supervised GMM.
    * train.m has 4 parameters - imagedir, N, featureType, Shift
        - imagedir = directory of image to train classifier on (usually './images/train')
        - N = Number of Features (length of feature vector) 
        - featureType = 'FOURIER' / 'ZERNIKE' / 'BW' / 'PCA'
        - Shift = Shift in Fourier coefficients sampled from (usually 0)
    * It will model all of the parameters of each class in the training directory as separate Gaussian distributions in a GMM.
        - This model can be seen by using the command "load 'models'"
        
The unsupervised GMM classifier can be trained using kMeans.m which saves a MATLAB struct 'unsupervised_models' as an unsupervised GMM.
    * Click run on the kMeans.m script to see the data being clustered by the k-Means algorithm. 
    * The following variables can be changed within the file to see the effects:
        - numFeatures = Number of Features (length of feature vector) 
        - featureType = 'FOURIER' / 'ZERNIKE' / 'BW' / 'PCA'
        - Shift = Shift in Fourier coefficients sampled from (usually 0)
        - testDir = './images/test';
        - trainDir = './images/train';
    * The script computes the parameters to a Gaussian for each cluster then models an unsupervised GMM.
    * This script also plots the k-Means clusters and actual classifications and works out the closest label to each k-Means cluster in the GMM.
        
--------------------------------------* 4 *--------------------------------------
                              Testing the classifier.
---------------------------------------------------------------------------------

Testing the supervised GMM classifier uses: confusionMatrix.m and conMatrixAccuracy.m
    * confusionMatrix.m has 5 parameters. It outputs the supervised confusion matrix under given conditions.
        - traindir = directory of image to train classifier on (usually './images/train')
        - testdir = directory of image to test classifier on (usually './images/test')
        - N = Number of Features (length of feature vector) 
        - featureType = 'FOURIER' / 'ZERNIKE' / 'BW' / 'PCA'
        - Shift = Shift in Fourier coefficients sampled from (usually 0)
    * conMatrixAccuracy.m has 3 parameters. It outputs the computed accuracy of the classifier using these given conditions.
        - N = Number of Features (length of feature vector) 
        - featureType = 'FOURIER' / 'ZERNIKE' / 'BW' / 'PCA'
        - Shift = Shift in Fourier coefficients sampled from (usually 0)
    
Testing the unsupervised GMM classifier uses: unsupervised_con_matrix.m
    * unsupervised_con_matrix.m has 2 parameters. It outputs the unsupervised confusion matrix under given conditions and its accuracy.
        - traindir = directory of image to train classifier on (usually './images/train')
        - testdir = directory of image to test classifier on (usually './images/test')

--------------------------------------* 5 *--------------------------------------
                                Further analysis.
---------------------------------------------------------------------------------
* Click run on the customTestImages.m script - Classifies the custom image set.
* Click run on the error_elipse.m script - produces covariance error elipse (Spruyt, V).
* Click run on the klDivGaussians.m script - Calculates the KL Divergence betwteen the Gaussians of the supervised GMM.
* Click run on the kMeans.m script - Clusters data using k-means and creates an unsupervised GMM.
* Click run on the numFeaturesBWPlot.m script - Plots number of BW Features against resultant % classifier accuracy.
* Click run on the numFeaturesFourierPlot.m script - Plots number of Fourier Features against resultant % classifier accuracy.
* Click run on the numFeaturesPCAPlot.m script - Plots number of PCA Features against resultant % classifier accuracy.
* Click run on the numFeaturesZernikePlot.m script - Plots number of Zernike Features against resultant % classifier accuracy.
* Click run on the plotFourierSpectrum.m script - Plots shift in Fourier Spectrum against resultant % classifier accuracy.
* Click run on the plotKernelDensityEstimation.m script - Plots probability distribution estimation for each class.
* Click run on the tsnePlot.m script - Plots predicted vs actual classes for a given feature extraction type.