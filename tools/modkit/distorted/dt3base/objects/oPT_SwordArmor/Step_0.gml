if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and life>0
  {
    if atkTime<atkDelay //Check direction
    {
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}
    }

    if atkTime<atkDelay
    {
      if point_distance(x,0,oPlayer1.x,0)<56 //Movement
      {
        //if image_xscale=1 {xVel=-runAcc*0.75*gDeltaTime}
        if image_xscale=1 {xVel=-runAcc*0.75} //60fps change: xVel is scaled again in moveTo, so facing right it backed away at half/quarter speed at 60/120fps
        else {xVel=runAcc*0.75}
      }
      else if point_distance(x,0,oPlayer1.x,0)>64
      {
        if image_xscale=1 {xVel=runAcc}
        else {xVel=-runAcc}
      }
      else {xVel=0}
    }
    else {xVel=0}

    //Check if at cliff edge and turn around
    tDrop=0
    if aiCheckHoriz(1,1,0,8,4)
    {
      if aiCheckVert(0,1,8,8,4)=1
        tDrop=1
    }
    if tDrop=0
    {
      xVel*=-1
      turnTime=25
    }

    //---------- Swing sword ----------
    atkTime+=1*gDeltaTime
    if atkTime>=atkDelay
    {
      if atkTime=atkDelay //Change anim
      {
        if point_distance(x,0,oPlayer1.x,0)<80
        {
          xVel=0
          sprite_index=sPT_SwordArmor_Swing
          instance_create(x-(44*image_xscale),y-101,oG6_CounterSpark)
          bBlocking=0
          image_speed=0; image_index=0
        }
        else {atkTime=atkDelay-5}
      }
      else if atkTime=atkDelay+10
      {
        playSound(global.snd_DeathSlash,0,0.98,17000)
        bParryOpp=1
        image_index=1
      }
      else if atkTime=atkDelay+14 {image_index=2}
      else if atkTime=atkDelay+18 //End attack
      {
        atkCount+=1
        if atkCount>=2
        {
          bParryOpp=0
          sprite_index=sPT_SwordArmor_Walk
          image_speed=0.15
          atkCount=0
          atkTime=0
        }
        else
        {
          instance_create(x-(44*image_xscale),y-101,oG6_CounterSpark)
          image_index=0
          bParryOpp=0
          atkTime=atkDelay+20
        }
      }
      else if atkTime=atkDelay+32 {atkTime=atkDelay+1}
    }

    yVel=scrGravAcc(yVel,0.3,1)
    if isCollisionBottom(1)
      yVel=0
    if isCollisionLeft(1)
      xVel=runAcc
    if isCollisionRight(1)
      xVel=-runAcc
    if isCollisionSolid()
      y-=2

    moveTo(xVel*gDeltaTime,yVel*gDeltaTime)
    if y>room_height+24
    {
      if questType>0 {enemyQuest(questType)}
      instance_destroy()
    }
  }
  else if life<=0
  {
    deathAnim+=1*gDeltaTime
    image_speed=0
    if deathAnim mod 4=0
    {
      if deathAnim mod 8=0 {playSound(global.snd_HardHit1,0,0.9,1)}
      tEffect=instance_create(x+random_range(-11,11),y-1-random(44),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.04*gDeltaTime
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
