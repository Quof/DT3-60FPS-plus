locationCheck(9)

global.bCanUseEsc=1

if global.activeCharacter>=2 {charSwitcher(1)}
abilSetRemove(1)
abilSetRemove(0)

scrFullStatRestore()

if global.bBossGallery=0
{
  storeStatus(0)
}
global.bBossGallery=1

if global.optShowDamage>=2 //From Leviathan
{
  global.optShowDamage-=2
  global.optEnemyHP-=2
}

//Fade in
bossRoom=instance_create(0,0,oEvBossGallery)
if global.bCanSave=0 {bossRoom.fadeAlpha=0.8}
else {bossRoom.fadeAlpha=0}
infiniteDash=instance_create(0,0,oInfiniteDash)

global.gamePaused=0
global.bSoundCanPlay=1
global.partySplit=0
global.mapTeleport=0
global.bCanSave=1
global.currentBoss=""
global.bossTrack=0

var tempMplay;
tempMplay=findMusic(1023)
playMusic(tempMplay,0,0)
