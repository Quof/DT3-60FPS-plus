locationCheck(34)
global.mapTeleport=41

global.partySplit=1
instance_create(x,y,oWM_B_DmgZone)

with oCHAOS_Warmaster_Main
{
  activateBoss=1
}

var tempMplay;
tempMplay=findMusic(835)
playMusic(tempMplay,0,0)
