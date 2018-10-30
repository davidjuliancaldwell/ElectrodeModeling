function [outputStructure] = convert_mats_to_struct(meanMat,stdMat,stdEveryPoint,...
    stimChans,currentMat,numberStims,extractCell)


outputStructure.stimChans = stimChans;
outputStructure.currentMat = currentMat;
outputStructure.meanMat = meanMat;
outputStructure.stdMat = stdMat;
outputStructure.numberStims = numberStims;
outputStructure.stdEveryPoint = stdEveryPoint;
outputStructure.extractCell = extractCell;

end