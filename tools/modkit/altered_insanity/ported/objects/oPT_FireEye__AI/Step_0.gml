if global.gamePaused=false
{
  makeEnemyActive(1)
  if life>0
  {
    if bActive=true
    {
      if approaching=0
      {
        image_alpha+=0.08*gDeltaTime
        if image_alpha>=1
        {
          image_alpha=1
          detectDistX=264
          detectDistY=200
          bCanDealDamage=true
          bCanTakeDamage=true
          approaching=100
        }
      }
      else if approaching=100
      {
        myDir=player_sprite_center()
        myDist=point_distance(x,y,oPlayer1.x,oPlayer1.y-26)
        if moveToward=1
        {
          _direction=myDir
          _speed=runAcc
        }
        else
        {
          _direction=myDir+180
          _speed=runAcc
        }

        if runAcc<2.5 {runAcc+=0.05*gDeltaTime}

        moveChange+=1*gDeltaTime
        if moveChange>=30
        {
          if myDist<=108
          {
            if moveToward=1 {runAcc=1}
            moveToward=0
            moveChange=0
          }
          else if myDist>=136
          {
            if moveToward=0 {runAcc=1}
            moveToward=1
            moveChange=0
          }
        }

        //---------- Shoot Fireballs ----------
        atkTime+=1*gDeltaTime
        if atkTime>=atkDelay
        {
          if atkTime>=atkDelay and atkTime<=atkDelay+14
          {
            if atkTime mod 2=0
            {
              if image_alpha=1 {image_alpha=0.6}
              else {image_alpha=1}
            }
          }
          else if atkTime=atkDelay+15 //Change anim
          {
            image_alpha=1
            playSound(global.snd_Flame1,0,0.9,29000)
            var tNewAttack,tDir;
            tDir=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)
            for(i=0;i<octoAtk;i+=1)
            {
              tNewAttack=instance_create(x,y,oPassBullet)
              tNewAttack.sprite_index=sFireEyeFire; tNewAttack.atkPower=atkPower; tNewAttack.decayTime=-100
              tNewAttack.bCanBeBlocked=1; tNewAttack.blockCost=300; tNewAttack.bParryOpp=1; tNewAttack.damageType="ELEMENTAL"
              tNewAttack._direction=tDir; tNewAttack.depth=9
              if octoAtk=4 {tDir+=90; tNewAttack.bulletSpeed=8}
              else {tDir+=45; tNewAttack.bulletSpeed=5}
            }
          }
          else if atkTime=atkDelay+30 //End attack
          {
            if octoAtk=4 {octoAtk=8}
            else {octoAtk=4}
            atkTime=0
          }
        }
      }
    }
    else {_speed=0}
  }
  else if life<=0
  {
    //deathAnim+=1
    deathAnim+=1*gDeltaTime //60fps change: counted per frame, so the death flames and sounds came 2x/4x as often at 60/120fps
    _speed=0
    if deathAnim mod 4=0
    {
      if deathAnim mod 8=0 {playSound(global.snd_HardHit1,0,0.9,1)}
      tEffect=instance_create(x+random_range(-13,13),y+random_range(-13,13),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.04*gDeltaTime
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
else {_speed=0}

correctSpeedDirection(self)
