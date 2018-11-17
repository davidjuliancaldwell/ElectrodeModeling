
infoStructSubj = struct();

infoStructSubj(1).sid = '3f2113';
infoStructSubj(1).numChans = 112;
infoStructSubj(1).extraString = 'data\d7\MATLAB_Converted\stimGeometry';
infoStructSubj(1).fileName = 'stimGeometry-';
infoStructSubj(1).stimChans = {[23 24], % train
    [1 15 16 23 24 65 72 73 74], %train
    [1 15 16 23 24 65 72 73 74], %train
    [23 15 16 22 24], % train
    [16 24 15 23], % train
    [16 24 15 23], % train
    [1 15 16 23 24 65 72 73 74], % signle pulse wide
    [24 23], % single pulse wide
    [24 23], % train
    [24 16], % train
    [16 24], % train
    [16 24] % single pulse short
    };
infoStructSubj(1).blocks = [];
infoStructSubj(1).badChans = {};
infoStructSubj(1).chanIntList = {};
infoStructSubj(1).rerefChans = [71 72 73 74 75 76 77 78 79 85 86 87 88 89 90 4 18];