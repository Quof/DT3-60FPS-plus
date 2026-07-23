#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: decayTime,bulletSpeed,bulletCMod,bulletBlend
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
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  direction+=4
  speed=bulletSpeed

  bulletCreate+=1
  if bulletCreate mod bulletCMod=0
  {
    myBullet[bulletNum]=instance_create(x,y,oCW_MarkShot)
    myBullet[bulletNum].sprite_index=sFSSmallBullet; myBullet[bulletNum].image_speed=0.2; myBullet[bulletNum].atkPower=atkPower
    myBullet[bulletNum].bulletSpeed=4; myBullet[bulletNum].direction=direction; myBullet[bulletNum].image_blend=bulletBlend
    bulletNum+=1
  }

  decayTime-=1
  if decayTime<=0
  {
    for(i=0;i<bulletNum;i+=1)
    {
      with myBullet[i] {bulletProg=1}
    }
    instance_destroy()
  }
}
else {speed=0}
