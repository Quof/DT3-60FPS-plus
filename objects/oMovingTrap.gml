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
  sprite_index=sWS_SpikeBall
  atkPower=12
}
else {atkPower=10}
bCanTakeDamage=false
bShowHealthBar=false
initDir=direction
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
initDir=direction
if global.location=58 or global.location=107 {sprite_index=sG6MovingSpike}
if room=rBT_ZeroA or room=rBT_ZeroB or room=rBT_ZeroC or room=rBT_ZeroD {sprite_index=sG6MovingSpike}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if sprite_index=sG6MovingSpike {image_angle+=15}
  x+=moveSpd*cos(degtorad(direction))
  y+=-moveSpd*sin(degtorad(direction))
  if shiftTime>=shiftMax
  {
    shiftTime=0
    direction+=180
  }
  else {shiftTime+=1}
}
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
