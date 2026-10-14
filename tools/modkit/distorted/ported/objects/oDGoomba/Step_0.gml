if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0 and life>0
  {
    if initDir=0
    {
      xVel=runAcc
      if x>oPlayer1.x
        xVel*=-1
      initDir=1
    }
    yVel=scrGravAcc(yVel,0.2,1)
    if isCollisionBottom(1)
      yVel=0
    if isCollisionLeftEdit(1)
      xVel*=-1
    if isCollisionRightEdit(1)
      xVel*=-1
    if isCollisionSolid()
      y-=2
    if xVel>0
      image_xscale=1
    else
      image_xscale=-1
    moveTo(xVel*gDeltaTime,yVel*gDeltaTime)
    if y>room_height+24
    {
      if questType>0
        enemyQuest(questType)
      instance_destroy()
    }
  }
  else if life<=0
  {
    //deathAnim+=1
    if deathAnim==0 {deathAnim=1-gDeltaTime} //60fps change (added): so deathAnim is 1 on the first frame, like at 30fps
    deathAnim+=1*gDeltaTime //60fps change: the squashed Goomba vanished after 12 frames instead of 12 ticks (2x/4x too soon at 60/120fps)
    if deathAnim=1
    {
      if bJumpedOn=0
      {
        var tEffect;
        for(i=0;i<6;i+=1)
        {
          tEffect=instance_create(x,bbox_bottom-(sprite_height/2),oKillEffect)
          tEffect.speed=2.66; tEffect.direction=i*60; tEffect.friction=0.11
          tEffect.fadeAlpha=0.025; tEffect.imageRot=0
        }
      }
    }
    else if deathAnim=12 {instance_destroy()}
  }
  enemyStepEvent()
}
