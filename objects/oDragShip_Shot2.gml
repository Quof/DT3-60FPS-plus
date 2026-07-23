#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0

global.recAtkNum+=1
stunTime=1
bStuck=0
explodeTime=30
stuckID=0
xOffset=0
yOffset=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  x+=bulletSpeed

  if bStuck=1
  {
    if instance_exists(stuckID)
    {
      x=stuckID.x+xOffset
      y=stuckID.y+yOffset
      explodeTime-=1

      if explodeTime<=10
      {
        if image_blend=c_white {image_blend=c_red}
        else {image_blend=c_white}
      }
      if explodeTime=0
      {
        myAtk=instance_create(x,y,oDragShip_Shot2Exp)
        myAtk.atkPower=atkPower
        instance_destroy()
      }
    }
    else
    {
      instance_destroy()
    }
  }
}
#define Collision_oCHAOS_Assault
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bStuck=0
{
  image_index=1
  stuckID=other.id
  xOffset=x-other.x
  yOffset=y-other.y
  bStuck=1
}
#define Collision_oCW_RocketT
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bStuck=0
{
  image_index=1
  stuckID=other.id
  xOffset=x-other.x
  yOffset=y-other.y
  bStuck=1
}
#define Collision_oDragAsteroid
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bStuck=0
{
  image_index=1
  stuckID=other.id
  xOffset=x-other.x
  yOffset=y-other.y
  bStuck=1
}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
