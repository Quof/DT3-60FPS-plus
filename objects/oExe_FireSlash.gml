#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
playSound(global.snd_PortalCreate,0,0.95,1)

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bCanDealDamage=false
bIsBoss=true
bNoBonus=true
size=2
atkPower=9
bCanBeBlocked=1
bParryOpp=1
blockCost=60

atkProg=0
atkTime=0
myRad=32
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  x=oTheExecutive.x+(myScl*50)
  y=oTheExecutive.y

  if atkProg=0
  {
    myRad-=1
    if myRad<=0
    {
      playSound(global.snd_DeathSlash,0,1,1)
      image_xscale*=2
      bCanDealDamage=1
      atkProg=1
    }
  }
  else if atkProg=1
  {
    atkTime+=1
    if atkTime=2 {image_index=1}
    else if atkTime=3 {image_index=2}
    else if atkTime=4 {image_index=3}
    else if atkTime=6 {image_index=4}
    else if atkTime=7 {instance_destroy()}
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
  for(i=0;i<3;i+=1)
  {
    draw_sprite_ext(sHexor_GanonOrb,0,x,y,0.5+(i*1.15),0.5+(i*1.15),image_angle,image_blend,0.3-(0.05*i))
  }

  draw_set_alpha(0.75)
  draw_set_color(c_white)
  draw_circle(x,y,myRad,1)
}
else if atkProg=1
{
  draw_self()
}
