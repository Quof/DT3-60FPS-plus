if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0 and life>0
  {
    if armSeq<60
    {
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}
    }

    if image_xscale=1
    {
      offsetLeftX=21
      offsetRightX=-1
    }
    else
    {
      offsetLeftX=-21
      offsetRightX=1
    }

    if armSeq<60
    {
      leftBall.x=x+offsetLeftX; leftBall.y=y+offsetLeftY
      rightBall.x=x+offsetRightX; rightBall.y=y+offsetRightY
    }

    //---------- Arm (Spike) Extend ----------
    armSeq+=1*gDeltaTime
    if armSeq=50
    {
      var tEffect;
      tEffect=instance_create(leftBall.x,leftBall.y,oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    else if armSeq=60 {findLeftDir=point_direction(leftBall.x,leftBall.y,oPlayer1.x,returnPlayerYCenter())}
    //else if armSeq>=61 and armSeq<=80 //Extend left arm
    else if armSeq>60 and armSeq<=80 //Extend left arm //60fps change: covers every frame of tick 61, so the arm reaches as far as at 30fps (3.5px/5.25px short at 60/120fps)
    {
      leftBall.x+=armSpd*cos(degtorad(findLeftDir))*gDeltaTime
      leftBall.y+=-armSpd*sin(degtorad(findLeftDir))*gDeltaTime
    }
    //else if armSeq>=141 and armSeq<=160 //Retract left arm
    else if armSeq>140 and armSeq<=160 //Retract left arm //60fps change: see above
    {
      leftBall.x+=armSpd*cos(degtorad(findLeftDir-180))*gDeltaTime
      leftBall.y+=-armSpd*sin(degtorad(findLeftDir-180))*gDeltaTime
    }

    if armSeq=80
    {
      var tEffect;
      tEffect=instance_create(rightBall.x,rightBall.y,oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    else if armSeq=90 {findRightDir=point_direction(rightBall.x,rightBall.y,oPlayer1.x,returnPlayerYCenter())}
    //else if armSeq>=91 and armSeq<=110 //Extend right arm
    else if armSeq>90 and armSeq<=110 //Extend right arm //60fps change: see above
    {
      rightBall.x+=armSpd*cos(degtorad(findRightDir))*gDeltaTime
      rightBall.y+=-armSpd*sin(degtorad(findRightDir))*gDeltaTime
    }
    //else if armSeq>=171 and armSeq<=190 //Retract right arm
    else if armSeq>170 and armSeq<=190 //Retract right arm //60fps change: see above
    {
      rightBall.x+=armSpd*cos(degtorad(findRightDir-180))*gDeltaTime
      rightBall.y+=-armSpd*sin(degtorad(findRightDir-180))*gDeltaTime
      if armSeq=190 {armSeq=0}
    }

    if room!=rWarshipB //spsp ns
    {
    yVel=scrGravAcc(yVel,0.2,1)
    if isCollisionBottom(1)
      yVel=0
    if isCollisionSolid()
      y-=2
    }

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
    playSound(global.snd_EnemyDieMM,0,1,1)
    tEffect=instance_create(x,y-20,oEffect)
    tEffect.sprite_index=sMMExplosion
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

    tDir=random_range(-2,2)
    tEffect=instance_create(x-(13*image_xscale),y-37,oEffectGrav); tEffect.sprite_index=sHammaHammaPartA; tEffect.type=2
    tEffect.xSpd=tDir; tEffect.ySpd=-3-random(1); tEffect.fadeSpd=0.04; tEffect.rotation=choose(-tDir,tDir)
    tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
    tDir=random_range(-2,2)
    tEffect=instance_create(x+(10*image_xscale),y-37,oEffectGrav); tEffect.sprite_index=sHammaHammaPartA; tEffect.type=2
    tEffect.xSpd=tDir; tEffect.ySpd=-3-random(1); tEffect.fadeSpd=0.04; tEffect.rotation=choose(-tDir,tDir); tEffect.image_blend=c_ltgray
    tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1

    tDir=random_range(-3,3)
    tEffect=instance_create(x+(10*image_xscale),y-30,oEffectGrav); tEffect.sprite_index=sHammaHammaPartB
    tEffect.image_speed=0; tEffect.type=2
    tEffect.xSpd=tDir; tEffect.ySpd=-4-random(2); tEffect.fadeSpd=0.04; tEffect.rotation=choose(-tDir,tDir)
    tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1

    for(i=0;i<4;i+=1)
    {
      tDir=random_range(-4,4)
      tEffect=instance_create(x-(14*image_xscale)+(random(28)*image_xscale),y-34+random(28),oEffectGrav); tEffect.sprite_index=sHammaHammaPartB
      tEffect.image_speed=0; tEffect.image_index=1; tEffect.type=2
      tEffect.xSpd=tDir; tEffect.ySpd=-3-random(2); tEffect.fadeSpd=0.04; tEffect.rotation=choose(-tDir,tDir)
      tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
    }
    with leftBall {instance_destroy()}
    with rightBall {instance_destroy()}
    instance_destroy()
  }
  enemyStepEvent()
}
