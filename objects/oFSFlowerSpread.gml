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
    myBulletA[bulletNum].bulletSpeed=1; myBulletA[bulletNum].direction=startDir; myBulletA[bulletNum].image_blend=bulletBlend
    myBulletB[bulletNum]=instance_create(x,y,oCW_MarkShot)
    myBulletB[bulletNum].sprite_index=sFSSmallBullet; myBulletB[bulletNum].image_speed=0.2; myBulletB[bulletNum].atkPower=atkPower
    myBulletB[bulletNum].bulletSpeed=1; myBulletB[bulletNum].direction=startDir+120; myBulletB[bulletNum].image_blend=bulletBlend
    myBulletC[bulletNum]=instance_create(x,y,oCW_MarkShot)
    myBulletC[bulletNum].sprite_index=sFSSmallBullet; myBulletC[bulletNum].image_speed=0.2; myBulletC[bulletNum].atkPower=atkPower
    myBulletC[bulletNum].bulletSpeed=1; myBulletC[bulletNum].direction=startDir+240; myBulletC[bulletNum].image_blend=bulletBlend
    startDir+=10
    bulletNum+=1
  }

  decayTime-=1
  if decayTime<=0
  {
    for(i=0;i<bulletNum;i+=1)
    {
      with myBulletA[i] {bulletProg=1}
      with myBulletB[i] {bulletProg=1}
      with myBulletC[i] {bulletProg=1}
    }
    instance_destroy()
  }
}
else {speed=0}
