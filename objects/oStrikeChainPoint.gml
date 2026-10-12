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
    shiftTime+=1*gDeltaTime
    if shiftTime>=shiftTimeMax
    {
      shiftTime=0
      xVel*=-1
      yVel*=-1
    }
    x+=xVel*gDeltaTime; y+=yVel*gDeltaTime
  }

  //----- Retract animation -----
  if retractTime>0 {retractTime-=1*gDeltaTime}
  if retractTime>=1 and retractTime<=10 {poleExtendDist-=1*gDeltaTime}

  //----- Grapple reuse time -----
  if reuseTime>=1 and reuseTime<=5 {poleExtendDist+=2*gDeltaTime} //Starting time is 20

  if reuseTime>0
  {
    reuseTime-=1*gDeltaTime
    if reuseTime=0 {poleExtendDist=5; bGrappled=0}
  }
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//60fps change (added): the player hanging from this point is put on it in the player's Step, but whatever moves the point
//(a conveyor, rail or rotating device, or the point itself) can step after the player, which left the player (and the
//view following them) a frame behind the point; on a point moving every frame that jerked it back and forth a pixel
//against the player. Put on it again here, once everything has moved for the frame
if global.gamePaused=false and instance_exists(oPlayer1)
{
  if oPlayer1.grappleState=3 and oPlayer1.grappleID=id
  {
    oPlayer1.x=floor(x+0.5); oPlayer1.y=floor(y+0.5)+40
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
var tDX,tDY;
tDX=floor(x+0.5); tDY=floor(y+0.5) //60fps change (added): drawn on whole pixels, like the player hanging from it (characterStepEvent) (floor(v+0.5): GM8's round() rounds .5 to the even number, so a mover on half pixels stepped 0 then 2 pixels)
for(i=0;i<4;i+=1)
{
  //if i=0 {draw_sprite_ext(sStrikeChainPole,0,x+poleExtendDist,y-poleExtendDist,1,1,i*90,image_blend,1)}
  //else if i=1 {draw_sprite_ext(sStrikeChainPole,0,x-poleExtendDist,y-poleExtendDist,1,1,i*90,image_blend,1)}
  //else if i=2 {draw_sprite_ext(sStrikeChainPole,0,x-poleExtendDist,y+poleExtendDist,1,1,i*90,image_blend,1)}
  //else if i=3 {draw_sprite_ext(sStrikeChainPole,0,x+poleExtendDist,y+poleExtendDist,1,1,i*90,image_blend,1)}
  if i=0 {draw_sprite_ext(sStrikeChainPole,0,tDX+poleExtendDist,tDY-poleExtendDist,1,1,i*90,image_blend,1)} //60fps change: whole pixels
  else if i=1 {draw_sprite_ext(sStrikeChainPole,0,tDX-poleExtendDist,tDY-poleExtendDist,1,1,i*90,image_blend,1)} //60fps change: whole pixels
  else if i=2 {draw_sprite_ext(sStrikeChainPole,0,tDX-poleExtendDist,tDY+poleExtendDist,1,1,i*90,image_blend,1)} //60fps change: whole pixels
  else if i=3 {draw_sprite_ext(sStrikeChainPole,0,tDX+poleExtendDist,tDY+poleExtendDist,1,1,i*90,image_blend,1)} //60fps change: whole pixels
}
//draw_sprite_ext(sprite_index,0,x,y,1,1,0,image_blend,1)
//if reuseTime=0 {draw_sprite(sStrikeChainColor,0,x,y)}
//else {draw_sprite(sStrikeChainColor,1,x,y)}
draw_sprite_ext(sprite_index,0,tDX,tDY,1,1,0,image_blend,1) //60fps change: whole pixels
if reuseTime=0 {draw_sprite(sStrikeChainColor,0,tDX,tDY)} //60fps change: whole pixels
else {draw_sprite(sStrikeChainColor,1,tDX,tDY)} //60fps change: whole pixels
