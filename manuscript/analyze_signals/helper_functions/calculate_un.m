function uN = calculate_un(n,s1,s2,s3,a,b,c)

aN = calculate_an(n,s1,s2,s3,a,b,c);

numer = ((aN/(c.^n))*n*((1-(s3/s2))*(a.^(2*n+1))));
denom = (2*n+1);

uN = numer/denom;


end