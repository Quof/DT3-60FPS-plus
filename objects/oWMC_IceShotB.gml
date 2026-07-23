#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
iceSpread=11
if room=rWarshipZ_E3
{
  iceSpread=10
}
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
  if y<=48 //Shatter
  {
    playSound(global.snd_LightballSpread,0,0.92,28000)
    var tDir,tNum;
    if rWarshipZ_E3 //EX MODE
    {
      tDir=230; tNum=9
    }
    else
    {
      if warTarget.DIFFICULTY=0 {tDir=248; tNum=5}
      else {tDir=237; tNum=7}
    }
    for(i=0;i<tNum;i+=1)
    {
      tNewAttack=instance_create(x,y,oPassBullet)
      tNewAttack.sprite_index=sSeraAtkIceB; tNewAttack.atkPower=atkPower-1; tNewAttack.bulletSpeed=7
      tNewAttack.decayTime=-100; tNewAttack.image_speed=0.25; tNewAttack.direction=tDir; tNewAttack.damageType="ELEMENTAL"
      tDir+=iceSpread
    }
    instance_destroy()
  }
}
else {speed=0}
