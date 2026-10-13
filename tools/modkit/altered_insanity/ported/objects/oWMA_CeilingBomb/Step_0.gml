if global.gamePaused=false
{
  atkTime+=1*gDeltaTime
  if atkProg=0 //(the mod: rises to the ceiling, then explodes)
  {
      //y-=10
      y-=10*gDeltaTime //60fps change: per frame
      if y <= warTarget.yGround-warTarget.roomHeight
    {
      playSound(global.snd_BombExplode,0,0.95,1)
      var tEffect;
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          atkTime=0; atkProg=1;
          spreadNum = 0
      visible=0
    }
  }
  if atkProg=1 //Explosion waves
  {
       
    if atkTime mod 2=0
    {
      var tAtk;
      tAtk=instance_create(x+xSpread,warTarget.yGround-warTarget.roomHeight,oWMA_BombExpWave)
      tAtk.atkPower=atkPower; 
      tAtk.image_xscale=1+(0.011*spreadNum); 
      tAtk.image_angle+= 180
    if global.activeCharacter=3
    {
        tAtk.image_yscale=1+(0.333*spreadNum)
        if tAtk.image_yscale>3
        {
            tAtk.image_yscale = 3
        }
    }
    else
    {
        tAtk.image_yscale=1+(0.011*spreadNum)
    }
      
      tAtk=instance_create(x-xSpread,warTarget.yGround-warTarget.roomHeight,oWMA_BombExpWave)
      tAtk.atkPower=atkPower; 
      tAtk.image_xscale=1+(0.011*spreadNum); 
      tAtk.image_angle+= 180
    if global.activeCharacter=3
    {
        tAtk.image_yscale=1+(0.333*spreadNum)
    }
    else
    {
        tAtk.image_yscale=1+(0.011*spreadNum)
    }
      xSpread+=20
      spreadNum+=1
      if spreadNum>=20 {instance_destroy()}
    }
  }
}
