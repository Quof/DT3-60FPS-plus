locationCheck(10)

gameScene=instance_create(0,0,oEvCh4MainA)
//sideChat=instance_create(0,0,oEvCh4SideA)
blackTop=instance_create(0,0,oG2_BlackTop)

if global.gameProgress=700
{
  var tNewBarrier;
  tNewBarrier=instance_create(640,240,oSwitchBarrier)
  tNewBarrier.switchID=140072
}

var tempMplay;
tempMplay=findMusic(204)
playMusic(tempMplay,0,0)
