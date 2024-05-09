function make_gaussian = make_gaussian(size,stdev_center,polarity)
 
% creates a square matrix with a Difference of Gaussian filter
% size = size of the matrix
% stdev_center = center "radius"
% stdev_surround = surround "radius"
 
% (c) Jan, 2002, Xoana G. Troncoso, All Rights Reserved
% x.troncoso@neuralcorrelate.com
 
% space
dval = size/2;
xval = -dval:dval-1;
[xx,yy] = meshgrid(xval,xval);
rr = sqrt(xx.^2 + yy.^2);
 
% filter
center0 = exp(-rr.^2/(2*stdev_center^2));
center = center0 / sum(center0(:)); % nomalization: add up to 1
 
 
make_gaussian = 255*center/max(center(:));
% imshow(dog,[0 255])