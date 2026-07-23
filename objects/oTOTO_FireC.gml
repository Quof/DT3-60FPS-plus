#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-3,-3,3,3)
image_speed=0.33

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="ELEMENTAL"
bCanBeBlocked=1
blockCost=200
bParryOpp=1
atkTime=0
myX=x
myY=y
myDist=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  atkTime+=1
  //Orbit
  if moveSpd>0 {myDir-=3}
  else {myDir+=3}
  //Spread
  if myDist<104 {myDist+=2}
  //Movement
  myX+=moveSpd
  x=myX+lengthdir_x(myDist,myDir)
  y=myY+lengthdir_y(myDist,myDir)
}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if atkTime>=30 {instance_destroy()}
