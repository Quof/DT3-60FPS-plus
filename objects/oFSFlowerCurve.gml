#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: decayTime,bulletSpeed,bulletTurn,bulletCMod,bulletBlend
event_inherited()
size=2

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
arcTime=0
bulletCreate=0
bulletNum=0
myBullet[0]=noone

_direction=0
_speed=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  arcTime+=1*gDeltaTime
  if arcTime>=1 and arcTime<=10 {_direction+=bulletTurn*gDeltaTime}
  else if arcTime>=11 and arcTime<=30 {_direction-=bulletTurn*gDeltaTime}
  else
  {
    _direction+=4*gDeltaTime
    if arcTime>=40 {arcTime=0}
  }

  _speed=bulletSpeed
  image_angle=_direction

  bulletCreate+=1*gDeltaTime
  if bulletCreate mod bulletCMod=0
  {
    myBullet[bulletNum]=instance_create(x,y,oCW_MarkShot)
    myBullet[bulletNum].sprite_index=sFSSmallBullet; myBullet[bulletNum].image_speed=0.2; myBullet[bulletNum].atkPower=atkPower
    myBullet[bulletNum].bulletSpeed=4; myBullet[bulletNum]._direction=_direction; myBullet[bulletNum].image_blend=bulletBlend
    bulletNum+=1
  }

  decayTime-=1*gDeltaTime
  if decayTime<=0
  {
    for(i=0;i<bulletNum;i+=1)
    {
      with myBullet[i] {bulletProg=1}
    }
    instance_destroy()
  }
}
else {_speed=0}

x += cos(degtorad(_direction)) * _speed * gDeltaTime
y -= sin(degtorad(_direction)) * _speed * gDeltaTime
