#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
activated=0
timeLeft=15
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if activated=1
  {
    timeLeft-=1
    if timeLeft<=0
    {
      activated=0
      timeLeft=15
      image_speed=0
      image_index=0
    }
  }
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if activated=0 and other.bCanHitSwitch=1 and other.weaponTag<100
{
  playSound(global.snd_SwitchHit,0,0.9,1)
  image_speed=1
  activated=1
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite(sprite_index,image_index,x,y)
