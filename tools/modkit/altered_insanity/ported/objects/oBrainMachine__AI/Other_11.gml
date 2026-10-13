//-------------------- ATTACK: Energy Wave Circle --------------------
shotTime+=1*gDeltaDoTicks
if shotTime>=shotDelay and shotTime<=shotDelay+100 and midLaserTime<midLaserDelay-5
{
  var tEffect;
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
  tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_speed=0.5
  tEffect.image_xscale=2.5; tEffect.image_yscale=2.5
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
  tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_speed=0.5
  tEffect.image_xscale=2.5; tEffect.image_yscale=2.5; tEffect.image_angle=45
  shotTime=10000
}
else if shotTime=10045
{
    if hasArmor = 1
    {
        armor=1
        spawnArmorEffect()
    }
    if room!= rC5_NoWalkBoss
{
  playSound(global.snd_LaserA,0,0.93,15000)
  if bossPhase=1
  {
    var tNewAttack,tDir;
    tDir=0
    for(i=0;i<bulletNum;i+=1)
    {
      tNewAttack=instance_create(x,y,oPassBullet)
      tNewAttack.sprite_index=sShieldMenaceBeam; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4
      tNewAttack.decayTime=-100; tNewAttack.image_xscale=0.75; tNewAttack.image_yscale=0.9 tNewAttack._direction=tDir
      tDir+=360/bulletNum
    }
  }
  else
  {
    var tNewAttack,tDir;
    tDir=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
    tDir-=360/bulletNum
    for(i=0;i<3;i+=1)
    {
      tNewAttack=instance_create(x,y,oPassBullet)
      tNewAttack.sprite_index=sShieldMenaceBeam; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4
      tNewAttack.decayTime=-100; tNewAttack.image_xscale=0.75; tNewAttack.image_yscale=0.9 tNewAttack._direction=tDir
      tDir+=360/bulletNum
    }
  }
    }
    else //cosmic brain machine fires differently
    {
      playSound(global.snd_LaserA,0,0.93,15000)
      if bossPhase=1
      {
        var tNewAttack,tDir;
        tDir=0
        for(i=0;i<bulletNum*2;i+=1)
        {
          tNewAttack=instance_create(x,y,oPassBullet)
          tNewAttack.sprite_index=sShieldMenaceBeam; tNewAttack.atkPower=atkPower; 
          if i mod 2 = 1
          {
              tNewAttack.bulletSpeed=3
              tNewAttack.image_xscale=1;
              tNewAttack.image_yscale=1.2
          }
          else
          {
              tNewAttack.bulletSpeed=4
              tNewAttack.image_xscale=0.75;
              tNewAttack.image_yscale=0.9
          }
          //tNewAttack.decayTime=-100;   tNewAttack.direction=tDir
          tNewAttack.decayTime=-100;   tNewAttack._direction=tDir //60fps change: oPassBullet moves by _direction (the built-in direction did nothing)
          tDir+=360/(bulletNum*2)
        }
      }
      else
      {
        var tNewAttack,tDir;
        tDir=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
        tDir-=360/bulletNum
        for(i=0;i<8;i+=1)
        {
          tNewAttack=instance_create(x,y,oPassBullet)
          tNewAttack.sprite_index=sShieldMenaceBeam; tNewAttack.atkPower=atkPower; 
          if bossPhase = 3
              tNewAttack.bulletSpeed=5-(0.4*i)
          else
              tNewAttack.bulletSpeed=1 + (0.4*i)
          //tNewAttack.decayTime=-100; tNewAttack.image_xscale=0.75; tNewAttack.image_yscale=0.9 tNewAttack.direction=tDir
          tNewAttack.decayTime=-100; tNewAttack.image_xscale=0.75; tNewAttack.image_yscale=0.9; tNewAttack._direction=tDir //60fps change: oPassBullet moves by _direction (the built-in direction did nothing)
          tDir+=360/bulletNum
        }
      }
    }
  shotTime=0
}
