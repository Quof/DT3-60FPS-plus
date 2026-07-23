locationCheck(15)

gameScene=instance_create(0,0,oEvCh6MainA)

var gameProgCheck;
gameProgCheck=string_char_at(global.gameGate3Prog,1)
if gameProgCheck!="1" //Spawn recovery objects
{
  instance_create(256,320,oHealingPost)
}

var tempMplay;
tempMplay=findMusic(304)
playMusic(tempMplay,0,0)
