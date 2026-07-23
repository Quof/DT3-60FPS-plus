#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
makeActive()
setCollisionBounds(-3,-3,3,3)
image_speed=0.4
global.recAtkNum+=1

lifeTime=30
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  lifeTime-=1
  if lifeTime=0
  {
    playSound(global.snd_MetroidBomb,0,1,11025)
    var tExpLight;
    tExpLight=instance_create(x,y,oWepEf_Light); tExpLight.image_xscale=5; tExpLight.image_yscale=4

    bomb=instance_create(x,y,oSamusPowerBombB)
    instance_destroy()
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_set_alpha(0.66)
draw_set_color(c_black)
draw_circle(x,y,lifeTime/2,1)
draw_set_color(c_white)
draw_circle(x,y,(lifeTime/2)+1,1)
