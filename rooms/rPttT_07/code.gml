locationCheck(76)
global.mapTeleport=0

gameScene=instance_create(0,0,oEvPttT)

var tempMplay;
if global.bossTrack=0 {tempMplay=findMusic(0)}
else if global.bossTrack=1 //Boss Fight: Parasitic Seed
{
  oPlayer1.x=160; oPlayer1.y=288
  tempMplay=findMusic(831)
  boss=instance_create(80,144,oParasiticSeed_Cave)
  boss.activateBoss=1
  storeStatus(1)
}
playMusic(tempMplay,0,0)
