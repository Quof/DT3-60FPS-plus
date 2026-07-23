#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-7,-7,7,7)

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bDestroy=0
weight=50
grav=0.4
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  yVel+=grav
  if yVel>13 {yVel=13}

  if isCollisionTop(1)
    bDestroy=1
  if isCollisionBottom(1)
    bDestroy=1
  if isCollisionLeft(1)
    bDestroy=1
  if isCollisionRight(1)
    bDestroy=1
  moveTo(xVel,yVel)

  if bDestroy=1
  {
    playSound(global.snd_EnemyDieMM,0,0.97,36000)
    for(i=0;i<4;i+=1)
    {
      newBird=instance_create(x,y,oStormBird)
      newBird.direction=45+(i*90)
    }
    instance_destroy()
  }
}
