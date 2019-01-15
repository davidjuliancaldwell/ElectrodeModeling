function symmetryStruct = shrink_symmetry(symmetryStruct)

xSize = 13;
ySize = 10;

midX = floor(size(symmetryStruct.gridData,1)/2);
midY = floor(size(symmetryStruct.gridData,2)/2);
x1 = floor(xSize/2);
x2 = ceil(xSize/2);
y1 = floor(ySize/2);
y2 = ceil(ySize/2);

newX = [midX-x1+1:midX+x2];
newY = [midY-y1+2:midY+y2+1];

symmetryStruct.gridDataShrunk = symmetryStruct.gridData(newX,newY,:);
symmetryStruct.gridDataAvgShrunk = symmetryStruct.gridDataAvg(newX,newY);
symmetryStruct.gridDataLRavgShrunk = symmetryStruct.gridDataLRavg(newX,newY);
symmetryStruct.gridDataUDavgShrunk = symmetryStruct.gridDataUDavg(newX,newY);
symmetryStruct.gridDataLRUDavgShrunk = symmetryStruct.gridDataLRUDavg(newX,newY);

end