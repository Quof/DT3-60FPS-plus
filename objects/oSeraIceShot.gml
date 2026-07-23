#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="ELEMENTAL"
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  speed=bulletSpeed
  if type=0 //Ground
  {
    if y>=282 //Shatter
    {
      playSound(global.snd_LightballSpread,0,0.92,24000)
      tNewAttack=instance_create(x,y,oGravPassBullet)
      tNewAttack.sprite_index=sSeraAtkIceB; tNewAttack.atkPower=atkPower-1
      tNewAttack.image_speed=0.25; tNewAttack.xVel=-4; tNewAttack.yVel=-4; tNewAttack.damageType="ELEMENTAL"
      tNewAttack=instance_create(x,y,oGravPassBullet)
      tNewAttack.sprite_index=sSeraAtkIceB; tNewAttack.atkPower=atkPower-1
      tNewAttack.image_speed=0.25; tNewAttack.xVel=-3; tNewAttack.yVel=-5.5; tNewAttack.damageType="ELEMENTAL"
      tNewAttack=instance_create(x,y,oGravPassBullet)
      tNewAttack.sprite_index=sSeraAtkIceB; tNewAttack.atkPower=atkPower-1
      tNewAttack.image_speed=0.25; tNewAttack.xVel=3; tNewAttack.yVel=-5.5; tNewAttack.damageType="ELEMENTAL"
      tNewAttack=instance_create(x,y,oGravPassBullet)
      tNewAttack.sprite_index=sSeraAtkIceB; tNewAttack.atkPower=atkPower-1
      tNewAttack.image_speed=0.25; tNewAttack.xVel=4; tNewAttack.yVel=-4; tNewAttack.damageType="ELEMENTAL"

      tNewAttack=instance_create(x,y,oPassBullet)
      tNewAttack.sprite_index=sSeraAtkIceB; tNewAttack.atkPower=atkPower-1; tNewAttack.bulletSpeed=6
      tNewAttack.decayTime=-100; tNewAttack.image_speed=0.25; tNewAttack.direction=90; tNewAttack.damageType="ELEMENTAL"
      instance_destroy()
    }
  }
  else if type=1 //Ceiling
  {
    if y<=70 //Shatter
    {
      playSound(global.snd_LightballSpread,0,0.92,28000)
      var tDir,tNum;
      if oSera.bossProgress<=2 {tDir=234; tNum=7}
      else {tDir=222; tNum=9}
      for(i=0;i<tNum;i+=1)
      {
        tNewAttack=instance_create(x,y,oPassBullet)
        tNewAttack.sprite_index=sSeraAtkIceB; tNewAttack.atkPower=atkPower-1; tNewAttack.bulletSpeed=8
        tNewAttack.decayTime=-100; tNewAttack.image_speed=0.25; tNewAttack.direction=tDir; tNewAttack.damageType="ELEMENTAL"
        tDir+=12
      }
      instance_destroy()
    }
  }
}
else {speed=0}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
