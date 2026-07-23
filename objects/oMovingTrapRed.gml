#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
** Requires shiftTime, shiftMax, moveSpd, bShowLine

** shiftTime: Starting time
** shiftMax: Max distance
** moveSpd: Move speed
** bShowLine: Show movement line
** ** If true - Needs: offsetX, offsetY
*/
event_inherited()

//Enemy base statistics
if global.location=99
{
  if room=rWarshipM {atkPower=10}
  else if room=rWarshipZ_A or room=rWarshipZ_B or room=rWarshipZ_C or room=rWarshipZ_D or room=rWarshipZ_H
  {
    atkPower=14
  }
  else
  {
    sprite_index=sWS_RedSpikeBall
    atkPower=12
  }
}
else {atkPower=10}
damageType="ELEMENTAL"
initDir=direction
bCanTakeDamage=false
bShowHealthBar=false

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
initDir=direction
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  x+=moveSpd*cos(degtorad(direction))
  y+=-moveSpd*sin(degtorad(direction))
  if shiftTime>=shiftMax
  {
    shiftTime=0
    direction+=180
  }
  else {shiftTime+=1}
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(0)
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bShowLine=1
{
  draw_set_alpha(0.5)
  draw_set_color(c_black)
  draw_line(xstart,ystart,xstart+((shiftMax*moveSpd)*cos(degtorad(initDir))),ystart+(-(shiftMax*moveSpd)*sin(degtorad(initDir))))
}
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
