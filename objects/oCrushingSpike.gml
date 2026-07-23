#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-15,-15,15,15)

//Enemy base statistics
atkPower=8
bCanTakeDamage=false
bShowHealthBar=false
seekSpeed=10
seekTime=0
seekDelay=20
bReturning=false
bTargetFound=false
detectDistX=48
detectDistY=288

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.location=103
{
  var myShadow;
  myShadow=instance_create(0,0,oObjectShadow)
  myShadow.ownerID=id; myShadow.type=2; myShadow.maxShadowDist=192
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bActive=false {makeEnemyActive(1)}
  //start movement in Player's direction (down)
  if bActive=true and y<oPlayer1.y
  {
    if bTargetFound=false
    {
      yVel=seekSpeed
      bTargetFound=true
      seekTime=seekDelay
    }
  }
  if seekTime>0
  {
    seekTime-=1
    if isCollisionBottom(1)
    {
      bReturning=true
      yVel=0
    }
    if seekTime=0 and bReturning=false
    {
      bReturning=true
      yVel=0
    }
  }
  if bReturning=false {moveTo(xVel,yVel)}

  //Return to original position
  if bReturning=true
  {
    y-=seekSpeed/3
    if y<=ystart
    {
      y=ystart
      yVel=0
      bTargetFound=false
      bReturning=false
      bActive=false
    }
  }
}
