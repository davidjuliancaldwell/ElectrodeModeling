
infoStructSubj = struct();

infoStructSubj(1).sid = 'a7a181';
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
infoStructSubj(1).blocks = [1,2,3,4,5,6,7,8,9,10,11,12];
infoStructSubj(1).badChans = {[47 48 51 52 82:96],
    [47 48 51 52 82:96],
    [47 48 51 52 82:96],
    [82:96],% empty
    [82:96],
    [82:96],
    [82:96],
    [82:96],
    [82:96],
    [82:96],
    [82:96],
    [82:96]
    };
infoStructSubj(1).chanIntList = {[],
    [5 6 7 8 13 14 21 22 29 30 38 39 40],
    [5 6 7 8 13 14 21 22 29 30 38 39 40],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    };
infoStructSubj(1).rerefChans = [71 72 73 74 75 76 77 78 79 85 86 87 88 89 90 4 18];