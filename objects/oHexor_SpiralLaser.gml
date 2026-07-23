#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

sprite_index=sHexor_ShroudLaser
image_angle=270
image_xscale=352
image_yscale=1.5
size=2

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bCanDealDamage=false
atkPower=oHexor_Main.atkPower

phase=0
atkProg=0
atkTime=0
warnArea=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  phase+=0.02

  if atkProg=0
  {
    atkTime+=1
    if atkTime<=11 {warnArea+=1}
    else if atkTime>=30
    {
      bCanDealDamage=true
      atkTime=0; atkProg+=1
    }
  }
  else if atkProg=1
  {
    atkTime+=1
    if atkTime>=30
    {
      instance_destroy()
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if atkProg=0
{
  draw_set_alpha(0.2)
  draw_set_color(c_red)
  draw_rectangle(x-warnArea,0,x+warnArea,oHexor_Main.yGround,0)
}
else if atkProg=1
{
  draw_sprite_wave_fixed(sHexor_SpiralLaser,0,x,y,1,12,3,phase)
  draw_sprite_wave_fixed(sHexor_SpiralLaser,0,x,y+90,1,12,3,phase)
  draw_sprite_wave_fixed(sHexor_SpiralLaser,0,x,y+180,1,12,3,phase)
  draw_sprite_wave_fixed(sHexor_SpiralLaser,0,x,y+270,1,12,3,phase)
}
