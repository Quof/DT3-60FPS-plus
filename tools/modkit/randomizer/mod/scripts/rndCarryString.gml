//Randomizer: the states the room logic carries from room to room, as the player has them now, for the trackers (the
//state file's carry, rndVisitArrive keeping them as the player comes into a room): the red and blue switches' (rb), the
//Water Palace's water level (water: 1-3, by global.wpWaterLevel as its switches set it, roomdata.py's WATER_LEVELS) and
//the Forest Palace's crystals (crystal1-3: global.mySegmentCheck). Written with ` for the quotes (rndTrackWrite)
var w;
w="2"
if global.wpWaterLevel=176 {w="1"}
else if global.wpWaterLevel=640 {w="3"}
return "`rb`:`"+string(global.rbSwitchBlueOn>0)+"`,`water`:`"+w+"`,`crystal1`:`"+string(global.mySegmentCheck[0]>0)+"`,`crystal2`:`"+string(global.mySegmentCheck[1]>0)+"`,`crystal3`:`"+string(global.mySegmentCheck[2]>0)+"`"
