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
yVel=-5
moveType=0
shotDir=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if moveType=0 //Come down
  {
    yVel+=0.2
    y+=yVel
    if yVel>0 and y>=oSera.y-44 {moveType=1}
  }
  else if moveType=1 //Spray shattered pieces
  {
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sMMshotgunIceEffect; tEffect.image_speed=0.35; tEffect.image_angle=random(360)
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    tEffect.direction=random(360); tEffect.speed=3; tEffect.image_alpha=0.75
    if oGame.time mod 4=0 {playSound(global.snd_CShotA,0,0.9,1)}
    if oGame.time mod 2=0
    {
      var tNewAttack;
      tNewAttack=instance_create(x,y,oPassBullet)
      tNewAttack.sprite_index=sSeraAtkIceC; tNewAttack.atkPower=atkPower-1; tNewAttack.bulletSpeed=3
      tNewAttack.decayTime=-100; tNewAttack.image_xscale=0.65; tNewAttack.image_yscale=0.65
      tNewAttack.direction=shotDir; tNewAttack.damageType="ELEMENTAL"
      tNewAttack=instance_create(x,y,oPassBullet)
      tNewAttack.sprite_index=sSeraAtkIceC; tNewAttack.atkPower=atkPower-1; tNewAttack.bulletSpeed=6
      tNewAttack.decayTime=-100; tNewAttack.image_xscale=0.65; tNewAttack.image_yscale=0.65
      tNewAttack.direction=shotDir-180; tNewAttack.damageType="ELEMENTAL"
      shotDir+=17
    }

    image_xscale-=0.0075; image_yscale-=0.0075
    y+=0.45
    if y>=oSera.y
    {
      SS_StopSound(global.snd_CShotA)
      instance_destroy()
    }
  }
}
