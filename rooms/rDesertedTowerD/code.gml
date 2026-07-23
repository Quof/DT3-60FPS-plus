locationCheck(50)

gameScene=instance_create(0,0,oEvCh14MainA)
if global.gameOptDT=1 {global.gameOptDT=2}

var tempMplay;
if global.bossTrack=0 {tempMplay=findMusic(8)}
else if global.bossTrack=1 //Boss Fight: Sand Crawler
{
  tempMplay=findMusic(813)
  var boss;
  oPlayer1.x=320; oPlayer1.y=784
  boss=instance_create(320,room_height+128,oSandCrawlerBoss)
  boss.activateBoss=1
  storeStatus(1)
}
playMusic(tempMplay,0,0)
