if global.gamePaused=false
{
  makeEnemyActive(0)
  if immortal=true {life=maxLife} //spsp ns
  if life>0
  {
    if bActive=true and stunnedTime=0
    {
      if eProg=0 //Fly when player is close enough or took damage
      {
        if point_distance(x,y,oPlayer1.x,returnPlayerYCenter())<216 {eProg=1}
        if life<maxLife {eProg=1}
      }
      else if eProg=1 //Fly up
      {
        if x<oPlayer1.x {image_xscale=1}
        else {image_xscale=-1}

        sprite_index=sStealthBugFly
        y-=2*gDeltaTime
        image_alpha-=0.02*gDeltaTime
        riseTime+=1*gDeltaTime
        if riseTime>=45 {eProg=2}
      }
      else if eProg=2 //Normal behavior
      {
        chargeTime+=1*gDeltaTime
        if chargeProg=0 //Normal
        {
          if image_alpha>0.06 {image_alpha-=0.02*gDeltaTime}

          if x<oPlayer1.x {image_xscale=1}
          else {image_xscale=-1}

          if point_distance(x,0,oPlayer1.x,0)>20 //Seek player y
          {
            if image_xscale=1 {x+=runAcc*gDeltaTime}
            else {x-=runAcc*gDeltaTime}
          }

          if y>oPlayer1.y-128 {y-=3*gDeltaTime}
          else if y<oPlayer1.y-144 and gDeltaDoTicks {y+=1}

          if chargeTime>=chargeDelay
          {
            if point_distance(x,y,oPlayer1.x,returnPlayerYCenter())<192
            {
              _direction=player_sprite_center()-180
              image_speed=0.5
              chargeTime=0
              chargeProg+=1
            }
          }
        }
        else if chargeProg=1 //Wait time
        {
          _speed=runAcc/1.5
          image_alpha+=0.02*gDeltaTime

          if chargeTime>=12 //Find direction to charge
          {
            _direction=player_sprite_center()
            chargeTime=0
            chargeProg+=1
          }
        }
        else if chargeProg=2 //Charge sting
        {
          _speed=runAcc*7
          if chargeTime>=21
          {
            _speed=0
            image_speed=0.2
            chargeTime=0
            chargeProg=0
          }
        }
      }
    }
    else {_speed=0}
  }
  enemyStepEvent()
}
else {_speed=0}
correctSpeedDirection(self)
