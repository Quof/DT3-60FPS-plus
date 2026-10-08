//normalized gallery change (added): every way out of a boss gallery fight comes back here, so the player's real build
//goes back in here (oBossGalleryDoor kept it aside while the fight used a normalized one)
scrNormState(1)

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
//normalized gallery change (added): the NORMALIZED mode lever, floating at waist height over the ledge left of the
//entrance, with its sign to the right of it; with the lever on, no sword equipment in here
instance_create(12,1282,oGalleryLever)
var tNormSign;
tNormSign=instance_create(50,1312,oSignPost)
tNormSign.stringToShow='This switch turns on "NORMALIZED" mode, which scales your character upgrades per fight to what you would have had during the original encounter. Scoring is based on hits taken. Sword equipment is disallowed.'
tNormSign.signSize=3
if global.galleryNormalized=1 {scrNormSwordsOff()}

global.gamePaused=0
global.bSoundCanPlay=1
global.partySplit=0
global.mapTeleport=0
global.bCanSave=1
global.currentBoss=""
global.bossTrack=0

background_hspeed[0]=1 //raw 30fps units: oGame scales background scrolling
background_vspeed[0]=1

var tempMplay;
tempMplay=findMusic(1023)
playMusic(tempMplay,0,0)
