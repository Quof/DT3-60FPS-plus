if global.gamePaused=false
{
  if bActive=true and life>0
  {
    if alertMode=0 //Not alert
    {
      myRange.image_blend=c_blue
      for(i=0;i<6;i+=1) {resType[i]=3}; resType[4]=2; resType[5]=2
      if boostResist=1 {resType[1]=2; resType[3]=2}

      if moveType=0 //Move in a set path (stop for a moment before turning around)
      {
        turnTime+=1*gDeltaTime
        if turnTime<turnDelay {_speed=moveSpd}
        else {_speed=0}
        if turnTime>=turnDelay+10
        {
          _direction+=turnDegree
          turnTime=0
        }
      }
      else if moveType=1 //Spin in circle
      {
        //_direction+=turnDegree
        _direction+=turnDegree*gDeltaTime //60fps change: spun 2x/4x as fast at 60/120fps
      }
      else if moveType=2 //Scan(rotate) to set range
      {
        if turnTime<turnDelay {_direction+=scanDegree*gDeltaTime}
        turnTime+=1*gDeltaTime
        if turnTime>=turnDelay+20
        {
          scanDegree*=-1
          turnTime=0
        }
      }
    }
    else if alertMode=1 //Go toward point (Just checking)
    {
      myRange.image_blend=c_yellow
      for(i=0;i<6;i+=1) {resType[i]=2}; resType[4]=1; resType[5]=1
      if boostResist=1 {resType[1]=1; resType[3]=1}

      if movePause=0
      {
        if gDeltaDoTicks { //60fps change (added): planned and followed once per 30fps tick, a whole tick's step at a time as at 30fps (the End Step spreads each step over the tick's frames)
        mp_grid_path(oCS_Grid.myGrid,myPath,x,y,pointX,pointY,1)
        spdChk=(moveSpd*0.9)*moveMod
        if spdChk<2 {spdChk=2}
        else if spdChk>5 {spdChk=5}
        path_start(myPath,spdChk,2,1)
        pathTickSpd=spdChk //60fps change (added): the path's speed on each tick (see the end of the Step)
        if point_distance(x,y,pointX,pointY)<(moveSpd*0.9)*moveMod
        {
          movePause=10
          alertMode=2
        }
        } //60fps change (added)
      }
      else {movePause-=1*gDeltaTime}
    }
    else if alertMode=2 //Go back to position
    {
      myRange.image_blend=c_yellow
      for(i=0;i<6;i+=1) {resType[i]=2}; resType[4]=1; resType[5]=1
      if boostResist=1 {resType[1]=1; resType[3]=1}

      if movePause=0
      {
        if gDeltaDoTicks { //60fps change (added): planned and followed once per 30fps tick, a whole tick's step at a time as at 30fps (the End Step spreads each step over the tick's frames)
        mp_grid_path(oCS_Grid.myGrid,myPath,x,y,xstart,ystart,1)
        spdChk=moveSpd*1.25
        if spdChk>5 {spdChk=5}
        path_start(myPath,spdChk,2,1)
        pathTickSpd=spdChk //60fps change (added): the path's speed on each tick (see the end of the Step)
        if point_distance(x,y,xstart,ystart)<moveSpd*1.25
        {
          _speed=0
          _direction=initDir
          scanDegree=turnDegree
          path_end()
          turnTime=0
          alertMode=0
        }
        } //60fps change (added)
      }
      else {movePause-=1*gDeltaTime}
    }
    else if alertMode=3 //Search for player
    {
      myRange.image_blend=c_red
      for(i=0;i<6;i+=1) {resType[i]=2}; resType[4]=1; resType[5]=1
      if boostResist=1 {resType[1]=1; resType[3]=1}

      alertTime-=1*gDeltaTime
      if alertTime<=120
      {
        if gDeltaDoTicks { //60fps change (added): planned and followed once per 30fps tick, a whole tick's step at a time as at 30fps (the End Step spreads each step over the tick's frames)
        mp_grid_path(oCS_Grid.myGrid,myPath,x,y,oPlayer1.x,returnPlayerYCenter(),1)
        spdChk=moveSpd*0.6
        if spdChk<1.5 {spdChk=1.5}
        else if spdChk>5 {spdChk=5}
        path_start(myPath,spdChk,2,1)
        pathTickSpd=spdChk //60fps change (added): the path's speed on each tick (see the end of the Step)
        } //60fps change (added)

        //if oGame.time mod 10=0
        if oGame.time mod (10/gDeltaTime)=0 //60fps change: fired every 10 frames (2x/4x as many shots at 60/120fps)
        {
          if !collision_line(x+lengthdir_x(21,_direction),y+lengthdir_y(21,_direction),oPlayer1.x,returnPlayerYCenter(),oSolid,1,1)
          {
            tNewAttack=instance_create(x+lengthdir_x(21,_direction),y+lengthdir_y(21,_direction),oNormalBullet)
            tNewAttack.sprite_index=sEBShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=8
            tNewAttack._direction=image_angle
          }
        }
      }
      if alertTime<=0
      {
        alertMode=2
      }
    }

    if boostResist=0 //Boost PIERCE and SHOT resist at half HP
    {
      if life<=maxLife/2
      {
        boostResist=1
      }
    }

    if path_index>=0 {_direction=direction} else {direction=_direction} //60fps change (added): while following a path GM moves it and sets the built-in direction (the vanilla code used direction for both); without this the seeker, its sight range and its shots kept facing the last patrol direction while chasing
    image_angle=_direction
    myRange.x=x+lengthdir_x(21,_direction)
    myRange.y=y+lengthdir_y(21,_direction)
    myRange.image_angle=_direction
  }
  else if life<=0
  {
    if deathAnim==0 {deathAnim=1-gDeltaTime}
    deathAnim+=1*gDeltaTime
    if deathAnim=1
    {
      with myRange {instance_destroy()}
    }
    if deathAnim mod 2=0
    {
      if deathAnim mod 4=0 {playSound(global.snd_BombExplode,0,0.85,1)}
      tEffect=instance_create(x+random_range(-12,12),y+random_range(-12,12),oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.075*gDeltaTime
    if image_alpha<0
    {
      instance_destroy()
    }
  }
  enemyStepEvent()
}
else
{
  _speed=0
  path_end()
  pathStepLeft=0 //60fps change (added): see the End Step
}

//60fps change (added): GM sets its built-in speed to 0 on every step along a path, so a seeker shot while patrolling
//stopped moving that way once it chased. _speed stayed set, and its push every frame, just before GM's path step, made
//GM's facing (direction, measured from where the step started to where it ended) point the wrong way
if path_index>=0 {_speed=0}
correctSpeedDirection(self)
//60fps change (added): the path only moves on 30fps ticks, by a whole tick's step as at 30fps (the same route, turns and
//drift past the point), and the End Step spreads each step over the tick's frames. Moving a little along it every frame
//(and planning it again every frame) made GM's facing follow each short leg of the grid path, so the seeker and its
//sight range jittered, and paths kept going past the point between plans
if path_index>=0 {if gDeltaDoTicks {path_speed=pathTickSpd} else {path_speed=0}}
pathFromX=x; pathFromY=y
