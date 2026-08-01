#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_alpha=0
sprite_index=sInvisibleSolidMask
image_xscale=30

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="ELEMENTAL"
size=2
fireFrm=0

fireProg=0
fireTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  fireFrm+=0.33*gDeltaTime
  if fireProg=0
  {
    image_alpha+=0.04*gDeltaTime
    if image_alpha>=1 {fireProg+=1}
  }
  else if fireProg=1
  {
    y-=2*gDeltaTime
    if y<=272 {fireProg+=1}
  }
  else if fireProg=2
  {
    fireTime+=1*gDeltaTime
    if fireTime>=100
    {
      image_alpha-=0.05*gDeltaTime
      if image_alpha<=0.5 {instance_destroy()}
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<30;i+=1)
{
  draw_sprite_ext(sHFight_FloorFire,fireFrm,x+(i*16),y+16,1,1,image_angle,image_blend,image_alpha)
}
