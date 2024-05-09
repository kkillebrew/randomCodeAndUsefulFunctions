% parpool
matlabpool


parfor i=1:10
    this(i) = i;
end


matlabpool close