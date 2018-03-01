function [xr, yr] = shuffleRand4D(x,y)
% x -> 4 dimension array (points)
% y -> 1 dimension array (class)
% xr -> 4 dimension array random row (poits shuffled)
% yr -> 1 dimension array random row (class shuffled)

r = randperm(size(x,1));

xr = x(r,:,:,:);
yr = y(r);
