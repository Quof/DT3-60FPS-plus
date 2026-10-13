if global.gamePaused=false
{
  if type=0 //Normal
  {
    moveTime+=1*gDeltaTime
    if moveTime>=1 and moveTime<=35
    {
      if global.activeCharacter!=3
      {
      myAngle=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
      }
      else
      {
        myAngle=point_direction(x,y,oIdentifier.x,returnPlayerYCenter())
      }
    }
    else if moveTime=50
    {
      playSound(global.snd_CShotB,0,0.9,35000)
      tNewAttack=instance_create(x+lengthdir_x(6,image_angle),y+lengthdir_y(6,image_angle),oPassBullet)
      tNewAttack.sprite_index=sWarmasterA_ShotA; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5
      tNewAttack.image_speed=0.33; tNewAttack.decayTime=-100; tNewAttack._direction=myAngle; tNewAttack.image_angle=myAngle
      moveTime=0
    }
  }
  else if type=1 //Final super
  {
    moveTime+=1*gDeltaTime
    if moveTime>=shotDelay
    {
      moveTime=0
      type=0
    }
  }
  enemyStepEvent()

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
