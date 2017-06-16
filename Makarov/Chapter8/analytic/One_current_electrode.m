clear all 
%   SYNTAX
%   One_current_electrode
%   DESCRIPTION
%   This script computes surface potential/voltage generated by a single current
%   electrode placed on top of a conducting layer backed by a
%   semi-infinite substrate - programs Eq. (8.46) of Chapter 8. The second
%   electrode is at infinity. The potential is computed at different
%   distances d from the electrode center
%
%   Authors: S.N. Makarov, G. N. Noetscher
%
%   Low-Frequency Electromagnetic Modeling for Electrical and Biological
%   Systems Using MATLAB, Sergey N. Makarov, Gregory M. Noetscher, and Ara
%   Nazarian, Wiley, New York, 2105, 1st ed.

%   Problem parameters
R           = 0.005;            %   Electrode radius, m
h           = 0.005;            %   Heights of layer 1, m
I0          = 0.002;            %   Amplitude of coil current, A
sigma1      = 0.1;              %   Conductivity of layer 1, S/m
sigma2      = 0.5;              %   Conductivity of layer 2, S/m
z           = 0;                %   Depth of measured voltage, m
step1       = 0.01/R;           %   Step size of alpha

sigma       = (sigma1-sigma2)/(sigma1+sigma2);    

J0 = I0/(pi*R^2);
d = [0:R/10:5*R];   % variable distance

%   Analytical solution
phi = zeros(1, length(d));
for m = 1:length(d)
    r           = d(m);                               
    alpha       = R/10:step1:500/R;
    Integral = step1*sum((besselj(0,alpha*r)).*...
        ((besselj(1,alpha*R))).*R./(alpha).*...
        ((1+sigma*exp(-2*alpha*h))./(1-sigma*exp(-2*alpha*h))));
    phi(m) = Integral;
end
phi = J0/sigma1*phi;

plot(d/R, phi, 'LineWidth', 2); grid on
xlabel('distance in terms of electrode radius'); ylabel('electric potential/voltage, V')

