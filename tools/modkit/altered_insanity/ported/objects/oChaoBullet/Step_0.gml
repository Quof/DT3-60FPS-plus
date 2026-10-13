if global.gamePaused=false
{
  //speed=maxSpeed
  _speed=maxSpeed //60fps change: _speed/_direction (correctSpeedDirection below)

  if (maxBounces > 0)
  {
    //if(place_meeting(x + hspeed, y, oInvisibleSolid))
    if(place_meeting(x + lengthdir_x(_speed,_direction)*gDeltaTime, y, oInvisibleSolid)) //60fps change: this frame's move (hspeed was the 30fps frame's)
    {
        //direction = -direction + 180;
        //image_angle = direction
        _direction = -_direction + 180; //60fps change
        image_angle = _direction
        maxBounces -= 1
        atkPower += 20
        event_user(0)
    }

    //Vertical bounce
    //if(place_meeting(x, y + vspeed, oInvisibleSolid))
    if(place_meeting(x, y + lengthdir_y(_speed,_direction)*gDeltaTime, oInvisibleSolid)) //60fps change: this frame's move
    {
        //direction = -direction;
        //image_angle = direction
        _direction = -_direction; //60fps change
        image_angle = _direction
        maxBounces -= 1
        atkPower += 20
        event_user(0)
    }
  }

  if (homeLevel > 0)
  {
    if instance_exists(oEnemyBase) {tFindClosest=instance_nearest(x,y,oEnemyBase)}
    else {tFindClosest=oPlayer1}
    tDir=point_direction(x,y,tFindClosest.x,tFindClosest.y)

    while _direction<0 {_direction+=360} //60fps change (added): 0 to 360, as GameMaker kept the built-in direction (the turning below counts on it)
    while _direction>=360 {_direction-=360}
    var tTurn; //60fps change (added): the most it turns this frame: maxTurnAngle a 30fps tick
    tTurn=maxTurnAngle*gDeltaTime
    //dirDiff = direction - tDir
    dirDiff = _direction - tDir //60fps change
    if(abs(dirDiff) > 180)
    {
        //if(direction > tDir)
        if(_direction > tDir) //60fps change
        {
            //dirDiff = -1 * ((360 - direction) + tDir);
            dirDiff = -1 * ((360 - _direction) + tDir); //60fps change
        }
        else
        {
            //dirDiff = (360 - tDir) + direction;
            dirDiff = (360 - tDir) + _direction; //60fps change
        }
    }
    if dirDiff > 0
    {
        //if dirDiff > maxTurnAngle
        if dirDiff > tTurn //60fps change
        {
            //direction -= maxTurnAngle
            _direction -= tTurn //60fps change
        }
        else
        {
            //direction -= dirDiff
            _direction -= dirDiff //60fps change
        }
    }
    else if dirDiff < 0
    {
        //if dirDiff < -maxTurnAngle
        if dirDiff < -tTurn //60fps change
        {
            //direction += maxTurnAngle
            _direction += tTurn //60fps change
        }
        else
        {
            //direction -= dirDiff
            _direction -= dirDiff //60fps change
        }
    }
    //image_angle = direction
    image_angle = _direction //60fps change
  }
}
//else {speed=0}
else {_speed=0} //60fps change
correctSpeedDirection(self) //60fps change (added): moves by _speed/_direction (it moved by the built-in speed, which GameMaker adds every frame)
