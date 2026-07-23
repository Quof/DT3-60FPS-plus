#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
bCanMove=0
reuseTime=0
poleExtendDist=5
bGrappled=0
retractTime=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: shiftTime,shiftTimeMax,xVel,yVel
if variable_local_exists("moving") {bCanMove=1}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //----- Movement -----
  if bCanMove=1
  {
    shiftTime+=1
    if shiftTime>=shiftTimeMax
    {
      shiftTime=0
      xVel*=-1
      yVel*=-1
    }
    x+=xVel; y+=yVel
  }

  //----- Retract animation -----
  if retractTime>0 {retractTime-=1}
  if retractTime>=1 and retractTime<=10 {poleExtendDist-=1}

  //----- Grapple reuse time -----
  if reuseTime>=1 and reuseTime<=5 {poleExtendDist+=2} //Starting time is 20

  if reuseTime>0
  {
    reuseTime-=1
    if reuseTime=0 {poleExtendDist=5; bGrappled=0}
  }
}
#define Collision_oMMXstrikeChain
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oPlayer1.grappleState=1 and reuseTime=0
{
  playSound(global.snd_HookLatch,0,0.92,1)
  bGrappled=1
  oPlayer1.grappleState=2
  oPlayer1.groundDashRecovery=0
  oPlayer1.airDashRecovery=0
  oPlayer1.xVel=0
  oPlayer1.yVel=0
  oPlayer1.grappleID=id
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<4;i+=1)
{
  if i=0 {draw_sprite_ext(sStrikeChainPole,0,x+poleExtendDist,y-poleExtendDist,1,1,i*90,image_blend,1)}
  else if i=1 {draw_sprite_ext(sStrikeChainPole,0,x-poleExtendDist,y-poleExtendDist,1,1,i*90,image_blend,1)}
  else if i=2 {draw_sprite_ext(sStrikeChainPole,0,x-poleExtendDist,y+poleExtendDist,1,1,i*90,image_blend,1)}
  else if i=3 {draw_sprite_ext(sStrikeChainPole,0,x+poleExtendDist,y+poleExtendDist,1,1,i*90,image_blend,1)}
}
draw_sprite_ext(sprite_index,0,x,y,1,1,0,image_blend,1)
if reuseTime=0 {draw_sprite(sStrikeChainColor,0,x,y)}
else {draw_sprite(sStrikeChainColor,1,x,y)}
