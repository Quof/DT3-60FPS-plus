if global.gamePaused=false
{
  if atkProg=0
  {
    image_index+=0.045*gDeltaTime
    if image_index>=2.85
    {
      sprite_index=sDraculaFireWave
      image_speed=0.33
      image_yscale=9
      bCanDealDamage=1
      atkProg+=1
    }
  }
  else
  {
    atkProg+=1*gDeltaTime
    if atkProg>=75
    {
        instance_destroy()
        //spsp ns
        if instance_exists(oDracula)
        {
            if oDracula.atkProg=20
            {
                tFire=instance_create(x,y,oPassBullet)
                tFire.sprite_index=sFlameUpP; tFire.atkPower=atkPower; tFire.bulletSpeed=0
                //tFire.image_speed=0.75; tFire.direction=0; tFire.decayTime=-100; tFire.damageType="ELEMENTAL"
                tFire.image_speed=0.75; tFire._direction=0; tFire.decayTime=-100; tFire.damageType="ELEMENTAL" //60fps change: DT3+'s oPassBullet moves by its own _direction
                tFire.depth=depth+1
  }
}
    }
  }
}
