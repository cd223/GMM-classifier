function classes = getClassList(imagedir)
    verifyImageDir(imagedir);
    imagelist = dir(sprintf('%s/*.gif', imagedir));
    classes = {};
    for idx = 1:length(imagelist)
        name = imagelist(idx).name;
        class = name(1:end-5);
        if isempty(strmatch(class, classes))
            classes{length(classes)+1} = class;
        end
    end
end