#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.4

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
atkProg=0
bulletSpeed=5
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if atkProg=0
  {
    if !instance_exists(ownerID) {instance_destroy()}
  }
  else if atkProg>=1
  {
    speed=bulletSpeed
    atkProg+=1
    if atkProg>=45
    {
      if checkScreenArea(x,y,48)=1 {playSound(global.snd_LightballSpread,0,0.94,1)}
      tDir=0
      for(i=0;i<8;i+=1)
      {
        tNewAttack=instance_create(x,y,oPassBullet)
        tNewAttack.sprite_index=sprite_index
        tNewAttack.image_xscale=0.5; tNewAttack.image_yscale=0.5; tNewAttack.image_speed=0.5
        tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4; tNewAttack.decayTime=12
        tNewAttack.direction=tDir
        tDir+=360/8
      }
      instance_destroy()
    }
  }
}
else {speed=0}
