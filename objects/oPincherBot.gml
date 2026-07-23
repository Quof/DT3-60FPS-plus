#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-8,-22,8,-1)
image_speed=0.3

//Enemy base statistics
eName="Pincher Bot"
eLevel=10
maxLife=100
life=maxLife
pointWorth=8
atkPower=8
stunResist=10
baseItemChance=10
pickupDropMod=50
moneyWorth=0
bGenEnemy=1
dieSound=2
dieEffect=2

initDir=0
turnTime=0
if global.location=99 {runAcc=1.75}
else {runAcc=1.25}
returnToMovement=0

jeremyText="What a curious robot. That drill is super strong. You don't want to be getting hit by that, and when I say super strong, I mean it can break through a very specific block that isn't that hard to figure out since it's pretty much spelled out for you. Oh yeah, they're weird in that even enemy fire will destroy them."
chaoText="Oh oh, I want one of these too! Look at them, they're kind of cute!#A little nuance in the code I found is the doors that let them out will only allow one at a time so don't lose track of them."
devText="I don't feel the puzzles in DT1 were all that great. I even designed the spell system to be both combat and puzzle oriented, but never really took full advantage of it. I'm aimed to fix that with DT3. I feel my players will be the better judge of whether or not I pull it off well."
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if initDir=0
  xVel=runAcc
else
  xVel=-runAcc
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bActive=0 {makeEnemyActive(0)}

  if bActive=true and stunnedTime=0
  {
    //---------- Movement ----------
    if xVel>0
      image_xscale=1
    else if xVel<0
      image_xscale=-1

    yVel+=0.3
    if isCollisionBottom(1)
      yVel=0
    if isCollisionLeft(1)
    {
      if collision_point(x-12,y-10,oWrenchBlock,1,1)
      {
        if oGame.time mod 5=0 {if checkScreenArea(x,y,48)=1 {playSound(global.snd_Spark,0,0.91,62000)}}
        xVel=0
        var tEffect,tDir;
        tDir=random(360)
        tEffect=instance_create(x-12,y-10,oEffectB)
        tEffect.type=3; tEffect.sprite_index=sMMchargeEffect1; tEffect.newBlend=1
        tEffect.image_alpha=1; tEffect.image_xscale=1.5+random(0.5); tEffect.image_yscale=0.66; tEffect.fadeSpd=0.1
        tEffect.direction=tDir; tEffect.image_angle=tDir; tEffect.speed=2+random(4); tEffect.friction=0.2+random(0.2)
        tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
        returnToMovement=1
      }
      else {xVel=runAcc}
    }
    else
    {
      if returnToMovement=1 {xVel=-runAcc; returnToMovement=0}
    }

    if isCollisionRight(1)
    {
      if collision_point(x+12,y-10,oWrenchBlock,1,1)
      {
        if oGame.time mod 5=0 {if checkScreenArea(x,y,48)=1 {playSound(global.snd_Spark,0,0.91,62000)}}
        xVel=0
        var tEffect,tDir;
        tDir=random(360)
        tEffect=instance_create(x+12,y-10,oEffectB)
        tEffect.type=3; tEffect.sprite_index=sMMchargeEffect1; tEffect.newBlend=1
        tEffect.image_alpha=1; tEffect.image_xscale=1.5+random(0.5); tEffect.image_yscale=0.66; tEffect.fadeSpd=0.1
        tEffect.direction=tDir; tEffect.image_angle=tDir; tEffect.speed=2+random(4); tEffect.friction=0.2+random(0.2)
        tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
        returnToMovement=2
      }
      else {xVel=-runAcc}
    }
    else
    {
      if returnToMovement=2 {xVel=runAcc; returnToMovement=0}
    }

    if isCollisionSolid()
      y-=2

    moveTo(xVel,yVel)
    if y>room_height+24
      instance_destroy()
  }
  enemyStepEvent()
}
#define Collision_oTrapBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.size=1
{
  with other
    instance_destroy()
}
var tEffect;
tEffect=instance_create(x,y-8,oEffect)
tEffect.sprite_index=sRobotExplosion; tEffect.image_speed=0.5
tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
instance_destroy()
#define Collision_oEProjectileBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.size=1
{
  with other
    instance_destroy()
}
var tEffect;
tEffect=instance_create(x,y-8,oEffect)
tEffect.sprite_index=sRobotExplosion; tEffect.image_speed=0.5
tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
instance_destroy()
