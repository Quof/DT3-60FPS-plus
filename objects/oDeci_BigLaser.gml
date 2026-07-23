#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_xscale=24

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
atkPower=16
laserScl=0
laserUp=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if laserUp=1
  {
    laserScl+=0.01
    if laserScl>=0.15 {laserUp=0}
  }
  else
  {
    laserScl-=0.01
    if laserScl<=0 {laserUp=1}
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<24;i+=1)
{
  draw_sprite_ext(sDeci_BigLaser,0,576+(i*16),y,1,image_yscale+laserScl,0,image_blend,image_alpha)
}
