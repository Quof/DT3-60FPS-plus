if global.gamePaused=false
{
  atkTime+=1*gDeltaTime
  if atkTime<=99
  {
    y+=4*gDeltaTime
    if y>=96
    {
      atkTime=130
    }
  }

  if atkTime>=135 and atkTime mod 55=0
  {
    var tAtk;
    tAtk=instance_create(x,y+7,oPassBullet)
    tAtk.sprite_index=sWarmasterD_EX_Ball; tAtk.atkPower=atkPower; tAtk.bulletSpeed=6
    tAtk.decayTime=-100; tAtk.damageType="ELEMENTAL"; tAtk.image_speed=0.33; tAtk._direction=image_angle
  }
  enemyStepEvent()

  decay-=1*gDeltaTime
  if decay<=0 {life=0}

  if life<=0
  {
    playSound(global.snd_BombExplode,0,0.9,1)
    var tEffect;
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sRobotExplosion; tEffect.image_xscale=0.45; tEffect.image_yscale=0.45
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    instance_destroy()
  }
}
