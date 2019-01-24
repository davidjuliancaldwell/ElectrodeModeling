function sN = calculate_sn(n,s1,s2,s3,a,b,c)

aN = calculate_an(n,s1,s2,s3,a,b,c);

numer = ((aN/(c.^n))*(((1-(s3/s2))*n)+1));
denom = (2*n+1);

sN = numer/denom;


end