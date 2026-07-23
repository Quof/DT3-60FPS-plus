#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: decayTime,bulletSpeed,bulletCMod,bulletBlend
event_inherited()
image_speed=0.33
size=2

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
arcTime=0
bulletCreate=0
bulletNum=0
myBulletA[0]=noone
myBulletB[0]=noone
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  speed=bulletSpeed

  bulletCreate+=1
  if bulletCreate mod bulletCMod=0
  {
    myBulletA[bulletNum]=instance_create(x,y,oCW_MarkShot)
    myBulletA[bulletNum].sprite_index=sFSSmallBullet; myBulletA[bulletNum].image_speed=0.2; myBulletA[bulletNum].atkPower=atkPower
    myBulletA[bulletNum].bulletSpeed=3; myBulletA[bulletNum].direction=direction+90; myBulletA[bulletNum].image_blend=bulletBlend
    myBulletB[bulletNum]=instance_create(x,y,oCW_MarkShot)
    myBulletB[bulletNum].sprite_index=sFSSmallBullet; myBulletB[bulletNum].image_speed=0.2; myBulletB[bulletNum].atkPower=atkPower
    myBulletB[bulletNum].bulletSpeed=3; myBulletB[bulletNum].direction=direction+270; myBulletB[bulletNum].image_blend=bulletBlend
    bulletNum+=1
  }

  decayTime-=1
  if decayTime<=0
  {
    for(i=0;i<bulletNum;i+=1)
    {
      with myBulletA[i] {bulletProg=1}
      with myBulletB[i] {bulletProg=1}
    }
    instance_destroy()
  }
}
else {speed=0}
