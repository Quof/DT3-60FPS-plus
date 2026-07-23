locationCheck(76)
//global.bCanUseEsc=0
SS_SetSoundFreq(global.msc_OminousHall,22050)

gameScene=instance_create(0,0,oEvCh21MainA)

abilSetRemove(1)
charSwitcher(3)

var myColl;
myColl=instance_create(224,-1756,oInvisibleSolid)
myColl.image_xscale=2; myColl.image_yscale=12
oPlayer1.x=240; oPlayer1.y=-1628

var tempMplay;
if global.bossTrack=0 {tempMplay=findMusic(0)}
else if global.bossTrack=1 //Boss Fight: Virus Parasite
{
  tempMplay=findMusic(832)
  oVirusParasite_Main.activateBoss=1
}
playMusic(tempMplay,0,0)
