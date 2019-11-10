% counts the number of images and return the total
function numImages = getNumImages(imagedir)
    verifyImageDir(imagedir)
    imagelist = dir(sprintf('%s/*.gif', imagedir));
    numImages = length(imagelist);
end