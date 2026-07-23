#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
size=2
chainProg=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  chainProg+=1
  if chainProg>=1 and chainProg<=16
  {
    image_xscale+=(0.5*ownerID.image_xscale)
  }
  else if chainProg>=19 and chainProg<=34
  {
    image_xscale-=(0.5*ownerID.image_xscale)
  }
  else if chainProg>=35
  {
    ownerID.attackDelay=200
    instance_destroy()
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<8;i+=1)
{
  draw_sprite_ext(sDKSwordSplit,image_index,x+((((i+1)*0.12)*22)*image_xscale),y,ownerID.image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}
