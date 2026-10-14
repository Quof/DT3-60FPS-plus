if global.gamePaused=false
{
  if bActive=0 {makeEnemyActive(0)}
  if bActive=true and stunnedTime=0 and life>0
  {
    if makeSound=0 {makeSound=1} //Delay by 1 frame
    else if makeSound=1
    {
      playSound(global.snd_MetGeep,0,1,22050+random(11025))
      makeSound=2
    }

    if frozen=0
    {
      frmBrain+=0.2*gDeltaTime
      animFang+=1*gDeltaTime
      if animFang=6 {frmFang=1}
      else if animFang=12 {frmFang=2}
      else if animFang=18 {frmFang=1}
      if animFang=24 {frmFang=0; animFang=0}

      if latching=0 //Normal movement
      {
        lifeDrain=0
        if x>oPlayer1.x and xVel>-5.5 {xVel-=0.33*gDeltaTime}
        else if x<oPlayer1.x and xVel<5.5 {xVel+=0.33*gDeltaTime}
        if y>oPlayer1.y and yVel>-5.5 {yVel=scrGravAcc(yVel,-0.33,1)}
        else if y<oPlayer1.y and yVel<5.5 {yVel=scrGravAcc(yVel,0.33,1)}
        //stuck fix (added): latched, it's put on the player's head with no wall check, so it can be left inside a solid when
        //the player stands by a wall or in a narrow gap. Inside one, every side counts as blocked and it never moved again;
        //it now drifts straight towards the player (through the solid) until it's out
        calculateCollisionBounds()
        if collision_rectangle(round(lb),round(tb),round(rb-1),round(bb-1),oSolid,1,1)>0
        {
          x+=xVel*gDeltaTime
          y+=yVel*gDeltaTime
        }
        else
        {
        if isCollisionTop(1) {yVel=1}
        if isCollisionBottom(1) {yVel=-1}
        if isCollisionLeft(1) {xVel=1}
        if isCollisionRight(1) {xVel=-1}
        moveTo(xVel*gDeltaTime,yVel*gDeltaTime)
        }
      }
      else if latching=1 //Latched onto player
      {
        x=oPlayer1.x
        y=oPlayer1.bbox_top-6
        lifeDrain+=1*gDeltaTime
        if global.difficulty=1 and global.bNightmareMode=0
        {
          if lifeDrain mod 16=0 {bCanDealDamage=true}
        }
        else
        {
          if lifeDrain mod 8=0 {bCanDealDamage=true}
        }
      }
      else if latching=2 //Blast away from the player after being hit with explosive type damage
      {
        //blastSpd-=0.5*gDeltaTime
        blastSpd=scrTickAcc(blastSpd,-0.5,0) //60fps change: slow down per 30fps tick (scrTickAcc); slowing a bit every frame made it fly 2-3px further, and blastSpd now lands on 5 exactly as at 30fps
        //moveTo(blastSpd*gDeltaTime*cos(degtorad(blastDir)),-blastSpd*gDeltaTime*sin(degtorad(blastDir)))
        moveTo((blastSpd+scrTickAccB(0))*gDeltaTime*cos(degtorad(blastDir)),-(blastSpd+scrTickAccB(0))*gDeltaTime*sin(degtorad(blastDir))) //60fps change: scrTickAccB adds the slow-down's per-tick correction
        if blastSpd<=5
        {
          xVel=0; yVel=0
          latching=3
        }
      }
      else if latching=3 //Slight wait before seeking player
      {
        unlatchTime-=1*gDeltaTime
        if unlatchTime<=0
        {
          latching=0
        }
      }
    }
    else if frozen>=1 and frozen<16 //Delay frozen damage state to prevent a super missile from killing the metroid if it is the killing shot
    {
      frozen+=1*gDeltaTime
      if (frozen > 16) //failsafe in case it gets a decimal for some reason, this has to be whole.
      {
        frozen = 16
      }
    }
    else if frozen>=16 and frozen<=20 //Frozen state
    {
      for(i=0;i<6;i+=1) {resType[i]=1}
      resType[5]=3
      bCanTakeDamage=true
      life=maxLife
      unlatchTime=0
      frozenTime+=1*gDeltaTime
      if frozenTime>=180 and frozenTime mod 2=0
      {
        if image_blend=baseColor {image_blend=c_red}
        else {image_blend=baseColor}
      }
      if frozenTime>=240
      {
        with mySolid {instance_destroy()} //Destroy solid from frozen state
        for(i=0;i<6;i+=1) {resType[i]=3}
        resType[0]=1
        resType[1]=1
        resType[4]=2
        life=round(maxLife/3)
        baseColor=c_white
        image_blend=baseColor
        bCanDealDamage=true
        stunResist=3
        frozenTime=0
        frozen=0
      }
    }
    else if frozen>=21
    {
      if (deathAnim == 0)
      {
        deathAnim = 1-gDeltaTime
      }
      deathAnim+=1*gDeltaTime
      if deathAnim=1 //Destroy solid from frozen state
      {
        with mySolid {instance_destroy()}
      }
      image_speed=0
      if deathAnim mod 8=0 {playSound(global.snd_BombExplode,0,0.8,1)}
      if deathAnim mod 3=0
      {
        tEffect=instance_create(x+random_range(-14,14),y+random_range(-20,20),oEffect)
        tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
        tEffect.image_alpha=0.5+(image_alpha/3)
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      image_alpha-=0.04*gDeltaTime
      if image_alpha<0
      {
        bNoBonus=false
        enemyDefeat(0,0)
        if global.hudSamus_Missiles[0]<global.hudSamus_Missiles[1] //Drops
        {
          //Force 1 missile
          var tWepDrop;
          tWepDrop=instance_create(bbox_left+2+random(sprite_width-4),bbox_top+2+random(sprite_height-4),oWeaponPickup)
          tWepDrop.sprite_index=sMetroidMissile
          if global.hudSamus_Missiles[0]<global.hudSamus_Missiles[1]/2.5 //If under 50% missile capacity, 1 extra missile drops at 60% chance
          {
            var tItemCheck;
            tItemCheck=round(random(100))
            if tItemCheck<=60
            {
              var tWepDrop;
              tWepDrop=instance_create(bbox_left+2+random(sprite_width-4),bbox_top+2+random(sprite_height-4),oWeaponPickup)
              tWepDrop.sprite_index=sMetroidMissile
            }
          }
        }
        if oPlayer1.lifePercent<=0.8 //If under 80% HP, heart drops at 60% chance
        {
          var tItemCheck;
          tItemCheck=round(random(100))
          if tItemCheck<=60
          {
            var tHeartDrop;
            tHeartDrop=instance_create(bbox_left+2+random(sprite_width-4),bbox_top+2+random(sprite_height-4),oHealthPickup)
            tHeartDrop.sprite_index=sMetroidHealthPickup
          }
        }
        instance_destroy()
      }
    }
  }
  else if life<=0
  {
    if frozen=0
    {
      mySolid=instance_create(x,y,oSolid); mySolid.sprite_index=sMetroidMembrane; mySolid.visible=0
      baseColor=c_blue
      image_blend=baseColor
      life=maxLife
      global.recKillCount-=1
      latching=0
      stunResist=50
      stunnedTime=0
      frozen=1
    }
  }
  enemyStepEvent()
}
