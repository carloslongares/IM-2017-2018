
b = [ 1 1 1;
      2 2 2;  
      3 3 3;
]

c = [1;2;3];

[m,n] = size(b) ;
idx = randperm(n);

for i=1:3
    for j=1:3
        b(i,j)
    end
end
