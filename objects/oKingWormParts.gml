#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanTakeDamage=false

//Enemy base statistics
eName="King Worm"
eLevel=23
maxLife=4000
life=maxLife
atkPower=8
resType[0]=2
resType[1]=2
resType[5]=4
affiliation=5
bIsBoss=true
bNoBonus=true
bossProgress=0
activateBoss=0

initVars=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=10 or type=20 {moveTick=mySeg*3; sprayTime=mySeg*32}
for(i=0;i<12;i+=1)
{
  throwDist[i]=0.25
}
myThrow=mySeg
initVars=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if initVars=1
  {
    if type=10 or type=20
    {
      moveTick+=0.5
      x+=cos(moveTick/5)

      if oKingWorm.life>0 and mySeg>2
      {
        if oKingWorm.bSpraySpikes=1
        {
          sprayTime+=1
          if sprayTime>=oKingWorm.sprayDelay
          {
            var tAtk;
            tAtk=instance_create(x,y,oMetBulletGrav)
            tAtk.sprite_index=sKingWormSpike; tAtk.atkPower=atkPower
            if type=10 {tAtk.xVel=2+throwDist[myThrow]} else if type=20 {tAtk.xVel=-2-throwDist[myThrow]}
            tAtk.yVel=-2.5; tAtk.grav=0.2
            myThrow+=1
            if myThrow=12 {myThrow=0}
            sprayTime=0
          }
        }
      }
    }
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if life>0 {redDmgHit(0)}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.bCanPierce=0
{
  with other
  {
    instance_destroy()
  }
}
