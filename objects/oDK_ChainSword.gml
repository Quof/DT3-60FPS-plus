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
  chainProg+=1*gDeltaTime
  //if chainProg>=1 and chainProg<=16
  if chainProg>0 and chainProg<=16 //60fps change: covers every frame of ticks 1-16, so the chain extends the full length (3% short at 60fps)
  {
    image_xscale+=(0.5*ownerID.image_xscale)*gDeltaTime
  }
  //else if chainProg>=19 and chainProg<=34
  else if chainProg>18 and chainProg<=34 //60fps change: see above
  {
    image_xscale-=(0.5*ownerID.image_xscale)*gDeltaTime
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
