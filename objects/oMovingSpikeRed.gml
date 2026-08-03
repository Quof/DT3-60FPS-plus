#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
** Requires shiftTime, shiftMax, moveSpd, bScaling, bShowLine

** shiftTime: Starting time
** shiftMax: Max distance
** moveSpd: Move speed
** bScaling: If scaling along x or y
** bShowLine: Show movement line
** ** If true - Needs: offsetX, offsetY
*/
event_inherited()
sprite_index=sInvisibleSolidMask

//Enemy base statistics
initDir=_direction
bCanTakeDamage=false
bShowHealthBar=false

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
initDir=_direction
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  x+=moveSpd*cos(degtorad(_direction))*gDeltaTime
  y+=-moveSpd*sin(degtorad(_direction))*gDeltaTime
  if shiftTime>=shiftMax
  {
    shiftTime=0
    _direction+=180
  }
  else {shiftTime+=1*gDeltaTime}
}
correctSpeedDirection(self)
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(1)
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if image_xscale>1
{
  for(i=0;i<image_xscale;i+=1)
  {
    draw_sprite(sStaticSpikeRed,0,x+(i*16),y)
  }
}
if image_yscale>1
{
  for(i=0;i<image_yscale;i+=1)
  {
    draw_sprite(sStaticSpikeRed,0,x,y+(i*16))
  }
}
