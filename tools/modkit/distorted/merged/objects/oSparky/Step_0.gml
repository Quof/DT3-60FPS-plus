if global.gamePaused=false
{
  makeEnemyActive(0)
  if x>oPlayer1.x {image_xscale=-1}
  else {image_xscale=1}

  if bActive=true and stunnedTime=0
  {
    //Keep from moving too fast if blown away
    if xVel>8 {xVel=8}
    else if xVel<-8 {xVel=-8}
    //if xVel>0 {xVel-=0.05}
    //else if xVel<0 {xVel+=0.05}
    xVel=scrTickAcc(xVel,-0.05*((xVel>0)-(xVel<0)),0) //60fps change: slow down per 30fps tick (scrTickAcc); unscaled, it slowed 2x/4x faster at 60/120fps, so knockback only carried it half/quarter as far

    //Spark attack sequence
    sparkTime+=1*gDeltaTime
    if sparkTime=sparkDelay-15 {image_speed=0.33}
    else if sparkTime=sparkDelay
    {
      if checkScreenArea(x,y,64)=1 {playSound(global.snd_Spark,0,0.75,19000)}
      sprite_index=sSparkySparking
      mySpark=instance_create(x,y-8,oStaticBullet)
      mySpark.sprite_index=sSparkysSpark; mySpark.atkPower=atkPower
    }
    //else if sparkTime>=sparkDelay+1 and sparkTime<=sparkDelay+70
    else if sparkTime>sparkDelay and sparkTime<=sparkDelay+70 //60fps change: covers every frame of tick sparkDelay+1, so the spark follows it from the start
    {
      mySpark.x=x; mySpark.y=y-8
      //mySpark.image_angle+=29; mySpark.image_alpha=0.4+random(0.2)
      mySpark.image_angle+=29*gDeltaTime; if gDeltaDoTicks {mySpark.image_alpha=0.4+random(0.2)} //60fps change: spun 2x/4x too fast at 60/120fps; the alpha flicker picks a new value once per 30fps tick
      if sparkTime mod 20=0
      {
        var tNewAtk;
        for(i=0;i<4;i+=1)
        {
          tNewAtk=instance_create(x,y-8,oPassBullet)
          tNewAtk.sprite_index=sSparkyLightning; tNewAtk.image_speed=0.5
          tNewAtk.atkPower=atkPower; tNewAtk.bulletSpeed=7; tNewAtk.decayTime=-100
          tNewAtk._direction=altBullets+(i*90)
        }
        if altBullets=0 {altBullets=45}
        else {altBullets=0}
      }
    }
    else if sparkTime>=sparkDelay+71
    {
      sprite_index=sSparkyDown
      image_speed=0
      with mySpark {instance_destroy()}
      sparkTime=0
    }

    yVel=scrGravAcc(yVel,0.4,1)
    if sprite_index!=sSparkySparking //Animation control
    {
      if yVel>=0 {sprite_index=sSparkyDown}
      else {sprite_index=sSparkyUp}
    }

    if isCollisionBottom(1)
    {
      yVel=0
      jumpTime+=1*gDeltaTime
      if jumpTime>=jumpDelay
      {
        jumpTime=0
        y-=4
        yVel=-8.25
      }
    }
    if isCollisionTop(1)
      yVel=0
    if isCollisionLeft(1)
      xVel*=-1
    if isCollisionRight(1)
      xVel*=-1
    if isCollisionSolid() and room!=rNGC_LC_A //spsp ns new condition
      y-=2
    //moveTo(xVel*gDeltaTime,yVel*gDeltaTime)
    moveTo((xVel+scrTickAccB(0))*gDeltaTime,yVel*gDeltaTime) //60fps change: scrTickAccB adds the slow-down's per-tick correction (0 when it isn't slowing this frame)
    if y>room_height+24
    {
      if questType>0
        enemyQuest(questType)
      instance_destroy()
    }
  }
  enemyStepEvent()
}
