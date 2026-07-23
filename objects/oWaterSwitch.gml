#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite_index=sSwitchH_Icon
image_speed=0
image_index=2
activated=0

if wLvlTarget=176
  numDisp="1"
else if wLvlTarget=368
  numDisp="2"
else if wLvlTarget=640
  numDisp="3"
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if activated=0 and other.bCanHitSwitch=1 and other.weaponTag<100
{
  playSound(global.snd_SwitchHit,0,1,1)
  if global.location=10 //Gate 2: Water Palace
    global.wpWaterLevel=wLvlTarget
  oWaterVolume.targetWLevel=wLvlTarget
  with oWaterSwitch
    activated=0
  activated=1
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite(sSwitchHolder,image_index,x,y)
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

if global.location=10
{
  draw_set_alpha(1)
  if numDisp="1"
  {
    draw_set_color(c_black)
    draw_rectangle(x-4,y-6,x+3,y-4,0)
    draw_rectangle(x-4,y-2,x+3,y,0)
    draw_rectangle(x-4,y+2,x+3,y+4,0)
    draw_set_color(c_teal)
    draw_line(x-3,y-5,x+3,y-5)
    draw_line(x-3,y-1,x+3,y-1)
    draw_line(x-3,y+3,x+3,y+3)
  }
  else if numDisp="2"
  {
    draw_set_color(c_black)
    draw_rectangle(x-4,y-2,x+3,y,0)
    draw_rectangle(x-4,y+2,x+3,y+4,0)
    draw_set_color(c_teal)
    draw_line(x-3,y-1,x+3,y-1)
    draw_line(x-3,y+3,x+3,y+3)
  }
  else if numDisp="3"
  {
    draw_set_color(c_black)
    draw_rectangle(x-4,y+2,x+3,y+4,0)
    draw_set_color(c_teal)
    draw_line(x-3,y+3,x+3,y+3)
  }
}
