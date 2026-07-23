locationCheck(40)
if global.gameProgress>=2550 {global.mapTeleport=15}

gameScene=instance_create(0,0,oEvCh10MainA)
musicScene=instance_create(0,0,oEvCh10VaultEnd)

var tempMplay;
if global.bossTrack=0
{
  tempMplay=findMusic(11)
  global.activeAbility[0]=1
  global.activeAbility[1]=1
  for(i=0;i<4;i+=1)
  {
    global.hasShoes[i]=2
  }
}
if global.bossTrack=101
{
  tempMplay=findMusic(12)
  global.activeAbility[0]=0
  global.activeAbility[1]=0
  oPlayer1.visible=0
  oPlayer1.x=384; oPlayer1.y=208
  instance_create(oIdentifier.x,oIdentifier.y,oChaoShield)
}

playMusic(tempMplay,0,0)
