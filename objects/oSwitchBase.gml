#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
parent="switch"
event_inherited()
bShowHealthBar=false
bShowDamage=false
bCanDealDamage=false
bActive=true
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
enemyStepEvent()
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bTakingDamage=false
{
  if global.switchTrigger[objectNum]=false
  {
    if elementHit=0 //any attack will activate switch
    {
      playSound(global.snd_SwitchHit,0,1)
      global.switchTrigger[objectNum]=1
    }
    else //only a particular element will activate switch
    {
      if other.elementType=elementHit
      {
        playSound(global.snd_SwitchHit,0,1)
        global.switchTrigger[objectNum]=1
      }
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,global.switchTrigger[objectNum],x,y,image_xscale,1,image_angle,image_blend,image_alpha)
