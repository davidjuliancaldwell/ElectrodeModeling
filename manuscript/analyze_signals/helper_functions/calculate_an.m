function aN = calculate_an(n,s1,s2,s3,a,b,c)

exponent = (2*n+1);
numer = (exponent.^3)/(2*n);
part1 = (((s3/s2) + 1)*n + 1)*(((s2/s1) + 1)*n + 1 );
part2 = (((s3/s2) -1)*((s2/s1)-1)*n*(n+1)*(a/b).^exponent);
part3 = ((((s2/s1)-1)*(n+1))*((((s3/s2)+1)*n) +1)*(b/c).^exponent);
part4 = ((((s3/s2)-1)*(n+1))*(((s2/s1)+1)*(n+1)-1)*(a/c).^exponent);
denom = (part1 + part2 + part3 + part4); 

aN = numer/denom;


end