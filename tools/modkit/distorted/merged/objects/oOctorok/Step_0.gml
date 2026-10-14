if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0
  {
    shootTime+=1*gDeltaTime
    if shootTime>1 and shootTime<shootDelay-10
    {
      if x>oPlayer1.x
        image_xscale=-abs(image_xscale)
      else
        image_xscale=abs(image_xscale)
    }
    if shootTime=shootDelay-10
    {
      y-=4
      yVel=-2.4*sqrt(abs(image_xscale))
    }
    if shootTime>=shootDelay
    {
      var tNewAttack,tOffsetShotX;
      if image_xscale=1
        tOffsetShotX=4
      else
        tOffsetShotX=-4
      tNewAttack=instance_create(x+tOffsetShotX*abs(image_xscale),y-8*abs(image_xscale),oNormalBullet)
      tNewAttack.sprite_index=sOctorokRock
      tNewAttack.atkPower=atkPower+abs(image_xscale)-1
      tNewAttack.bulletSpeed=7
      tNewAttack.image_speed=0.33
      if image_xscale=abs(image_xscale)
        tNewAttack._direction=0
      else
        tNewAttack._direction=180
      tNewAttack.image_xscale=abs(image_xscale)
      tNewAttack.image_yscale=abs(image_xscale)
      shootTime=0
    }

    yVel=scrGravAcc(yVel,0.2,1)
    if isCollisionBottom(1)
      yVel=0
    if isCollisionSolid()
      y-=2
    moveTo(xVel*gDeltaTime,yVel*gDeltaTime)

    if y>room_height+30
      instance_destroy()
  }
  enemyStepEvent()
}
