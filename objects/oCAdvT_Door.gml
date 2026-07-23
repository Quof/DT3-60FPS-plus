#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite_index=sInvisibleSolidMask
myProg=0
xDraw=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if xDraw<16 {xDraw+=0.2}

  if myProg=0
  {
    if oGame.time mod 2=0
    {
      if image_alpha=1 {image_alpha=0.5}
      else {image_alpha=1}
    }
  }
  else if myProg=1
  {
    image_alpha=1
    myProg=2
  }
  else if myProg=2
  {
    image_alpha-=0.05
    if image_alpha<=0 {instance_destroy()}
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_part_ext(sCAdvT_Door,0,0,0,xDraw,64,x,y,1,1,c_white,image_alpha)
for(i=0;i<(image_yscale-4);i+=1)
{
  draw_sprite_part_ext(sCAdvT_Door,0,0,32,xDraw,16,x,y+65+(i*16),1,1,c_white,image_alpha)
}
