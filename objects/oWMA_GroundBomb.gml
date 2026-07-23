#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Ground Bomb
event_inherited()
image_speed=0.33

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
size=2
atkProg=0
atkTime=0
xSpread=8
spreadNum=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  atkTime+=1
  if atkProg=0 //Wait and flash
  {
    if atkTime>=30
    {
      image_xscale+=0.05; image_yscale+=0.05
      if atkTime mod 2=0
      {
        if image_blend=c_white {image_blend=c_red}
        else {image_blend=c_white}
      }
    }
    if atkTime>=50
    {
      playSound(global.snd_BombExplode,0,0.95,1)
      var tEffect;
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      visible=0
      y+=32
      atkTime=0; atkProg=1
    }
  }
  else if atkProg=1 //Explosion waves
  {
    if atkTime mod 2=0
    {
      var tAtk;
      tAtk=instance_create(x+xSpread,warTarget.yGround,oWMA_BombExpWave)
      tAtk.atkPower=atkPower; tAtk.image_xscale=1+(0.011*spreadNum); tAtk.image_yscale=1+(0.011*spreadNum)
      tAtk=instance_create(x-xSpread,warTarget.yGround,oWMA_BombExpWave)
      tAtk.atkPower=atkPower; tAtk.image_xscale=1+(0.011*spreadNum); tAtk.image_yscale=1+(0.011*spreadNum)
      xSpread+=20
      spreadNum+=1
      if spreadNum>=20 {instance_destroy()}
    }
  }
}
