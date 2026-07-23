#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite_index=sPlatTempFade
mask_index=sPlatTempFade
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_xscale*=16

if image_angle=270 {x-=1}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//requires: timeCurr, timeTillOn, timeTillOff
if global.gamePaused=false
{
  if oGame.time mod 2=0
  {
    if image_alpha=1 {image_alpha=0.5}
    else {image_alpha=1}
  }

  timeCurr+=1
  if mask_index=sNull
  {
    if timeCurr>=timeTillOn
    {
      mask_index=sPlatTempFade
      timeCurr=0
    }
  }
  else
  {
    if timeCurr>=timeTillOff
    {
      mask_index=sNull
      timeCurr=0
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if mask_index=sPlatTempFade
{
  draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}
