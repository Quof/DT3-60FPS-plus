#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: decayTime,bulletSpeed
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
init=0
_direction=0
_speed=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if init=0 {init=1}
  if decayTime!=-100
  {
    decayTime-=1*gDeltaTime
    if decayTime<=0 {instance_destroy()}
  }

  if place_meeting(x,y,oNightmareEffect) {_speed=bulletSpeed/2}
  else {_speed=bulletSpeed}
  image_angle=_direction
}
else {_speed=0}
//correctSpeedDirection(self)
x+=cos(degtorad(_direction))*_speed*gDeltaTime; y-=sin(degtorad(_direction))*_speed*gDeltaTime //60fps change: the same move as
//correctSpeedDirection without the script call (Create sets both): hundreds of these can be out at once (e.g. Shadow Eura's
//blood volleys), and at 60/120fps the call's cost every frame for each of them lagged
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if decayTime=-100 and init=1
  instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if sprite_index=sSparkyLightning
{
  draw_sprite_ext(sprite_index,image_index,x,y,1.5,1.5,image_angle,image_blend,0.33)
  draw_sprite_ext(sprite_index,image_index,x,y,1.25,1.25,image_angle,image_blend,0.66)
}
else if sprite_index=sEvirSpikeball
{
  draw_sprite_ext(sprite_index,image_index,x,y,1.5,1.5,image_angle,c_orange,0.33)
  draw_sprite_ext(sprite_index,image_index,x,y,1.25,1.25,image_angle,c_orange,0.66)
}
draw_self()
