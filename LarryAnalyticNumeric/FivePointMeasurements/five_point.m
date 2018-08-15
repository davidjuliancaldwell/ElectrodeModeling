

T=T1;E=E1;
for j=1:22;for k=1:64;for l=1:64;dlm=fitlm([T(j) T(k) T(l)],[E(j) E(k) E(l)],'Intercept', false);d(j,k,l)=dlm.Coefficients.Estimate(1);end;end;end;
for j=23:29;for k=1:64;for l=1:64;dlm=fitlm([T(j) T(k) T(l)],[E(j) E(k) E(l)],'Intercept', false);d(j,k,l)=dlm.Coefficients.Estimate(1);end;end;end;
for j=31:64;for k=1:64;for l=1:64;dlm=fitlm([T(j) T(k) T(l)],[E(j) E(k) E(l)],'Intercept', false);d(j,k,l)=dlm.Coefficients.Estimate(1);end;end;end;

E=E2;T=T2;
for j=1:12;for k=1:64;for l=1:64;dlm=fitlm([T(j) T(k) T(l)],[E(j) E(k) E(l)],'Intercept', false);dd(j,k,l)=dlm.Coefficients.Estimate(1);end;end;end;
for j=15:64;for k=1:64;for l=1:64;dlm=fitlm([T(j) T(k) T(l)],[E(j) E(k) E(l)],'Intercept', false);dd(j,k,l)=dlm.Coefficients.Estimate(1);end;end;end;

E=E7;T=T7;
for j=1:55;for k=1:64;for l=1:64;dlm=fitlm([T(j) T(k) T(l)],[E(j) E(k) E(l)],'Intercept', false);dd(j,k,l)=dlm.Coefficients.Estimate(1);end;end;end;
for j=57:63;for k=1:64;for l=1:64;dlm=fitlm([T(j) T(k) T(l)],[E(j) E(k) E(l)],'Intercept', false);dd(j,k,l)=dlm.Coefficients.Estimate(1);end;end;end;

E=E6;T=T6;
for j=1:53;for k=1:64;for l=1:64;dlm=fitlm([T(j) T(k) T(l)],[E(j) E(k) E(l)],'Intercept', false);dd(j,k,l)=dlm.Coefficients.Estimate(1);end;end;end;
for j=55:61;for k=1:64;for l=1:64;dlm=fitlm([T(j) T(k) T(l)],[E(j) E(k) E(l)],'Intercept', false);dd(j,k,l)=dlm.Coefficients.Estimate(1);end;end;end;
for j=63:64;for k=1:64;for l=1:64;dlm=fitlm([T(j) T(k) T(l)],[E(j) E(k) E(l)],'Intercept', false);dd(j,k,l)=dlm.Coefficients.Estimate(1);end;end;end;

% the scale factors are given by
sf(j)=(2*pi)/i0(j);

figure;hist(sf(1)*dd1(:),bins2)
figure;hist(sf(2)*dd2(:),bins2)
figure;hist(sf(6)*dd6(:),bins2)
figure;hist(sf(7)*dd7(:),bins2)


