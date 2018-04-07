function [xr, yr] = shuffleRand3D(x,y)
% x -> 4 dimension array (points)
% y -> 1 dimension array (class)
% xr -> 4 dimension array random row (poits shuffled)
% yr -> 1 dimension array random row (class shuffled)

r = randperm(size(x,3))

xr = x(:,:,r);
yr = y';
yr = yr(r);
yr = yr';
