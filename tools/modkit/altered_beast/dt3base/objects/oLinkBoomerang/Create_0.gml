event_inherited()
makeActive()
setCollisionBounds(-7,-7,7,7)

damageType="BOOMERANG"
weaponTag=1
atkLv=global.stLink_Boomerang[0]
atkPower=global.stLink_Boomerang[3]
atkPower=weaponDmgMod(0,atkPower)
global.recAtkNum+=1
stunTime=round(25+(global.stLink_Boomerang[3]*3.25))

maxVelocity=12
grabDist=24        //distance to the player before he can grab the boomerang when it is returning

bReturning=false   //whether the boomerang is returning to the player
returnTimeMax=25   //time till the boomerang returns to the player
returnTimer=0      //current time till the boomerang returns the to player

dirInfluenceTime=0 //current time till the player can no longer influence flight direction
//sound_play(snd_BoomerangThrow)
startSoundLoop=0   //time till sound loop start

if oPlayer1.image_xscale=-1
{
  image_xscale=-1
  x-=9
  xVel=-6
}
else
{
  x+=9
  xVel=6
}
