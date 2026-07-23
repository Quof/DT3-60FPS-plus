#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite_index=sInvisibleSolidMask
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if image_alpha=1
  image_alpha=0.5
else
  image_alpha=1
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if image_angle=0
{
  draw_sprite_part_ext(sEnemyDoor,0,0,0,16,16,x,y,1,1,image_blend,image_alpha)
  draw_sprite_part_ext(sEnemyDoor,0,0,16,16,32,x,y+16,1,1,image_blend,image_alpha)
  for(i=0;i<(image_yscale-4)/2;i+=1)
  {
    draw_sprite_part_ext(sEnemyDoor,0,0,16,16,32,x,y+48+(i*32),1,1,image_blend,image_alpha)
  }
  draw_sprite_part_ext(sEnemyDoor,0,0,48,16,16,x,y+48+(i*32),1,1,image_blend,image_alpha)
}
else if image_angle=90
{
  draw_sprite_general(sEnemyDoor,0,0,0,16,16,x,y,1,1,90,image_blend,image_blend,image_blend,image_blend,image_alpha)
  draw_sprite_general(sEnemyDoor,0,0,16,16,32,x+16,y,1,1,90,image_blend,image_blend,image_blend,image_blend,image_alpha)
  for(i=0;i<(image_yscale-4)/2;i+=1)
  {
    draw_sprite_general(sEnemyDoor,0,0,16,16,32,x+48+(i*32),y,1,1,90,image_blend,image_blend,image_blend,image_blend,image_alpha)
  }
  draw_sprite_general(sEnemyDoor,0,0,48,16,16,x+48+(i*32),y,1,1,90,image_blend,image_blend,image_blend,image_blend,image_alpha)
}
