function [xr, yr] = shuffleRand(x,y)

c = [x y];
r = randperm(size(c,1));
res = c(r,:);

xr = res(:,1:(size(c,2)-1));
yr = res(:,size(c,2));
