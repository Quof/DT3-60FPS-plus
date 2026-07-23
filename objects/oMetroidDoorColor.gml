#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
hitTime=0
flashTime=0
hitDelay=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if hitDelay>0 {hitDelay-=1}

  if flashTime>0 //Flash when hit with a missile
  {
    flashTime-=1
    if flashTime mod 2=0
    {
      if image_blend=c_red {image_blend=c_white}
      else {image_blend=c_red}
    }

    if flashTime=0 {image_blend=c_white}
  }

  if hitTime>=5
  {
    hitTime+=1
    if hitTime=6
    {
      playSound(global.snd_MetDoorOpen,0,1,1)
      image_index=1
    }
    else if hitTime=9 {image_index=2}
    else if hitTime=12 {image_index=3}
    else if hitTime=15
    {
      myHolder.sprite_index=sNull
      instance_destroy()
    }
  }
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if type=0 and hitTime=0 {hitTime=5}
}
#define Collision_oSamusMissile
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if type=0 and hitTime=0 {hitTime=5} //Normal (anything)
  if type=1 and hitTime<=4 and hitDelay=0 //Red (5 missiles or 1 super missile)
  {
    if other.sprite_index=sSamusSuperMissile {hitTime=5}
    hitTime+=1; flashTime=15; hitDelay=2; image_blend=c_red
  }
  else if type=2 and hitTime=0 //Green (1 super missile)
  {
    if other.sprite_index=sSamusSuperMissile {hitTime=5}
  }
}
