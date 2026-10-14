if global.gamePaused=false
{
  makeEnemyActive(1)
  if room=rMario1_12 {bActive=false} //sleepy Thwomp
  if bActive=true
  {
    if atkProg=0 //Check if player is close
    {
      if findTargetX<atkDistX*2 and y<oPlayer1.y and findTargetY<detectDistY
        image_index=1
      else
        image_index=0

      if findTargetX<atkDistX and y<oPlayer1.y and findTargetY<detectDistY
      {
        if global.location!=40 and gDeltaDoTicks
        {
          if random(100)<2
          {
            var newMessage,tRanMessage;
            newMessage=instance_create(x-46,y-70,oEnemyChat)
            tRanMessage=irandom_range(1,2)
            if tRanMessage=1 {newMessage.enemyMessage="IT'S MY TIME TO SHINE!"}
            else if tRanMessage=2 {newMessage.enemyMessage="IT'S SMASHING TIME!"}
          }
        }
        image_index=2
        yVel=atkSpeed
        atkProg+=1
      }
    }
    else if atkProg=1 //Falling
    {
      if isCollisionBottom(1)
      {
        playSound(global.snd_ThwompHit,0,1,1)
        var tEffect;
        tEffect=instance_create(x+12,bbox_bottom+2,oEffect)
        tEffect.sprite_index=sEfThwompHit; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=1; tEffect.ySpd=0
        tEffect=instance_create(x-12,bbox_bottom+2,oEffect)
        tEffect.sprite_index=sEfThwompHit; tEffect.image_xscale=-1; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=-1; tEffect.ySpd=0
        yVel=0
        y+=1
        atkProg+=1
      }
    }
    else if atkProg=2 //Wait
    {
      atkTime+=1*gDeltaTime
      if atkTime=25
      {
        image_index=0
        yVel=-atkSpeed/3
        atkTime=0
        y-=1
        atkProg+=1
      }
    }
    else if atkProg=3 //Return
    {
      if y<=ystart
      {
        y=ystart
        yVel=0
        atkProg=0
      }
    }
    moveTo(xVel*gDeltaTime,yVel*gDeltaTime)
  }
}
