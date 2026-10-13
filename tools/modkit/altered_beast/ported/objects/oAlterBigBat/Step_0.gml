if global.gamePaused=false
{
  makeEnemyActive(0)
  if life>0
  {
    if bActive=true and stunnedTime=0
    {
      chargeTime+=1*gDeltaTime
      if chargeProg=0 //Normal behavior
      {
        if x<oPlayer1.x
          image_xscale=1
        else
          image_xscale=-1

        if point_distance(x,y,oPlayer1.x,returnPlayerYCenter())>128 //Far from player
        {
          _direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
          _speed=runAcc
        }
        else if point_distance(x,y,oPlayer1.x,returnPlayerYCenter())<112 //Close to player
        {
          chargeTime+=0.5*gDeltaTime
          _direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())-180
          _speed=runAcc/1.5
        }
        else {chargeTime+=0.5*gDeltaTime}

        if chargeTime>=chargeDelay
        {
          if point_distance(x,y,oPlayer1.x,returnPlayerYCenter())<192
          {
            _direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())-180
            image_speed=0.5
            chargeTime=0
            chargeProg+=1
          }
        }
      }
      else if chargeProg=1 //Wait time
      {
        _speed=runAcc/1.5
        if chargeTime>=15 and gDeltaDoTicks //Find _direction to charge
        {
          if random(10)>9.1
          {
            var newMessage;
            newMessage=instance_create(x-46,y-70,oEnemyChat)
            newMessage.enemyMessage="Run for the hills!"
            _direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())-180
          }
          else {_direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())}
          chargeTime=0
          chargeProg+=1
        }
      }
      else if chargeProg=2 //Charge sting
      {
        _speed=runAcc*7
        if chargeTime>=25
        {
          image_speed=0.1
          chargeTime=0
          chargeProg=0
        }
      }
    }
    else
      _speed=0
  }
  else if life<=0
  {
    if deathAnim == 0 {deathAnim = 1-gDeltaTime}; deathAnim+=1*gDeltaTime
    if deathAnim=1
    {
      sprite_index=sWB_BigBat_Die
      yDeath=-(6 + (0.3/2) * ((1/gDeltaTime) - 1) )
    }
    else if deathAnim>1
    {
      y+=yDeath*gDeltaTime
      if yDeath<12 {yDeath+=0.3*gDeltaTime}
      if y>room_height+24 {instance_destroy()}
    }
  }
  enemyStepEvent()
}
else
  _speed=0
correctSpeedDirection(self)
