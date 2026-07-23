#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: fireType
event_inherited()
makeActive()
setCollisionBounds(-3,-3,3,3)

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="ELEMENTAL"
bDestroy=0
weight=50
grav=0.2
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  yVel+=grav
  if xVel>0 {image_angle-=10}
  else if xVel<0 {image_angle+=10}

  if fireType=0 {image_angle+=30}

  if isCollisionTop(1) {bDestroy=1}
  if isCollisionBottom(1) {bDestroy=1}
  if isCollisionLeft(1) {bDestroy=1}
  if isCollisionRight(1) {bDestroy=1}
  moveTo(xVel,yVel)

  if bDestroy=1
  {
    if fireType=1 {playSound(global.snd_Flame1,0,0.94,1)}

    if fireType=0 {fireAmt=4}
    else {fireAmt=3}
    for(i=0;i<fireAmt;i+=1)
    {
      tNewAttack=instance_create(x,y-8,oGravityBullet)
      tNewAttack.atkPower=atkPower; tNewAttack.damageType="ELEMENTAL"; tNewAttack.xVel=0
      if fireType=0
      {
        tNewAttack.sprite_index=sFireBroBlueFire
        tNewAttack.yVel=-1-i
      }
      else
      {
        tNewAttack.sprite_index=sFireBroFire
        tNewAttack.yVel=-1-(i*0.5)
      }
    }
    instance_destroy()
  }
  if y>room_height+32 {instance_destroy()}
}
