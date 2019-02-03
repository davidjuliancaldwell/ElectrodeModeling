for n=1:100;
    C=0.06;
    B=C-2*0.001;
    AA=C-2*0.001-2*0.0035;
    rt=0.55;
    rs=2;
    rb=3;
    a=(rs/rb)+1;
    b=(rt/rs)+1;
    c=(rs/rb)-1;
    d=(rt/rs)-1;
    e=AA/B;
    f=B/C;
    g=AA/C;
    E=e^(2*n+1);
    F=f^(2*n+1);
    G=g^(2*n+1);
    D=((a*n+1)*(b*n+1))+(c*d*n*(n+1)*E)+(d*(n+1)*(a*n+1)*F)+(c*(n+1)*(b*(n+1)-1)*G);
    N=((2*n)+1)^3/(2*n);
    A=N/D;out1(n)=D;out2(n)=N;out3(n)=A;
end;

figure;plot(out1)
hold on;plot(out2,'r')
hold on;plot(out3,'g')

figure;plot(out3,'g')
%%
for n=1:100000;
    C=0.06;
    B=C-2*0.001;
    AA=C-2*0.001-2*0.0035;
    rt=0.55;
    rs=2;
    rb=3;
    a=(rs/rb)+1;
    b=(rt/rs)+1;
    c=(rs/rb)-1;
    d=(rt/rs)-1;
    e=AA/B;
    f=B/C;
    g=AA/C;
    E=e^(2*n+1);
    F=f^(2*n+1);
    G=g^(2*n+1);
    D=((a*n+1)*(b*n+1))+(c*d*n*(n+1)*E)+(d*(n+1)*(a*n+1)*F)+(c*(n+1)*(b*(n+1)-1)*G);
    N=((2*n)+1)^3/(2*n);
    A=N/D;out1(n)=D;out2(n)=N;out3(n)=A;out4(n)=(((C-0.0005)/C)^n);out5(n)=(((C-0.001)/C)^n)*A;
end;
figure;plot(out4)
figure;plot(out5)


for n=1:1000;
    C=0.06;
    B=C-2*0.001;
    AA=C-2*0.001-2*0.0035;
    rt=0.55;
    rs=2;
    rb=3;
    a=(rs/rb)+1;
    b=(rt/rs)+1;
    c=(rs/rb)-1;
    d=(rt/rs)-1;
    e=AA/B;
    f=B/C;
    g=AA/C;
    E=e^(2*n+1);
    F=f^(2*n+1);
    G=g^(2*n+1);
    D=((a*n+1)*(b*n+1))+(c*d*n*(n+1)*E)+(d*(n+1)*(a*n+1)*F)+(c*(n+1)*(b*(n+1)-1)*G);
    N=((2*n)+1)^3/(2*n);
    A=N/D;out1(n)=D;out2(n)=N;out3(n)=A;out4(n)=(((C-0.0005)/C)^n);out5(n)=(((C-0.001)/C)^n)*A;
end;

for n=1:1000;
    C=0.06;
    B=C-2*0.001;
    AA=C-2*0.001-2*0.0035;
    rt=0.55;
    rs=2;
    rb=3;
    a=(rs/rb)+1;
    b=(rt/rs)+1;
    c=(rs/rb)-1;
    d=(rt/rs)-1;
    e=AA/B;
    f=B/C;
    g=AA/C;
    E=e^(2*n+1);
    F=f^(2*n+1);
    G=g^(2*n+1);
    D=((a*n+1)*(b*n+1))+(c*d*n*(n+1)*E)+(d*(n+1)*(a*n+1)*F)+(c*(n+1)*(b*(n+1)-1)*G);
    N=((2*n)+1)^3/(2*n);
    A=N/D;out1(n)=D;out2(n)=N;out3(n)=A;out4(n)=(((C-0.0005)/C)^n);out5(n)=(((C-0.001)/C)^n)*A;
end;
