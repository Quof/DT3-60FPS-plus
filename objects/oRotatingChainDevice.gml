#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: rotateSpd
armsRotation=0

for(i=0;i<4;i+=1)
{
  myGrapplePoints[i]=instance_create(x,y,oStrikeChainPoint)
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  armsRotation+=rotateSpd
  for(i=0;i<4;i+=1)
  {
    myGrapplePoints[i].x=x+lengthdir_x(75,(i*90)+armsRotation)
    myGrapplePoints[i].y=y+lengthdir_y(75,(i*90)+armsRotation)
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<4;i+=1)
{
  draw_sprite_ext(sBM_Chain,0,x,y,image_xscale,image_yscale,(i*90)+armsRotation,image_blend,image_alpha)
}
