function [outputStructure] = convert_mats_to_struct(meanMat,stdMat,stdEveryPoint,...
    stimChans,currentMat,numberStims,extractCell,sid,subjectNum,data,t)


outputStructure.stimChans = stimChans;
outputStructure.currentMat = currentMat;
outputStructure.meanMat = meanMat;
outputStructure.stdMat = stdMat;
outputStructure.numberStims = numberStims;
outputStructure.stdEveryPoint = stdEveryPoint;
outputStructure.extractCell = extractCell;
outputStructure.sid = sid;
outputStructure.subjectNum = subjectNum; 
outputStructure.t = t;
outputStructure.data = data; 

end