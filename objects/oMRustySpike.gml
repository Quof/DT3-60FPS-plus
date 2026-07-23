#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
atkPower=8
bCanTakeDamage=false
bShowHealthBar=false
detectDistX=96
detectDistY=304
fallingProgress=0
shakeDir=1
fallSpeed=4

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
  makeEnemyActive(1)
  if bActive=true
  {
    fallingProgress+=1*gDeltaTime
    if fallingProgress=1
      x+=1
    else if fallingProgress>=2 and fallingProgress<=30
    {
      if shakeDir=1
        x-=2
      else
        x+=2
      shakeDir*=-1
    }
    else if fallingProgress=31
      x=xstart
    else if fallingProgress>=32
      y+=fallSpeed*gDeltaTime
  }
  if y>room_height+24
    instance_destroy()
}
