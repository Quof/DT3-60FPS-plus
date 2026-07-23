#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-13,-13,13,13)
image_speed=0.4

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
atkTime=0
hitWall=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  speed=bulletSpeed
  if oGame.time mod 8=0 {image_angle=random(360)}

  atkTime+=1
  if atkTime>=15
  {
    if isCollisionTop(1) {hitWall=1}
    if isCollisionBottom(1) {hitWall=1}
    if isCollisionLeft(1) {hitWall=1}
    if isCollisionRight(1) {hitWall=1}
  }

  if hitWall>=1
  {
    //if hitWall=1 {startDir=0}
    //else {startDir=90}
    startDir=0
    for(i=0;i<2;i+=1)
    {
      var tNewAttack;
      tNewAttack=instance_create(x,y,oPassBullet)
      tNewAttack.sprite_index=sZapTrap; tNewAttack.atkPower=atkPower-1
      tNewAttack.bulletSpeed=9; tNewAttack.decayTime=-100; tNewAttack.direction=startDir
      startDir+=180
    }
    instance_destroy()
  }
}
else {speed=0}
