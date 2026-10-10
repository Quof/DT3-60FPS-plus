/*
-- The game's step event.
*/

oGame.players[0] = noone     //players (used when "with( )" structures will not work)
oGame.players_length = 0
with oCharacter
{
  //necessary to reset the "viscid" movement from a moving solid
  viscidMovementOk=1
  //store the characters in the oGame.players variable
  oGame.players[oGame.players_length] = id
  oGame.players_length+=1
}

//since we are not using GM's hspeed and vspeed variables, we need to add in decimal support ourselves (so 0.25 will only move 1 pixel every 4 steps, for example)
oGame.time+=1
//we don't want the time to grow too large
if oGame.time>100000000
  oGame.time=0

if gDeltaDoTicks != 0
{
  //since we are not using GM's hspeed and vspeed variables, we need to add in decimal support ourselves (so 0.25 will only move 1 pixel every 4 steps, for example)
  oGame.time30+=1
  //we don't want the time to grow too large
  if oGame.time30>100000000
    oGame.time30=0
}

//moves all of the solids so that none of them collide with the character
//at 30fps this runs the original code; above 30fps it runs every frame with xVel/yVel kept in 30fps units
with oMovingSolid
{
  if !variable_local_exists("mstFramesLeft") {mstXLeft=0; mstYLeft=0; mstFramesLeft=0; mstXBlocked=0; mstYBlocked=0; mstXV=0; mstYV=0; mstLX=x; mstLY=y; mstEndX=x; mstEndY=y}
  //if something set this solid's position directly since last frame (e.g. snapping it into place), drop the rest of this tick's move
  if x!=mstEndX {mstXLeft=0}
  if y!=mstEndY {mstYLeft=0}
  //velocity is only sampled on 30fps ticks (like the original), so every tick boundary lands exactly where 30fps would;
  //above 30fps that tick's movement is then spread over the frames in between (see below)
  if gDeltaDoTicks != 0
  {
    //applies the acceleration
    xVel+=xAcc
    yVel+=yAcc
  }
  //approximates the "active" variables
  //60fps change (added): only on 30fps ticks, where the velocity is read (as at 30fps, it sees a whole tick's acceleration).
  //Solids that accelerate themselves every frame with *gDeltaTime (oMetalBlock, oBreakRock: 0.2 a tick) only add 0.1/0.05
  //a frame, and every frame that got zeroed here before it could build up, so they never fell
  if gDeltaDoTicks != 0
  {
    if approximatelyZero(xVel)
      xVel=0
    if approximatelyZero(yVel)
      yVel=0
    if approximatelyZero(xAcc)
      xAcc=0
    if approximatelyZero(yAcc)
      yAcc=0
  }
  //moves the solid, pushes the character, carries the character, and stops if the character will be crushed by another solid
  mstXPrev=x
  mstYPrev=y
  if gDeltaTime==1 or gDeltaDoTicks != 0
  {
    //change the decimal arguments to integer variables with relation to time
    xVelFrac=frac(abs(xVel))
    yVelFrac=frac(abs(yVel))
    xVelInteger=0
    yVelInteger=0
    if xVelFrac!=0
      if round(1/xVelFrac)!=0
         xVelInteger=(oGame.time30 mod round(1/xVelFrac)=0)
    if yVelFrac!=0
      if round(1/yVelFrac)!=0
        yVelInteger=(oGame.time30 mod round(1/yVelFrac)=0)
    xVelInteger+=floor(abs(xVel))
    yVelInteger+=floor(abs(yVel))
    if xVel<0
      xVelInteger*=-1
    if yVel<0
      yVelInteger*=-1
    xVelInteger=round(xVelInteger)
    yVelInteger=round(yVelInteger)
  }
  if gDeltaTime!=1
  {
    //above 30fps: velocity is only read on 30fps ticks (anything set mid-tick takes effect on the next tick, as at 30fps).
    //the tick's whole-pixel move worked out above is then spread over the tick's frames, front-loaded,
    //so anything that runs after this on the tick frame sees the solid already moving, exactly as at 30fps
    if gDeltaDoTicks != 0
    {
      mstXV=xVel
      mstYV=yVel
      mstXLeft=xVelInteger
      mstYLeft=yVelInteger
      mstFramesLeft=round(1/gDeltaTime)
    }
    if mstFramesLeft>0
    {
      xVelInteger=sign(mstXLeft)*ceil(abs(mstXLeft)/mstFramesLeft)
      yVelInteger=sign(mstYLeft)*ceil(abs(mstYLeft)/mstFramesLeft)
      mstXLeft-=xVelInteger
      mstYLeft-=yVelInteger
      mstFramesLeft-=1
    }
    else
    {
      xVelInteger=0
      yVelInteger=0
    }
  }
  //calculate the collision bounds of the character -- we'll need it later
  with oCharacter
    calculateCollisionBounds()
  solidIsNearPlayers = 0    //whether the solid is near either of the players
  //determine if the solid is close to a player
  for(i=0;i<oGame.players_length;i+=1)
  {
    if isCollisionRectangle(x-abs(xVelInteger)-sprite_xoffset-2,y-abs(yVelInteger)-sprite_yoffset-2,x+sprite_width+abs(xVelInteger)-sprite_xoffset+2,y+sprite_height+abs(yVelInteger)-sprite_yoffset+2,oGame.players[i].lb,oGame.players[i].tb,oGame.players[i].rb,oGame.players[i].bb)
    {
      solidIsNearPlayers = 1
      break
    }
  }
  if(solidIsNearPlayers)
  {
    //solid is moving to the right
    if xVelInteger>0
    {
      breakNow=0    //whether we should break out of the movement loop because the character is stuck
      for(x=x;x<mstXPrev+xVelInteger;x+=1)
      {
        for(i=0;i<oGame.players_length;i+=1)
        {
          if(viscidTop and isCollisionCharacterTop(1,oGame.players[i]) and ((oGame.players[i]).viscidMovementOk=1 or (oGame.players[i]).viscidMovementOk=2))
          {
            with oGame.players[i]
              if isCollisionRight(1)=0
              {
                x+=1
                viscidMovementOk=2
              }
          }
          else if isCollisionCharacterRight(1,oGame.players[i])
          {
            with oGame.players[i]
              collision=isCollisionRight(1)
            if oGame.players[i].collision
            {
              breakNow = 1
              break
            }
            oGame.players[i].x+=1
          }
        }
        if breakNow
          break
      }
    }
    //solid is moving to the left
    if xVelInteger<0
    {
      breakNow=0    //whether we should break out of the movement loop because the character is stuck
      for(x=x;x>mstXPrev+xVelInteger;x-=1)
      {
        for(i=0;i<oGame.players_length;i+=1)
        {
          if viscidTop and isCollisionCharacterTop(1,oGame.players[i]) and (oGame.players[i].viscidMovementOk=1 or oGame.players[i].viscidMovementOk=2)
          {
            with oGame.players[i]
              if isCollisionLeft(1)=0
              {
                x-=1
                viscidMovementOk=2
              }
          }
          else if isCollisionCharacterLeft(1,oGame.players[i])
          {
            with oGame.players[i]
              collision=isCollisionLeft(1)
            if oGame.players[i].collision
            {
              breakNow = 1
              break
            }
            oGame.players[i].x-=1
          }
        }
        if breakNow
          break
      }
    }
    //solid is moving down
    if yVelInteger>0
    {
      breakNow=0    //whether we should break out of the movement loop because the character is stuck
      for(y=y;y<mstYPrev+yVelInteger;y+=1)
      {
        for(i=0;i<oGame.players_length;i+=1)
        {
          if viscidTop and isCollisionCharacterTop(2,oGame.players[i])
          {
            //since we do not want to include the solid that is pulling the character down,
            //we must alter the position of the solid to get around this dilemma
            y+=5
            with oGame.players[i]
              if isCollisionBottom(1)=0
                y+=1
            y-=5
          }
          else if isCollisionCharacterBottom(1,oGame.players[i])
          {
            with oGame.players[i]
              collision=isCollisionBottom(1)
            if oGame.players[i].collision
            {
              breakNow = 1
              break
            }
            oGame.players[i].y+=1
          }
        }
        if breakNow
          break
      }
    }
    //solid is moving up
    if yVelInteger<0
    {
      breakNow=0    //whether we should break out of the movement loop because the character is stuck
      for(y=y;y>mstYPrev+yVelInteger;y-=1)
      {
        for(i=0;i<oGame.players_length;i+=1)
        {
          //push the character up regardless of the viscid properties of the solid top
          if isCollisionCharacterTop(1,oGame.players[i])
          {
            with oGame.players[i]
              collision=isCollisionTop(1)
            if oGame.players[i].collision
            {
              breakNow = 1
              break
            }
            oGame.players[i].y-=1
          }
          if isCollisionCharacterBottom(1,oGame.players[i])
          {
            //variable jumping causes the character to get stuck to the bottom of a moving solid
            //that is moving faster than 1 pixel per step upwards, so we need this code
            if oGame.players[i].jumpTime<oGame.players[i].jumpTimeTotal
            {
              oGame.players[i].yVel=-2
              oGame.players[i].jumpTime=oGame.players[i].jumpTimeTotal
            }
          }
        }
        if breakNow
          break
      }
    }
    with oCharacter
    {
      if viscidMovementOk=2
        viscidMovementOk=0
    }
  }
  else
  {
    x+=xVelInteger
    y+=yVelInteger
  }
  //for crush checks and shift timers: "blocked" = the last attempt to move failed completely.
  //it stays set on frames with no attempt (sub-pixel speeds) until the solid moves again or stops
  if xVelInteger!=0 {mstXBlocked=(x=mstXPrev)}
  else if xVel=0 and mstXV=0 {mstXBlocked=0}
  if yVelInteger!=0 {mstYBlocked=(y=mstYPrev)}
  else if yVel=0 and mstYV=0 {mstYBlocked=0}
  //"logical" position: where the solid will be once this 30fps tick's move has finished.
  //tick-based logic (e.g. the prevX/prevY shift counters) compares against this, so it sees the same positions as at 30fps
  if gDeltaTime==1 {mstXLeft=0; mstYLeft=0; mstFramesLeft=0}
  mstLX=x+mstXLeft
  mstLY=y+mstYLeft
  mstEndX=x
  mstEndY=y
}
//finished oMovingSolid code
//accelerates the oMoveableSolid objects downwards
with oMoveableSolid
{
  yMPrev=y
  if gDeltaTime==1
  {
    yVel+=oGame.moveableSolidGrav
    //moves the moveable solid down
    for(y=y;y<yMPrev+yVel;y+=1)
    {
      //if there is a collision with a solid or the character one pixel below the moveable solid, we want it to stop
      //is there a (precise) collision
      if place_meeting(x,y+1,oSolid) or isCollisionCharacterBottom(1,0)
      {
        yVel=0
        break
      }
    }
  }
  else
  {
    if !variable_local_exists("mstYRem") {mstYRem=0}
    yVel=scrGravAcc(yVel,oGame.moveableSolidGrav,1)
    mstYRem+=yVel*gDeltaTime
    var tMStep;
    tMStep=floor(mstYRem)
    mstYRem-=tMStep
    //moves the moveable solid down
    for(y=y;y<yMPrev+tMStep;y+=1)
    {
      //if there is a collision with a solid or the character one pixel below the moveable solid, we want it to stop
      if place_meeting(x,y+1,oSolid) or isCollisionCharacterBottom(1,0)
      {
        yVel=0
        mstYRem=0
        break
      }
    }
    //60fps change (added): a moving solid's tick move is spread over the frames, so one rising under this (a water
    //platform) could finish its move after the rock landed on it and end up inside it, and the rock couldn't be pushed
    //any more. Lift it back on top (a few pixels at most; left where it was if that doesn't free it).
    if place_meeting(x,y,oMovingSolid)
    {
      var tLift;
      tLift=0
      while place_meeting(x,y,oMovingSolid) and tLift<4 {y-=1; tLift+=1}
      if place_meeting(x,y,oSolid) {y+=tLift}
      else {yVel=0; mstYRem=0}
    }
  }
}
