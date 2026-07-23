#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Front Bomb
event_inherited()
image_speed=0.33

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false

moveTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  y-=2
  if y<=64
  {
    playSound(global.snd_HardHit2,0,0.93,15000)
    var tNewAttack,tDir;
    tDir=240
    for(i=0;i<9;i+=1)
    {
      tNewAttack=instance_create(x,y,oPassBullet)
      tNewAttack.sprite_index=sWarmasterA_ShotA; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=9
      tNewAttack.image_speed=0.33; tNewAttack.decayTime=-100; tNewAttack.direction=tDir; tNewAttack.image_angle=tDir
      tDir+=7.5
    }
    instance_destroy()
  }
}
