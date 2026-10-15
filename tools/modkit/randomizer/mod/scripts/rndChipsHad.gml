//Randomizer: the items' placement (rndGenerate, rndERPlay) counting the Program Chips as had from the start, as they are
//with Chip Randomizer off (global.rndGHave: the logic's numbers, rndChipBase+gate)
var g;
if global.rndChipMode=1 {exit}
for(g=1;g<=global.rndChipN;g+=1) {global.rndGHave[global.rndChipBase+g]=1}
