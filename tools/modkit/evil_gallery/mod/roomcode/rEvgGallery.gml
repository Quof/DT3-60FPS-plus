//Evil Boss Gallery: the evil gallery's creation code (the build's copy of rBossGallery, its doors oEvgDoor): the Boss
//Gallery's own (every way out of a gallery fight comes back to it), with no evil fight going on any more
//(global.evgFight), the gloom over it (oEvgGloom) and the gate back to the Boss Gallery (oEvgGate)
global.evgFight=0

//(the player's real build back, if the fight used a normalized one: rBossGallery's)
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

//Fade in (and the results of the fight just won: oEvBossGallery, from evgTally's globals)
bossRoom=instance_create(0,0,oEvBossGallery)
if global.bCanSave=0 {bossRoom.fadeAlpha=0.8}
else {bossRoom.fadeAlpha=0}
infiniteDash=instance_create(0,0,oInfiniteDash)
//the NORMALIZED mode lever, as in the Boss Gallery
instance_create(12,1282,oGalleryLever)
var tNormSign;
tNormSign=instance_create(50,1312,oSignPost)
tNormSign.stringToShow='This switch turns on "NORMALIZED" mode, which scales your character upgrades per fight to what you would have had during the original encounter. Sword equipment is disallowed.'
tNormSign.signSize=3
if global.galleryNormalized=1 {scrNormSwordsOff()}

instance_create(0,0,oEvgGloom)
instance_create(640,1344,oEvgGate)

global.gamePaused=0
global.bSoundCanPlay=1
global.partySplit=0
global.mapTeleport=0
global.bCanSave=1
global.currentBoss=""
global.bossTrack=0

background_hspeed[0]=-1 //raw 30fps units: oGame scales background scrolling
background_vspeed[0]=-1

var tempMplay;
tempMplay=findMusic(1023)
playMusic(tempMplay,0,0)
