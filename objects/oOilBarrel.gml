#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
y+=1
makeActive()
setCollisionBounds(-7,-15,7,-1)
image_speed=0.1

//Enemy base statistics
maxLife=1
life=maxLife
bShowHealthBar=false
bShowDamage=false
bCanDealDamage=false
hitSound=0
dieSound=0
weight=160
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if y<room_height
{
  awardAwesome(50)
  fieldBlast=instance_create(x,y-(sprite_height/2),oFieldBlast)
  playSound(global.snd_CASdie,0,1)
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  yVel+=0.3
  if isCollisionBottom(1)
  {
    if yVel>7
      instance_destroy()
    yVel=0
  }
  if isCollisionSolid()
    y-=2
  if y>room_height+24
    instance_destroy()
  moveTo(xVel,yVel)
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(random(0.05)+0.3)
draw_set_blend_mode(bm_add)
draw_circle_color(x,y-24,16,make_color_rgb(240,193,64),c_black,false)
draw_set_blend_mode(bm_normal)
draw_set_alpha(1)
event_inherited()
