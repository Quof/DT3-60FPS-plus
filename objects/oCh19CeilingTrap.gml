#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_xscale=ceil(room_width/64)
image_yscale=9

//Enemy base statistics
bCanTakeDamage=false
bShowHealthBar=false

bGoDown=1
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=1 {y-=288}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if type=1
  {
    if bGoDown=1
    {
      y+=2
      if y>=-78 {bGoDown=0} //216-286
    }
    else
    {
      y-=2
      if y<=-276 {bGoDown=1} //12-286
    }
  }
  else if type=2
  {
    if myMaster.bGoDown=1
    {
      y+=2
    }
    else
    {
      y-=2
    }
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(1)
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=1 //Ceiling
{
  for(i=0;i<ceil(room_width/64);i+=1)
  {
    draw_sprite_part(sprite_index,0,0,0,64,32,x+(i*64),y+260)
    draw_sprite_part(sprite_index,0,0,0,64,32,x+(i*64),y+228)
    draw_sprite_part(sprite_index,0,0,0,64,32,x+(i*64),y+196)
    draw_sprite_part(sprite_index,0,0,0,64,32,x+(i*64),y+164)
    draw_sprite_part(sprite_index,0,0,0,64,32,x+(i*64),y+132)
    draw_sprite_part(sprite_index,0,0,0,64,32,x+(i*64),y+100)
    draw_sprite_part(sprite_index,0,0,0,64,32,x+(i*64),y+68)
    draw_sprite_part(sprite_index,0,0,0,64,32,x+(i*64),y+36)
    draw_sprite_ext(sprite_index,0,x+(i*64),y+292,1,1,image_angle,image_blend,image_alpha)
  }
}
else if type=2 //Floor
{
  for(i=0;i<ceil(room_width/64);i+=1)
  {
    draw_sprite_part(sprite_index,0,0,0,64,32,x+(i*64),y+260)
    draw_sprite_part(sprite_index,0,0,0,64,32,x+(i*64),y+228)
    draw_sprite_part(sprite_index,0,0,0,64,32,x+(i*64),y+196)
    draw_sprite_part(sprite_index,0,0,0,64,32,x+(i*64),y+164)
    draw_sprite_part(sprite_index,0,0,0,64,32,x+(i*64),y+132)
    draw_sprite_part(sprite_index,0,0,0,64,32,x+(i*64),y+100)
    draw_sprite_part(sprite_index,0,0,0,64,32,x+(i*64),y+68)
    draw_sprite_part(sprite_index,0,0,0,64,32,x+(i*64),y+36)
    draw_sprite_ext(sprite_index,0,x+64+(i*64),y+36,1,1,180,image_blend,image_alpha)
  }
}
