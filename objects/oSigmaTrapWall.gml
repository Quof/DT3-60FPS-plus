#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
atkPower=6
bCanTakeDamage=false
bShowHealthBar=false

image_speed=0.3
image_alpha=0.8
moveProg=0
moveTime=0
scaling=0.1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  moveTime+=1
  if moveProg=0 //Size increase
  {
    if scaling<1 {scaling+=0.1}
    if moveTime=25
    {
      moveTime=0
      moveProg=1
    }
  }
  else if moveProg=1 {x+=xMove}
}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_blend_mode(bm_add)
for(i=0;i<image_xscale;i+=1)
{
  for(ii=0;ii<image_yscale;ii+=1)
  {
    draw_sprite_ext(sprite_index,image_index,x+(i*16),y+(ii*16),scaling,scaling,image_angle,image_blend,image_alpha)
  }
}
draw_set_blend_mode(bm_normal)
