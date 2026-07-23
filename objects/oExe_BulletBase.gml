#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: type
event_inherited()
atkPower=9
bCanBeBlocked=0
lifeTime=0
moveWave=pi/2
bulProg=0
curDist=0
exBulletNormalCheck=0
exBulletBlockCheck=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if type=0 //Straight - (bulSpd)
  {
    speed=bulSpd
  }
  else if type=1 //Spiral - (bulSpd,curveAmt,curveTime)
  {
    speed=bulSpd
    if curveTime>0
    {
      curveTime-=1
      direction+=curveAmt
    }
  }
  else if type=2 //Swirve - (bulSpd,curveAmt)
  {
    speed=bulSpd
    moveWave+=pi/curveAmt
    direction+=sin(moveWave)
  }
  else if type=3 //Speed Change A - (bulSpd,newSpd,spdTime)
  {
    if bulSpd!=newSpd
    {
      spdTime-=1
      if spdTime<=0 {bulSpd=newSpd}
    }
    speed=bulSpd
  }
  else if type=4 //Speed Change B [2 changes] - (bulSpd,newSpdA,spdTimeA,newSpdB,spdTimeB)
  {
    if bulProg=0
    {
      spdTimeA-=1
      if spdTimeA<=0
      {
        bulSpd=newSpdA
        bulProg=1
      }
    }
    else if bulProg=1
    {
      spdTimeB-=1
      if spdTimeB<=0
      {
        bulSpd=newSpdB
        bulProg=2
      }
    }
    speed=bulSpd
  }
  else if type=5 //Orbit around boss - (rotSpd,curDir,distMax)
  {
    if curDist<distMax {curDist+=2}
    curDir+=rotSpd
    x=oTheExecutive.x+lengthdir_x(curDist,curDir)
    y=oTheExecutive.y+lengthdir_y(curDist,curDir)
  }

  if sprite_index!=sPT_FE_BigFire {image_angle=direction}
  if type!=5
  {
    if checkScreenArea(x,y,0)=1 {lifeTime+=1}
  }
}
else {speed=0}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oPlayer1.extraBulletCheck=0
{
  if oPlayer1.attackState=oPlayer1.ACT_BLOCK
  {
    exBulletBlockCheck+=1
    if exBulletBlockCheck>=3
    {
      exBulletBlockCheck=0
      event_inherited()
    }
  }
  else
  {
    exBulletNormalCheck+=1
    if exBulletNormalCheck>=1
    {
      exBulletNormalCheck=0
      event_inherited()
    }
  }
}
#define Other_40
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if lifeTime>=15 {instance_destroy()}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_self()
