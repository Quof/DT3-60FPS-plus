#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_yscale=16

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
atkPower=16
solidColor=make_color_rgb(40,40,40)
movement=0
initSolid=0

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
mySolid=instance_create(x,y,oMovingSolid)
with mySolid
{
  viscidTop=1
  makeActive()
  sprite_index=sInvisibleSolidMask
  image_yscale=16
  visible=0
}
if image_xscale=1 {mySolid.x-=16}
initSolid=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if initSolid=1
  {
    if movement>0
    {
      mySolid.xVel=image_xscale
      x+=image_xscale
      movement-=1
      if movement=0
      {
        mySolid.xVel=0
        mySolid.x=x
        if image_xscale=1 {mySolid.x-=16}
      }
    }
  }
}
else
{
  mySolid.xVel=0
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(1)
draw_set_color(solidColor)
draw_rectangle(xstart,y,x,y+256,0)

for(i=0;i<16;i+=1)
{
  draw_sprite_ext(sprite_index,image_index,x,y+(i*16),image_xscale,1,image_angle,image_blend,image_alpha)
}
