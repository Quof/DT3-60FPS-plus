//Boomerang Vision: low power (30 base?) big stun. Skill base: press boomerang button when it's close to catch it, empowering your next throw with triple damage and piercing. Replaces arrows with a certain equipment piece
//only one boomerang can be out at a time, if you miss the catch it has to travel all the way off screen before it expires. This ensures you can't stunlock enemies, either you miss the catch and wait, or catch and have to
//wait for the boomerang to pierce through everything for a bit.

event_inherited()
makeActive()
setCollisionBounds(-7,-7,7,7)

damageType="PIERCE"
if global.TrueEnabled=1 and global.LinkArrowTrue=1
{
    damageType="TRUE"
}
weaponTag=1
atkLv=global.stLink_Arrow[0]
var tCrossbow;
tCrossbow=1
tAlterOmen=0
tArrowBomb=0
hasBomb=0
baseDamage=20 + (oPlayer1.boomerLevel*5)
if global.alterEquip=0
{
    for(i=0;i<3;i+=1)
    {
      if global.equipJerry[i]=36 //Equipment: Crossbow
      {
        tCrossbow=1.5
        break;
      }
    }
}

if global.alterEquip=1
{
    for(i=0;i<3;i+=1)
    {
      if global.equipJerry[i]=27 {tAlterOmen=1}
      if global.equipClaire[i]=27 {tAlterOmen=1}
      if global.equipJerry[i]=36 {tArrowBomb=1}
    }
}
if tAlterOmen=0
{
    atkPower=round((baseDamage+(round(global.stLink_Arrow[0]*1.5)+global.skillTree[9]))*tCrossbow)
}
else
{
    atkPower=round(baseDamage+(round((global.stLink_Arrow[0]-10)*1.5)))
}
atkPower=weaponDmgMod(0,atkPower)
global.recAtkNum+=1
stunTime=round(20+(global.stLink_Arrow[0]*2))

maxVelocity=12 + min((oPlayer1.boomerLevel*1), 5)
grabDist=24        //distance to the player before he can grab the boomerang when it is returning

bReturning=false   //whether the boomerang is returning to the player
bMissed=false      //once it passes player just keep going
missFlyDuration=30
endVelX=0
endVelY=0
returnTimeMax=20-min((1*oPlayer1.boomerLevel), 5)   //time till the boomerang returns to the player
returnTimer=0      //current time till the boomerang returns the to player

dirInfluenceTime=0 //current time till the player can no longer influence flight direction
//sound_play(snd_BoomerangThrow)
startSoundLoop=0   //time till sound loop start
bCanPierce=true
isCharged=0
if oPlayer1.image_xscale=-1
{
  image_xscale=-1
  x-=9
  xVel=-6
  originX = oPlayer1.x + 300
  originY = oPlayer1.y - 24
}
else
{
  x+=9
  xVel=6
  originX = oPlayer1.x - 300
  originY = oPlayer1.y - 24
}
weaponRehitTime=1000
bCanCatch=true
oPlayer1.boomerTimer = 1000
