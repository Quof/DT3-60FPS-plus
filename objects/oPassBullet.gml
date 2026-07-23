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

  if place_meeting(x,y,oNightmareEffect) {speed=bulletSpeed/2}
  else {speed=bulletSpeed*gDeltaTime}
  image_angle=direction
}
else {speed=0}
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
