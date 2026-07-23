#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_xscale=30

//Enemy base statistics
bShowHealthBar=0
bShowDamage=0
bCanTakeDamage=0
atkPower=12
moveSpd=2.25
laserScl=0
laserUp=1
moveDelay=30
laserProg=0
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

  moveDelay-=1
  if moveDelay<=0
  {
    if laserProg=0
    {
      y+=moveSpd
      if y>=288
      {
        laserProg=1
      }
    }
    else if laserProg=1
    {
      image_alpha-=0.1
      if image_alpha<=0.5 {bCanDealDamage=0}
      if image_alpha<=0 {instance_destroy()}
    }
  }
}
#define Collision_oIdentifier
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bCanDealDamage=true and global.gamePaused=false
{
  with oPlayer1
    hitPlayer(other.id)
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<30;i+=1)
{
  draw_sprite_ext(sDeci_BigLaser,0,i*16,y,1,image_yscale+laserScl,0,image_blend,image_alpha)
}
