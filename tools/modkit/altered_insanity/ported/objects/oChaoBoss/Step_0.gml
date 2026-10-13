//(60fps change: _speed/_direction for the built-in speed/direction, with correctSpeedDirection at the end; move_towards_point(px,py,s) is
//_direction=point_direction(x,y,px,py) with _speed=s. Where the speed is the distance left (min(distance,maxSpeed)), it's divided by
//gDeltaTime so the last frame still lands on the point)
if global.gamePaused=false
{
  event_inherited()
  if activateBoss=1
  {
    oGlobalEvent.enemyCount=1
    bActive=true
    bShowHealthBar=true
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=2
    showBossHP.bossID=id
    showBossHP.type=0

    jeremyText="Chao learned a lot of different techniques using those circles she used to defeat the parasite! She seems a little reluctant to fight at the moment, go easy on her won't you?"
    chaoText="Wow, this is what it feels to be scanned... Guess you want to learn my big weakness? Okay, I'll tell you... Most of my attacks can only do 1 damage, so don't worry if a few hit you!"
    devText="So basically, I made a whole new character's play style with Chao for my special Chao's Warmaster boss fight. Then I thought to myself 'Wouldn't it be awesome to fight against this style?' so here I am making a boss fight where you fight Chao. Have fun!"

    activateBoss=2
  }

  if bActive=true and life>0
  {

      //waitTime+=1
      waitTime+=1*gDeltaTime //60fps change
      if actCheck=0 //no attack active, fly around at intervals
      {
        if flyDuration = 0 //not flying yet
        {
            //flyTime+=1
            flyTime+=1*gDeltaTime //60fps change
            if flyTime > flyDelay //pick direction and time to fly
            {
                flyTime=0
                flyDuration=4
                //speed = flySpeed
                //direction = random(360)
                _speed = flySpeed //60fps change
                _direction = random(360)
            }
        }
        else
        {
            //flyDuration-=1
            flyDuration-=1*gDeltaTime //60fps change
            if flyDuration=0 // end fly
            {
                //speed=0
                //direction=0
                _speed=0 //60fps change
                _direction=0
            }
        }
      }
      if waitTime>=waitDelay
      {
        if actCheck=0 //---------- Choose an action ----------
        {
            actCheck=1
            if actCheck = 2
            {
                actCheck=2
                actIterations = 5
                actIterationDelay = 15
            }
            else
            {
                actCheck=1
            }

            actPrevious=actCheck
        }
        if actCheck=1 //---------- Spawn Circle and target player
        {

              //actTime+=1
              if actTime=0 {actTime=1-gDeltaTime} //60fps change (added): 1 on the first frame, as at 30fps
              actTime+=1*gDeltaTime //60fps change
              if actTime=1
              {
                //move_towards_point(oPlayer1.x, oPlayer1.y, -maxSpeed) //move away from player a bit
                _direction=point_direction(x,y,oPlayer1.x,oPlayer1.y); _speed=-maxSpeed //60fps change: move away from player a bit
              }
              if actTime = 3 //initial target
              {
                chaoTargetX=x
                chaoTargetY=y
              }
              if actTime = 5 //stop
              {
                //speed = 0
                _speed = 0 //60fps change
              }
              if actTime = 15 //spawn circle
              {
                var tCircle;
                tCircle=instance_create(x,y,oSummonedChaoSpot)
                tCircle.enemyBullets = true
                currentCircle = tCircle
              }
              else if actTime=45 //retarget: go toward player
              {
                //move_towards_point(oPlayer1.x, oPlayer1.y, maxSpeed)
                _direction=point_direction(x,y,oPlayer1.x,oPlayer1.y); _speed=maxSpeed //60fps change
              }
              else if actTime=48 //set new target point and go back to circle
              {
                chaoTargetX=x
                chaoTargetY=y
                //move_towards_point(currentCircle.x, currentCircle.y, maxSpeed)
                _direction=point_direction(x,y,currentCircle.x,currentCircle.y); _speed=maxSpeed //60fps change
              }
              else if actTime = 51 //stop
              {
                //speed = 0
                _speed = 0 //60fps change
              }
              else if actTime > 90 and actTime < 100 //reset position
              {
                //move_towards_point(xCenter, roomFloor - roomHeight / 2, min(distance_to_point(xCenter, roomFloor - roomHeight / 2), maxSpeed))
                _direction=point_direction(x,y,xCenter,roomFloor - roomHeight / 2); _speed=min(distance_to_point(xCenter, roomFloor - roomHeight / 2)/gDeltaTime, maxSpeed) //60fps change
              }
              else if actTime >= 100
              {
                //speed = 0
                _speed = 0 //60fps change
                event_user(0)
              }
        }
        if actCheck=2 //---------- Set up explode circles near player
        {
            if actPhase = 0
            {
                //actTime += 1
                if actTime=0 {actTime=1-gDeltaTime} //60fps change (added): 1 on the first frame, as at 30fps
                actTime += 1*gDeltaTime //60fps change
                if actTime = 1
                {
                    showEmote(oChaoBoss,0,-6,sEmLove)
                }
                if actTime = 15
                {
                    actPhase = 1
                    actTime = 0
                }
            }
            if actPhase = 1 //move towards player, start next phase when close to player
            {
                //move_towards_point(oPlayer1.x, oPlayer1.y, min(distance_to_point(oPlayer1.x, oPlayer1.y), maxSpeed))
                _direction=point_direction(x,y,oPlayer1.x,oPlayer1.y); _speed=min(distance_to_point(oPlayer1.x, oPlayer1.y)/gDeltaTime, maxSpeed) //60fps change
                if (distance_to_point(oPlayer1.x, oPlayer1.y) < 20)
                {
                    actPhase = 2
                    //speed = 0
                    _speed = 0 //60fps change
                }
            }
            if actPhase = 2 //create base circle
            {
                var tCircle;
                tCircle=instance_create(x,y,oSummonedChaoSpot)
                tCircle.enemyBullets = true
                tCircle.shotDelay = 20
                currentCircle = tCircle
                actPhase = 3
            }
            if actPhase = 3 //transform to red circle
            {
                currentCircle.transformColor = 1
                currentCircle.transformStyle = 1
                currentCircle.alarm[0] = 1
                if (actIterations>0)
                {
                    actPhase = 0
                    actTime = 2
                    actIterations-=1
                }
                else
                {
                    event_user(0)
                }
            }
        }
        if actCheck=3 //setup auto turrets in different ways
        {
            if actPhase = 0
            {

            }
        }
      } //wait time
      enemyStepEvent()
  }
}
correctSpeedDirection(self) //60fps change (added): moves by _speed/_direction (it moved by the built-in speed, which GameMaker adds every frame)
