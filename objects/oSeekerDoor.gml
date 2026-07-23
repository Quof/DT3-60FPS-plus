#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite_index=sNull
image_yscale=room_height/16
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if instance_exists(seekerID)
  {
    if seekerID.alertMode=3
    {
      sprite_index=sInvisibleSolidMask
    }
    else
    {
      sprite_index=sNull
    }
  }
  else
  {
    instance_destroy()
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if sprite_index=sInvisibleSolidMask
{
  for(i=0;i<image_yscale;i+=1)
  {
    draw_sprite(sSeekerDoor,0,x,y+(16*i))
  }
}
