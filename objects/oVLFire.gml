#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="ELEMENTAL"
weight=50
swirlProg=0
glowScl=1.1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  glowScl+=0.033*gDeltaTime
  if glowScl>=1.6 {glowScl=1.1}
  if yVel<0 {x+=xVel*gDeltaTime}
  else if yVel>0.4
  {
    swirlProg+=1*gDeltaTime
    if swirlProg>=1 and swirlProg<=3 {x+=1*gDeltaTime}
    else if swirlProg>=4 and swirlProg<=6
    {
      x-=1*gDeltaTime
      if swirlProg=6 {swirlProg=0}
    }
  }

  y+=yVel*gDeltaTime
  if yVel<3
  yVel+=grav*gDeltaTime
  if y>room_height+16 {instance_destroy()}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
magicInterpDrawStart()
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*glowScl,image_yscale*glowScl,image_angle,image_blend,0.25)
event_inherited()
magicInterpDrawEnd()
