#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bDestroyOnDeactivate=true
inactiveDist=128

//Enemy base statistics
eName="Metal Wing"
eLevel=17
maxLife=80
life=maxLife
pointWorth=18
atkPower=5
resType[0]=2
resType[1]=2
resType[2]=4
resType[5]=2
stunResist=1
baseItemChance=65
baseDropIndex=70
pickupDropMod=10
moneyWorth=1
affiliation=4
hitSound=global.snd_EnemyHitMM
dieSound=0
dieEffect=0
initDir=0
runAcc=3
inactiveDist*=1.25

flameFrm=0
flameAng=0
bSpotted=0

jeremyText="Oh look, it's another standard one-way moving AI type. It has crappy armor and speed. Heck, they only drop green Internetz too."
chaoText="It's an enemy that's meant to direct you places. They have a habit of surprising you over gaps."
devText="The fact that this, Overdrive Ostrich, and Storm Eagle are all birds is actually a coincidence."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0 and life>0
  {
    if initDir=false
    {
      xVel=runAcc
      if x>oPlayer1.x
        xVel*=-1

      if xVel>0
      {
        image_xscale=1
        flameAng=270
      }
      else
      {
        image_xscale=-1
        flameAng=90
      }
      initDir=true
    }
    x+=xVel
  }
  else if life<=0
  {
    playSound(global.snd_EnemyDieMM,0,1,1)
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sMMExplosion
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    instance_destroy()
  }
  enemyStepEvent()
}

if bSpotted=0
{
  if checkScreenArea(x,y,2)=1
  {
    global.recBirdsSeen+=1
    bSpotted=1
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
flameFrm+=0.5
draw_sprite_ext(sMM_SEPEffect,flameFrm,x-(15*image_xscale),y+3,1,1,flameAng,c_white,image_alpha)
