locationCheck(34)
global.mapTeleport=41

abilSetRemove(1)
global.hasShoes[0]=2
global.hasShoes[1]=2
global.hasAbilToken[1]=4
global.activeAbility[0]=1
charSwitcher(0)

instance_create(0,0,oBTB_Ev_HelmetheadEX)

if global.bossTrack=0
{
  var tempMplay;
  tempMplay=findMusic(0)
  playMusic(tempMplay,0,0)
}
if global.bossTrack=1
{
  var tempMplay;
  tempMplay=findMusic(802)
  playMusic(tempMplay,0,0)
}
