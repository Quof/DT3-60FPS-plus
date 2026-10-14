if global.gamePaused=false
{
  if y+48>oPlayer1.y and bActive=false {makeEnemyActive(1)}

  if bActive=true and life>0
  {
    makeEnemyActive(1)
    if rising>=0 and rising<=99
    {
      rising+=1*gDeltaTime
      if rising=1
      {
        if x<oPlayer1.x {image_xscale=1}
        else {image_xscale=-1}
        visible=1
      }
      else if rising=5 {image_index=1}
      else if rising=9 {image_index=2}
      else if rising=13 {image_index=3}
      else if rising>=17
      {
        image_speed=0.15
        sprite_index=sPT_Skeleton_Walk
        detectDistX=264
        detectDistY=200
        bCanDealDamage=true
        bCanTakeDamage=true
        rising=100
      }
    }
    else if rising>=100
    {
      //Turn around if turn timer is 0
      if bJumpReady=1
      {
        if (x<oPlayer1.x and image_xscale=-1) or (x>oPlayer1.x and image_xscale=1)
        {
          turnTime-=1*gDeltaTime
          if turnTime=0
          {
            xVel*=-1
            turnTime=20
          }
        }

        if atkTime<atkDelay //Check direction
        {
          if x<oPlayer1.x {image_xscale=1}
          else {image_xscale=-1}

          if point_distance(x,0,oPlayer1.x,0)<96
          {
            if oPlayer1.attackState=oPlayer1.ACT_ATK {bBlocking=1; sprite_index=sPT_Skeleton_Block}
            else {bBlocking=0; sprite_index=sPT_Skeleton_Walk}
          }
          else {bBlocking=0; sprite_index=sPT_Skeleton_Walk}

          if point_distance(x,0,oPlayer1.x,0)<56 //Movement
          {
            if image_xscale=1 {xVel=-runAcc*0.75}
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
      }

      //Check if cliff edge and jump
      if yVel=0 and bJumpReady=1
      {
        var tDrop;
        tDrop=0
        if aiCheckHoriz(1,1,0,16,4)
        {
          if aiCheckVert(0,3,24,16,4)=1
          {
            tDrop=1
          }
        }

        if tDrop=0
        {
          xVel=(runAcc*1.25)*image_xscale
          y-=4
          yVel=-4
          sprite_index=sPT_Skeleton_Jump
          bJumpReady=0
        }
      }

      //---------- Swing sword ----------
      if sprite_index!=sPT_Skeleton_Block {atkTime+=1*gDeltaTime}
      if atkTime>=atkDelay and bJumpReady=1
      {
        if atkTime=atkDelay //Change anim
        {
          if point_distance(x,0,oPlayer1.x,0)<80
          {
            xVel=0
            //instance_create(x-(74*image_xscale),y-19,oG6_CounterSpark)
            if global.skeletonSparkle=0 {instance_create(x-(74*image_xscale),y-19,oG6_CounterSpark)} else {sparkDone=0} //skeleton sparkle change: made below
            sprite_index=sPT_Skeleton_Swing
            bBlocking=0
            image_speed=0; image_index=0
          }
          else {atkTime=atkDelay-5}
        }
        else if atkTime=atkDelay+18 {image_index=1}
        else if atkTime=atkDelay+22
        {
          playSound(global.snd_DeathSlash,0,0.98,20000)
          bParryOpp=1
          image_index=2
        }
        else if atkTime=atkDelay+26 {image_index=3}
        else if atkTime=atkDelay+30
        {
          bParryOpp=0
          image_index=3
        }
        else if atkTime>=atkDelay+34 //End attack
        {
          sprite_index=sPT_Skeleton_Walk
          image_speed=0.15
          atkTime=0
        }
      }
      //skeleton sparkle change (added): the sparkle (10 ticks) spawns at atkDelay+9, so it has gone 7 ticks before the swing's
      //most horizontal frame (3) at atkDelay+26 (3 ticks before the swing can hurt, at atkDelay+22). It stays at the blade's
      //tip (frame 0: held low behind; frame 1: raised)
      if sparkDone=0 and sprite_index=sPT_Skeleton_Swing and atkTime>=atkDelay+9
      {
        sparkDone=1
        if atkTime-(atkDelay+9)<10
        {
          var tSpark;
          tSpark=instance_create(x+(-74*image_xscale),y+(-19),oG6_CounterSpark)
          tSpark.frameCount=atkTime-(atkDelay+9); tSpark.image_index=atkTime-(atkDelay+9); tSpark.image_angle=10*(atkTime-(atkDelay+9))
          tSpark.followID=id; tSpark.followX=-74; tSpark.followY=-19
          sparkID=tSpark
        }
      }
      if instance_exists(sparkID) and sprite_index=sPT_Skeleton_Swing
      {
        if floor(image_index)<=0 {sparkID.followX=-74; sparkID.followY=-19}
        else {sparkID.followX=-42; sparkID.followY=-64}
      }

      yVel=scrGravAcc(yVel,0.3,1)
      if isCollisionBottom(1)
      {
        yVel=0
        bJumpReady=1
        if sprite_index=sPT_Skeleton_Jump {sprite_index=sPT_Skeleton_Walk}
      }
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
