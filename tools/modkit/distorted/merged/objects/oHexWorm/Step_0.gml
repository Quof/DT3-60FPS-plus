if global.gamePaused=false
{
  event_inherited()
  if bActive=true and life>0
  {
    //image_angle=_direction
    if moveBehavior=1 {image_angle=direction} else {image_angle=_direction} //60fps change: while following a path the head is moved by GM, which sets the built-in direction (_direction is only set for the go-to-position and shooting behaviors)
    if moveBehavior=0 //Decide on a move type
    {
      if movePath=1
      {
        instance_create(oEvShooter.spawnX,oEvShooter.spawnY2,oC_Butterdroid)
        instance_create(oEvShooter.spawnX,oEvShooter.spawnY6,oC_Sparker)
        targetPath=pth_HW_A; x=528; y=80
      }
      else if movePath=2 {targetPath=pth_HW_B; x=432; y=-32}
      else if movePath=3 {targetPath=pth_HW_C; x=432; y=384}
      else if movePath=4 {targetPath=pth_HW_D; x=-32; y=192}
      //path_start(targetPath,moveSpd,0,true)
      path_start(targetPath,moveSpd*gDeltaTime,0,true) //60fps change: path speed is per frame; unscaled, the first frame of each path moved a whole tick's distance
      with oHW_Body //Reset all body parts
      {
        x=oHexWorm.x; y=oHexWorm.y
        bCanTakeDamage=true
        //path_start(oHexWorm.targetPath,oHexWorm.moveSpd,0,true)
        path_start(oHexWorm.targetPath,oHexWorm.moveSpd*gDeltaTime,0,true) //60fps change: see above
        myMoveCheck=0
        var tDelay;
        tDelay=round(32/oHexWorm.moveSpd)
        fireTime=30-(bodySeg*2)
        moveDelay=tDelay+(bodySeg*tDelay)
      }
      moveBehavior=1
    }
    else if moveBehavior=1 //Follow a path
    {
      path_speed=moveSpd*gDeltaTime
      if partCheck>=partNum //Iterate to new path
      {
        if bossProgress=0 and partNum<=18 {moveSpd=5; bossProgress+=1}
        else if bossProgress=1 and partNum<=12 {moveSpd=6; bossProgress+=1}
        partCheck=0
        if false          //spsp
        {
        movePath+=1
        if movePath=5 {movePath=1}
        }
        else
        {
            movePath+=3
            if movePath>4 {movePath-=4}
        }
        moveBehavior=0
      }
      if partNum=0 //All body parts eaten
      {
        path_speed=0
        moveBehavior=2
      }
    }
    else if moveBehavior=2 //Go to position
    {
      _direction=point_direction(x,y,384,176)
      _speed=4
      if point_distance(x,y,384,176)<=_speed*gDeltaTime
      {
        for(i=0;i<6;i+=1)
        {
          resType[i]=3
        }
        _speed=0
        movePath=30
        partCheck=0
        moveBehavior=3
      }

    }
    else if moveBehavior=3 //Shoot bullets
    {
      _direction=point_direction(x,y,oPlayer1.x,oPlayer1.y)

      movePath+=1*gDeltaTime

      if movePath>=60
      {
        if movePath mod 8=0
        {
          playSound(global.snd_LaserA,0,0.9,32000)
          var tNewAttack,tDir;
          tDir=point_direction(x,y,oPlayer1.x,oPlayer1.y)
          for(i=0;i<14;i+=1)
          {
            tNewAttack=instance_create(x,y,oPassBullet)
            tNewAttack.sprite_index=sHexWormLaser; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4
            tNewAttack.decayTime=-100; tNewAttack._direction=partCheck+tDir
            tDir+=360/14
          }
          partCheck+=8
          if partCheck>=80
          {
            partCheck=0
            movePath=0
          }
        }
      }
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.8 and lifePercent>=0.61 and bossProgress=2
    {
      bossProgress+=1
    }
    else if lifePercent<=0.6 and lifePercent>=0.41 and bossProgress=3
    {
      bossProgress+=1
    }
    else if lifePercent<=0.4 and lifePercent>=0 and bossProgress=4
    {
      for(i=0;i<6;i+=1)
      {
        resType[i]=1
      }
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    with oEProjectileBase
    {
      var tEffect;
      tEffect=instance_create(x,y,oEffectB)
      tEffect.type=3; tEffect.sprite_index=sWitchFire; tEffect.newBlend=-1; tEffect.fadeSpd=0.1
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
      instance_destroy()
    }
    oHUD.dragoonBossCheck=0
    playSound(global.snd_HealthPickup,0,1,1)
    oPlayer1.life=oPlayer1.maxLife
    instance_destroy()
  }
  enemyStepEvent()
}
else {path_speed=0; _speed=0}

correctSpeedDirection(self)
