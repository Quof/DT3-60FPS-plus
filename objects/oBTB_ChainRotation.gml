#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: rotateSpd,armLength,armNum
armsCreated=0
armsRotation=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<armNum;i+=1)
{
  myGrapplePoints[i]=instance_create(x,y,oStrikeChainPoint)
}
armsCreated=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false and armsCreated=1
{
  armsRotation+=rotateSpd
  for(i=0;i<armNum;i+=1)
  {
    myGrapplePoints[i].x=x+lengthdir_x(armLength,(i*(360/armNum))+armsRotation)
    myGrapplePoints[i].y=y+lengthdir_y(armLength,(i*(360/armNum))+armsRotation)
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if armsCreated=1
{
  for(i=0;i<armNum;i+=1)
  {
    draw_sprite_ext(sBM_Chain,0,x,y,armLength/75,0.3,(i*(360/armNum))+armsRotation,image_blend,0.7)
  }
}
