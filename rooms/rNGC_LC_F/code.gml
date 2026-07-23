locationCheck(57)

gameScene=instance_create(0,0,oEvCh14MainA)
rmLight=instance_create(0,0,oSurfLightD)

if global.gameProgress<=3260 and global.bossTrack<2 //If player resets boss fight from game over menu
{
  oIdentifier.bCanScan=0; oIdentifier.deactivate=1
  global.charScan[0]=0; global.charScan[1]=0
  if global.optShowHUD<2 {global.optShowHUD+=2}
  global.activeAbility[0]=0; global.activeAbility[1]=0
  global.hasShoes[2]=1; global.hasShoes[3]=1
  for(i=0;i<5;i+=1) {global.hasAbilToken[i]=1}
}

if global.gameProgress>=3270 and global.bBossGallery=0
{
  tile_layer_hide(999990)
  with (GID(314507)) {instance_destroy()}
}

var tempMplay;
if global.bossTrack=0 {tempMplay=findMusic(16)}
else if global.bossTrack=1 or global.bossTrack=2 //Boss Fight: Malevolence
{
  global.hudLink_Arrows[0]=global.hudLink_Arrows[1]
  global.hudBelmont_WeaponEn[0]=global.hudBelmont_WeaponEn[1]
  global.hudSamus_Missiles[0]=global.hudSamus_Missiles[1]
  tempMplay=findMusic(813)
  oPlayer1.x=240; oPlayer1.y=1344
  var boss;
  boss=instance_create(240,1264,oMalevolence)
  boss.activateBoss=1
}
playMusic(tempMplay,0,0)
