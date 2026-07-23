#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
sprite_index=sInvisibleSolidMask
image_xscale=4
image_yscale=32
image_speed=0.2

//Enemy base statistics
atkPower=8
bCanTakeDamage=false
bShowHealthBar=false

decayTime=30
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  decayTime-=1
  if decayTime<=0 {instance_destroy()}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sWallOfFire,image_index,x+32,y+64,1,1,90,image_blend,image_alpha)
for(i=0;i<13;i+=1)
{
  draw_sprite_general(sWallOfFire,image_index+i,0,0,32,63,x+1,y+96+(i*32),1,1,90,image_blend,image_blend,image_blend,image_blend,image_alpha)
}
