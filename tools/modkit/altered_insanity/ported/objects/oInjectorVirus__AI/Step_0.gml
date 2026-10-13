if global.gamePaused=false
{
  if bActive=0 {makeEnemyActive(1)}
  if life>0
  {
    if bActive=true and stunnedTime=0
    {
      startUpTime+=1*gDeltaTime
      if startUpTime=1 //Appear
      {
        visible=1
        var tEffect;
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sAtkTypeShield; tEffect.followID=-1; tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
        tEffect.newBlend=1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.75; tEffect.image_speed=0.75
      }
      if startUpTime>=15
      {
        if myTarget=-1 //Find new target
        {
          if type=0 //Find facility bot
          {
            if instance_exists(oInfectMe) //Check if a new target exists
            {
              var tTestTgt,tTestDist;
              tTestTgt=instance_nearest(x,y,oInfectMe)
              tTestDist=point_distance(x,y,tTestTgt.x,tTestTgt.y)
              if tTestDist<=416 //Make sure target is close enough
              {
                myTarget=instance_nearest(x,y,oInfectMe)
              }
            }
          }
          else if type=1 //Find facility console
          {
            if instance_exists(oHPF_ConInfect) //Check if a new target exists
            {
              var tTestTgt,tTestDist;
              tTestTgt=instance_nearest(x,y,oHPF_ConInfect)
              tTestDist=point_distance(x,y,tTestTgt.x,tTestTgt.y)
              if tTestDist<=448 //Make sure target is close enough
              {
                myTarget=instance_nearest(x,y,oHPF_ConInfect)
              }
            }
          }
          //Track player
          var myDist,targetSpd;
          targetSpd=5
          myDist=point_distance(x,y,oPlayer1.x,oPlayer1.y-26)
          myDist=round(myDist)

          if myDist<=40 {targetSpd=2}
          else if myDist>=41 and myDist<=80 {targetSpd=4}
          else if myDist>=81 and myDist<=128 {targetSpd=5}
          else if myDist>=129 and myDist<=192 {targetSpd=6}
          else if myDist>=193 and myDist<=240 {targetSpd=7}
          else if myDist>=241 {targetSpd=8}

          maxSpeed=targetSpd
          if x>oPlayer1.x
          {
            if currHspd>-maxSpeed {currHspd-=0.2*gDeltaTime}
            else {currHspd+=0.2*gDeltaTime}
          }
          else if x<oPlayer1.x
          {
            if currHspd<maxSpeed {currHspd+=0.2*gDeltaTime}
            else {currHspd-=0.2*gDeltaTime}
          }
          if y>oPlayer1.y-26
          {
            if currVspd>-maxSpeed {currVspd-=0.2*gDeltaTime}
            else {currVspd+=0.2*gDeltaTime}
          }
          else if y<oPlayer1.y-26
          {
            if currVspd<maxSpeed {currVspd+=0.2*gDeltaTime}
            else {currVspd-=0.2*gDeltaTime}
          }
          _hspeed=currHspd; _vspeed=currVspd
        }
        else
        {
          if instance_exists(myTarget) //Target exists, go toward target
          {
            var myDist,targetSpd;
            targetSpd=5
            myDist=point_distance(x,y,myTarget.x,myTarget.y)
            myDist=round(myDist)

            if myDist<=40 {targetSpd=2}
            else if myDist>=41 and myDist<=80 {targetSpd=4}
            else if myDist>=81 and myDist<=128 {targetSpd=5}
            else if myDist>=129 and myDist<=192 {targetSpd=6}
            else if myDist>=193 and myDist<=240 {targetSpd=7}
            else if myDist>=241 {targetSpd=8}

            maxSpeed=targetSpd

            if x>myTarget.x
            {
              if currHspd>-maxSpeed {currHspd-=0.2*gDeltaTime}
              else {currHspd+=0.2*gDeltaTime}
            }
            else if x<myTarget.x
            {
              if currHspd<maxSpeed {currHspd+=0.2*gDeltaTime}
              else {currHspd-=0.2*gDeltaTime}
            }
            if y>myTarget.y
            {
              if currVspd>-maxSpeed {currVspd-=0.2*gDeltaTime}
              else {currVspd+=0.2*gDeltaTime}
            }
            else if y<myTarget.y
            {
              if currVspd<maxSpeed {currVspd+=0.2*gDeltaTime}
              else {currVspd-=0.2*gDeltaTime}
            }
            _hspeed=currHspd; _vspeed=currVspd
          }
          else {myTarget=-1} //No target exists, reset to find a new target
        }
      }
    }
    else {_hspeed=0; _vspeed=0}
  }
  else if life<=0
  {
    deathAnim+=1*gDeltaTime
    if deathAnim=1
    {
      playSound(global.snd_HardHit1,0,0.9,1)
      image_speed=0
      _hspeed=0; _vspeed=0
      baseColor=c_red; image_blend=c_red
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_xscale=2; tEffect.image_yscale=2; tEffect.image_alpha=0.8
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.03*gDeltaTime
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
else {_hspeed=0; _vspeed=0}

correctHSpeedVSpeed(self)
