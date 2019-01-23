ptInterest = [0,0,1];


%% gibson

    
%% frank
R = 6;

a = 6;
b = 6;
denom = (rA + R - (b * B));
numer = (rA + R - (a * B));
V = (I/(4*pi*gamma)) * ((2/rA) - 2(r/rA) + (1/R)*ln((numer/denom)))