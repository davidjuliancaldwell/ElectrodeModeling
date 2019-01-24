function tN = calculate_tn(n,s1,s2,s3,a,b,c)

aN = calculate_an(n,s1,s2,s3,a,b,c);

part1 = (((1 + (s3/s2) )*n)+1)*(((1+(s2/s1))*n) +1);
part2 = (n*(n+1)*(1-(s3/s2))*(1-(s2/s1))*((a/b)^(2*n+1)));
numer = aN*(part1 + part2);
denom = (c.^n)*((2*n+1).^2);

tN = numer/denom;


end