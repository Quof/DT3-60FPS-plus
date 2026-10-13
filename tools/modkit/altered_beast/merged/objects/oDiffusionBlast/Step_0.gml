event_inherited()
if global.gamePaused=false
{
  if blastDamage=0 //Start splash
  {
    for(i=0;i<4;i+=1)
    {
      tEffect=instance_create(x,y,oEffectC)
      tEffect.sprite_index=sEfDiffusionParticle; tEffect.image_speed=0.5; tEffect.depth=6; tEffect.newBlend=-1; tEffect.followID=-1
      tEffect.rotation=0; tEffect.moveArc=6; tEffect.fadeSpd=0.05; tEffect.scaleSpd=0
      tEffect._speed=3; tEffect._direction=90*(i+1)
      tEffect=instance_create(x,y,oEffectC)
      tEffect.sprite_index=sEfDiffusionParticle; tEffect.image_speed=0.5; tEffect.depth=6; tEffect.newBlend=-1; tEffect.followID=-1
      tEffect.rotation=0; tEffect.moveArc=-6; tEffect.fadeSpd=0.05; tEffect.scaleSpd=0
      tEffect._speed=3; tEffect._direction=270-(90*i)
    }

    tAlterOmen=0
    if global.alterEquip=1
    {
        for(i=0;i<3;i+=1)
        {
          if global.equipJerry[i]=27 {tAlterOmen=1}
          if global.equipClaire[i]=27 {tAlterOmen=1}
        }
    }
    if tAlterOmen=0
    {
        //atkPower=75+global.stSamus_Missile[0]+global.skillTree[13]
        atkPower=75+scrOmenLv(global.stSamus_Missile[0])+global.skillTree[13] //dark omen change: as DT3+'s, the weapon level counts 10 lower while the New Dark Omen is on (scrOmenLv)
    }
    else
    {
        atkPower=75+(global.stSamus_Missile[0]-10)
    }
    sprite_index=sSamusDiffusionBlast; depth=9
    image_index=0; image_speed=0
    image_xscale=2; image_yscale=2
    _speed=0
    blastDamage=10
  }
  else if blastDamage>=10 //Diffusion blast
  {
    blastDamage+=1*gDeltaTime
    if blastDamage=13 {image_index=1}
    else if blastDamage=16 {image_index=2}
    else if blastDamage=19 {image_index=3}
    else if blastDamage=22 {image_index=4}
    else if blastDamage=25 {instance_destroy()}
  }
}
correctSpeedDirection(self)
