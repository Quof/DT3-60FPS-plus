#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanTakeDamage=false
image_speed=0

//Enemy base statistics
eName="Kraid"
eLevel=23
maxLife=4100
life=maxLife
atkPower=10
resType[0]=2
resType[1]=2
resType[5]=4
affiliation=5
bIsBoss=true
bNoBonus=true
bossProgress=0
activateBoss=0

anim=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if sprite_index=sKraidArm
  {
    if anim=0
    {
      image_index+=animSpeed
      if image_index>=image_number-0.6 {anim=1}
    }
    else if anim=1
    {
      image_index-=animSpeed
      if image_index<=0.6 {anim=2}
    }
    else if anim>=2
    {
      anim+=1
      if anim=9 {anim=0}
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
