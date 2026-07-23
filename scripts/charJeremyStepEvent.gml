/*
This script should be placed in the step event for the platform character.
It updates the keys used by the character, moves all of the solids, moves the
character, sets the sprite index, and sets the animation speed for the sprite.
*/
if player=1 //========================================
{
  if (attackState!=ACT_ATK or attackState!=ACT_FIRE or attackState!=ACT_FIRE_UP or attackState!=ACT_FIRE_DOWN) and attackState!=ACT_IN_CANNON and attackState!=ACT_HIDE and global.gamePaused=false
  {
    //updates the keys
    //key left
    if walljumpTime=0
    {
      kLeftReleased=0
      if kLeft
      {
        kLeft=scrController(1)
        kLeftPushedSteps+=1
        kLeftPressed=0
        if (kLeft=0) {kLeftReleased=1}
      }
      else
      {
        kLeft=scrController(1)
        if kLeft {kLeftPressed=1}
        kLeftPushedSteps=0
      }
      //key right
      kRightReleased=0
      if kRight
      {
        kRight=scrController(2)
        kRightPushedSteps+=1
        kRightPressed=0
        if kRight=0 {kRightReleased=1}
      }
      else
      {
        kRight=scrController(2)
        if kRight {kRightPressed=1}
        kRightPushedSteps=0
      }
    }
    //key up
    kUpReleased=0
    if kUp
    {
      kUp=scrController(3)
      kUpPushedSteps+=1
      kUpPressed=0
      if kUp=0 {kDownReleased=1}
    }
    else
    {
      kUp=scrController(3)
      if kUp {kUpPressed=1}
      kUpPushedSteps=0
    }

    //key down
    kDownReleased=0
    if kDown
    {
      kDown=scrController(4)
      kDownPushedSteps+=1
      kDownPressed=0
      if kDown=0 {kDownReleased=1}
    }
    else
    {
      kDown=scrController(4)
      if kDown {kDownPressed=1}
      kDownPushedSteps=0
    }

    //key "run"
    //if canRun {kRun=keyboard_check(vk_shift)}
    //else {kRun=0}

    //key "jump"
    if kJump
    {
      kJump=scrController(5)
      kJumpPressed=0
    }
    else
    {
      kJump=scrController(5)
      if kJump {kJumpPressed=1}
    }
    //key "Action A"
    if kActA
    {
      kActA=scrController(6)
      kActAPressed=0
    }
    else
    {
      kActA=scrController(6)
      if kActA {kActAPressed=1}
    }
    //key "Action B"
    if kActB
    {
      kActB=scrController(7)
      kActBPressed=0
    }
    else
    {
      kActB=scrController(7)
      if kActB {kActBPressed=1}
    }
    //key "Action C"
    if kActC
    {
      kActC=scrController(8)
      kActCPressed=0
    }
    else
    {
      kActC=scrController(8)
      if kActC {kActCPressed=1}
    }
    //key "Character Swap"
    if kCharSwap
    {
      kCharSwap=scrController(9)
      kCharSwapPressed=0
    }
    else
    {
      kCharSwap=scrController(9)
      if kCharSwap {kCharSwapPressed=1}
    }
    //key "Ability Swap"
    if kAbilSwap
    {
      kAbilSwap=scrController(10)
      kAbilSwapPressed=0
    }
    else
    {
      kAbilSwap=scrController(10)
      if kAbilSwap {kAbilSwapPressed=1}
    }
    //key "Dash Left"
    if kDashLeft
    {
      kDashLeft=scrController(13)
      kDashLeftPressed=0
    }
    else
    {
      kDashLeft=scrController(13)
      if kDashLeft {kDashLeftPressed=1}
    }
    //key "Dash Right"
    if kDashRight
    {
      kDashRight=scrController(14)
      kDashRightPressed=0
    }
    else
    {
      kDashRight=scrController(14)
      if kDashRight {kDashRightPressed=1}
    }
  }
}

//Deals with the ladderTimer ========================================
if state=CLIMBING {ladderTimer=10}
else
{
  if ladderTimer>0 {ladderTimer-=1}
}

//Allows the character to run left and right
if attackState!=ACT_BLOCK and bTakingDamage=false
{
  if (attackState=0 or platformCharacterIs(IN_AIR)) and global.hasShoes[0]=2 and attackState!=ACT_FIRE and attackState!=ACT_FIRE_UP and attackState!=ACT_FIRE_DOWN
  {
    if kLeftReleased and approximatelyZero(xVel) {xAcc-=0.5}
    if kRightReleased and approximatelyZero(xVel) {xAcc+=0.5}

    if kLeft //----- Run left -----
    {
      idleTime=0
      if kLeftPushedSteps<3
      {
        backDashRecovery=0
      }
      if facing=RIGHT
      {
        groundDashRecovery=0
        airDashRecovery=0
        if dashMomentumTime<20 {dashMomentumTime=0}
      }
      if (kLeftPushedSteps>1 or isCollisionMoveableSolidRight(1)) and (facing=LEFT or approximatelyZero(xVel))
      {
        if state=STANDING
        {
          tEffect=instance_create(oPlayer1.x,oPlayer1.y,oEffect)
          tEffect.sprite_index=sStartRunEffect
          tEffect.image_speed=0.75; tEffect.image_xscale=-1.5; tEffect.image_yscale=1.5
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }

        xAcc-=runAcc
        if platformCharacterIs(IN_AIR) and dashMomentumTime>0
        {
          xAcc-=(xVel/2.1+(dashMomentumTime/2))
          xVel=-(dashVel/2.1+(dashMomentumTime/2))
        }
      }
      if airDashRecovery=0 {facing=LEFT}
    }
    if kRight //----- Run right -----
    {
      idleTime=0
      if kRightPushedSteps<3
      {
        backDashRecovery=0
      }
      if facing=LEFT
      {
        groundDashRecovery=0
        airDashRecovery=0
        if dashMomentumTime<20 {dashMomentumTime=0}
      }
      if (kRightPushedSteps>1 or isCollisionMoveableSolidLeft(1)) and (facing=RIGHT or approximatelyZero(xVel))
      {
        if state=STANDING
        {
          var tEffect;
          tEffect=instance_create(oPlayer1.x,oPlayer1.y,oEffect)
          tEffect.sprite_index=sStartRunEffect
          tEffect.image_speed=0.75; tEffect.image_xscale=1.5; tEffect.image_yscale=1.5
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }

        xAcc+=runAcc
        if platformCharacterIs(IN_AIR) and dashMomentumTime>0
        {
          xAcc+=xVel/2.1+(dashMomentumTime/2)
          xVel=dashVel/2.1+(dashMomentumTime/2)
        }
      }
      if airDashRecovery=0 {facing=RIGHT}
    }
  }
}

if state=CLIMBING and isCollisionLadder()=0
{
  state=FALLING
}
if state=CLIMBING and bTakingDamage=false
{
  if kLeft
  {
    xAcc-=climbAcc
    facing=LEFT
  }
  if kRight
  {
    xAcc+=climbAcc
    facing=RIGHT
  }
  if kUp {yAcc-=climbAcc}
  if kDown {yAcc+=climbAcc}
}

if platformCharacterIs(IN_AIR)
{
  yAcc+=gravityIntensity
}
if (isCollisionBottom(1) or isCollisionPlatformBottom(1) and isCollisionPlatform()=0) and platformCharacterIs(IN_AIR) and yVel>=0
{
  //player has just landed
  //if yVel>0 {playSound(global.snd_JumpLand,0,0.8,1)}
  yVel=0
  yAcc=0
  hopOnCount=0
  state=RUNNING
  jumps=0
  canAirDash=1
  doubleJumpCheck=1
  doubleJumpAnim=0
  if grappleState=0 {busterAnimStay=0}
  airDashDamage=0
}
//fix grounded bug when player object is being pushed down by an external force
if platformCharacterIs(ON_GROUND) and yVel>0.25 {yVel=0}

//if the character has just walked off of the edge of a solid
if isCollisionBottom(1)=0 and (isCollisionPlatformBottom(1)=0 or isCollisionPlatform()) and platformCharacterIs(ON_GROUND)
{
  state=FALLING
  yAcc+=grav
}
if isCollisionTop(1) and state=JUMPING
{
  yVel=abs(yVel*0.3)
  if dashRecHalt=0
  {
    var tEffect;
    for(i=0;i<3;i+=1)
    {
      tEffect=instance_create(oPlayer1.x,oPlayer1.y-48,oEffectB)
      tEffect.type=3; tEffect.sprite_index=sEfDiffusionParticle; tEffect.direction=random(360)+(i*90); tEffect.speed=4; tEffect.newBlend=-1
      tEffect.fadeSpd=0.08; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0; tEffect.friction=0.33
    }
    global.recHeadBonks+=1
  }
}

//player may jump
if bTakingDamage=false
{
  if (grappleState=0 or grappleState=1)
  {
    if platformCharacterIs(ON_GROUND) and attackState!=ACT_BLOCK
    {
      if global.optRightIsForward=0 //Left and Right
      {
        if ((kDown and kJumpPressed and global.optDPadDash=1) or (kDashRightPressed and facing=LEFT) or (kDashLeftPressed and facing=RIGHT)) and dashEnergy>=2000 and global.hasShoes[2]=2 and backDashRecovery=0 //Dash back
        {
          if attackState!=ACT_MORPHBALL
            pMoveDashBack()
        }
        else if ((kUp and kJumpPressed and global.optDPadDash=1) or (kDashLeftPressed and facing=LEFT) or (kDashRightPressed and facing=RIGHT)) and dashEnergy>=2000 and global.hasShoes[2]=2 and groundDashRecovery=0 //Dash forward
        {
          if attackState!=ACT_MORPHBALL
            pMoveDashForward()
        }
        else
        {
          if kJumpPressed
          {
            //give an initial HUGE jump if jump is pressed and flySpeed is big and canFlyJump and the character is running
            if flySpeed>=95 and jumps=0 and canFlyJump
            {
              playSound(global.snd_PlayerJump[0],0,1,1)
              jumps=1
              flyAccTimer=5
              flyDir=facing //either LEFT or RIGHT
              yAcc+=initialJumpAcc*0.7
              if canFly
              {
                flyInitialHeight=y
                flyJumpsTimer=10
                flyJumpWasPressed=-1
              }
            }
            else //----- Normal jump -----
            {
              if global.hasShoes[1]=2
              {
                if attackState!=ACT_MORPHBALL or global.metSpringBall=1
                  pMoveJump()
              }
            }
          }
        }
      }
      else //Right is Forward
      {
        if ((kDown and kJumpPressed and global.optDPadDash=1) or (kDashLeftPressed)) and dashEnergy>=2000 and global.hasShoes[2]=2 and backDashRecovery=0 //Dash back
        {
          if attackState!=ACT_MORPHBALL
            pMoveDashBack()
        }
        else if ((kUp and kJumpPressed and global.optDPadDash=1) or (kDashRightPressed)) and dashEnergy>=2000 and global.hasShoes[2]=2 and groundDashRecovery=0 //Dash forward
        {
          if attackState!=ACT_MORPHBALL
            pMoveDashForward()
        }
        else
        {
          if kJumpPressed
          {
            //give an initial HUGE jump if jump is pressed and flySpeed is big and canFlyJump and the character is running
            if flySpeed>=95 and jumps=0 and canFlyJump
            {
              playSound(global.snd_PlayerJump[0],0,1,1)
              jumps=1
              flyAccTimer=5
              flyDir=facing //either LEFT or RIGHT
              yAcc+=initialJumpAcc*0.7
              if canFly
              {
                flyInitialHeight=y
                flyJumpsTimer=10
                flyJumpWasPressed=-1
              }
            }
            else //----- Normal jump -----
            {
              if global.hasShoes[1]=2
              {
                pMoveJump()
              }
            }
          }
        }
      }
    }
    else if platformCharacterIs(IN_AIR) and mobilityDisable=0 and attackState!=ACT_BLOCK //air dash and air jump
    {
      if (((kUp or kDown) and kJumpPressed and global.optDPadDash=1) or (kDashLeftPressed or kDashRightPressed)) and dashEnergy>=2000 and airDashRecovery=0 and canAirDash=1 and global.hasShoes[3]=2 //Air dash
      {
        pMoveAirDash()
      }
      else //Air jump (Double jump)
      {
        if global.hasShoes[1]=2 and kJumpPressed and global.canDoubleJump=2 and doubleJumpCheck=1
        {
          pMoveDoubleJump()
        }
      }
    }
  }
}

if groundDashRecovery>0 or backDashRecovery>0 {maxDownSlope=14} //Fix Jerry's slope sticking when dashing
else {maxDownSlope=8}

if groundDashRecovery>0 //Continue ground dash - Jerry only
{
  if platformCharacterIs(ON_GROUND)
  {
    var tEffect;
    tEffect=instance_create(oPlayer1.x,oPlayer1.y+1,oEffect)
    tEffect.sprite_index=sMMSmokeCloud
    tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
    tEffect.image_speed=0.5+(groundDashRecovery/25); tEffect.ySpd=-1.8+(groundDashRecovery/8)
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0
  }
  groundDashRecovery-=1
  if facing=RIGHT {xVel=(dashVel+1)}
  else if facing=LEFT {xVel=-(dashVel+1)}
}
if backDashRecovery>0 //Continue ground dash - Jerry only
{
  if platformCharacterIs(ON_GROUND)
  {
    var tEffect;
    tEffect=instance_create(oPlayer1.x,oPlayer1.y+1,oEffect)
    tEffect.sprite_index=sMMSmokeCloud
    tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
    tEffect.image_speed=0.5+(backDashRecovery/25); tEffect.ySpd=-1.8+(backDashRecovery/8)
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0
  }
  backDashRecovery-=1
  if facing=RIGHT {xVel=-(dashVel+1)}
  else if facing=LEFT {xVel=(dashVel+1)}
}
if claireBackDashRec>0 //For Claire only
{
  claireBackDashRec-=1
}

if airDashRecovery>0 //Continue air dash
{
  airDashRecovery-=1
  yVel=-3.5
  if facing=RIGHT {xVel=(dashVel-1)}
  else if facing=LEFT {xVel=-(dashVel-1)}
}

if mobilityDisable>0 {mobilityDisable-=1} //Double jump / Air-dash disable after split party character swap
if dashMomentumTime>0 {dashMomentumTime-=1} //Dash momentum
if doubleJumpAnim>0 {doubleJumpAnim-=1} //Double jump animation

if jumpTime<jumpTimeTotal {jumpTime+=1}
//Let the character continue to jump
if kJump=0 and kDashLeft=0 and kDashRight=0 {jumpButtonReleased=1}
if jumpButtonReleased {jumpTime=jumpTimeTotal}
gravityIntensity=(jumpTime/jumpTimeTotal)*grav

if bTakingDamage=false
{
  if kUp and xVel=0 and xAcc=0 and platformCharacterIs(ON_GROUND) and isCollisionLadder()=0 //Looking up
  {
    if kLeft=0 or kRight=0 {state=LOOKING_UP}
    hopOnCount=0
    canAirDash=1
    doubleJumpCheck=1
    doubleJumpAnim=0
    idleTime=0
    if grappleState=0
    {
      if kUpPushedSteps<3 {busterAnimStay=0}
    }
    airDashDamage=0
  }
  if kUp=0 and state=LOOKING_UP //Go back to a standing position from looking up
  {
    state=STANDING
    hopOnCount=0
    canAirDash=1
    doubleJumpCheck=1
    doubleJumpAnim=0
    idleTime=0
    if grappleState=0 {busterAnimStay=0}
    airDashDamage=0
  }
  
  if kDown and platformCharacterIs(ON_GROUND) and isCollisionLadder()=0 //Drop down platform
  {
    hopOnCount=0
    canAirDash=1
    doubleJumpCheck=1
    doubleJumpAnim=0
    if grappleState=0
    {
      if kDownPushedSteps<3 {busterAnimStay=0}
    }
    airDashDamage=0
    if isCollisionPlatformBottom(1)
    {
      if isCollisionBottom(1)=0
      {
        y+=1
        idleTime=0
        state=FALLING
        yAcc+=grav
      }
      else
      {
        //the character can't move down because there is a solid in the way
        idleTime=0
        state=RUNNING
      }
    }
  }
}

if xVel=0 and xAcc=0 and state=RUNNING //Go back to a standing position from running
{
  state=STANDING
  hopOnCount=0
  canAirDash=1
  doubleJumpCheck=1
  doubleJumpAnim=0
  if grappleState=0 {busterAnimStay=0}
  airDashDamage=0
}
if xAcc!=0 and (state=STANDING or state=LOOKING_UP)
{
  state=RUNNING
  hopOnCount=0
  canAirDash=1
  doubleJumpCheck=1
  doubleJumpAnim=0
  if grappleState=0 {busterAnimStay=0}
  airDashDamage=0
}
if yVel<0 and platformCharacterIs(IN_AIR) {state=JUMPING}
if yVel>0 and platformCharacterIs(IN_AIR) {state=FALLING}
//---------- Slow fall effect ----------
if slowFallTime>0
{
  if slowFallEffect<(jumpTime/jumpTimeTotal)*grav {gravityIntensity=slowFallEffect}
  if slowFallEffect<1 {slowFallEffect+=0.008}
  slowFallTime-=1
}

if (kUp or kDown) and isCollisionLadder() and ladderTimer=0 and bTakingDamage=false
{
  //nullifies the velocity
  xVel=0
  yVel=0
  //nullifies the acceleration
  xAcc=0
  yAcc=0
  state=CLIMBING
}

//---------- Land the Corkscrew Kick ----------
if platformCharacterIs(ON_GROUND) and sprite_index=sJF_Atk_DiveKick
{
  attackState=0
  with oJF_Atk_CorkscrewKick {instance_destroy()}
}

//---------- Ladder ----------
if isCollisionLadder() and state=CLIMBING and kJumpPressed and bTakingDamage=false
{
  if facing=LEFT {xVel=-departLadderXVel}
  else {xVel=departLadderXVel}
  yAcc+=departLadderYVel
  state=JUMPING
  jumpButtonReleased=0
  jumpTime=0
}

//---------- Run (Not used right now) ----------
if kRun and (kLeft or kRight) and bTakingDamage=false
{
  flySpeed+=2
  if state!=LOOKING_UP and state!=CLIMBING and state!=FALLING
  {
    if kLeft
    {
      if flySpeed<70 {xAcc-=runAcc*flySpeed/70} //you can change the value here
      else {xAcc-=runAcc} //you can change the value here
      facing=LEFT
    }
    if kRight
    {
      if flySpeed<70 {xAcc+=runAcc*flySpeed/70 } //you can change the value here
      else {xAcc+=runAcc} //you can change the value here
      facing=RIGHT
    }
  }
}
else {flySpeed-=3}

if bTakingDamage=false
{
  if kJump {flySpeed-=1}
  if (kLeft and xVel>0) or (kRight and xVel<0)
  {
    flySpeed-=10
    flySpeedTimer=0
  }
  //If the character hits a wall
  if (kLeft and isCollisionLeft(1)) or (kRight and isCollisionRight(1))
  {
    flySpeed-=20
    flySpeedTimer=0
  }
}
//Set flySpeed to 100 if the flySpeedTimer is still ticking
if flySpeedTimer>0
{
  flySpeedTimer-=1
  flySpeed=100
}
if flyJumpsTimer>0
{
  if flyJumpWasPressed=-1 {flyJumpWasPressed=0}
  else if kJumpPressed {flyJumpWasPressed=1}
  flySpeed=100
  flyJumpsTimer-=1
  if jumps>1
  {
    gravityIntensity=0.5
  }
}
else if canFly and isCollisionBottom(1)=0 and isCollisionPlatformBottom(1)=0 and isCollisionPlatform()=0 and jumps>0
{
  flySpeed=100
  if jumps>1 {gravityIntensity=0.5}
  if (kJumpPressed or flyJumpWasPressed) and flySpeed>80 and jumps<flyMaxJumps
  {
    jumps+=1
    flyInitialHeight-=50
    flyJumpsTimer=15
    flyJumpWasPressed=-1
    flyAcc2Timer=2
  }
}
//Stops everything if the character jumps on a ladder (and stops moving) or ducks
if state=CLIMBING
{
  flySpeed=0
  flySpeedTimer=0
  flyAccTimer=0
  flyAcc2Timer=0
}
//Causes the actual HUGE jump
if flyAccTimer>0
{
  flyAccTimer-=1
  yAcc-=1
}
if flyAcc2Timer>0
{
  flyAcc2Timer-=1
  if yVel>0 {yVel=0}
  if y<flyInitialHeight and y<flyInitialHeight+200 {yAcc+=(0.014)*(flyInitialHeight-y)-5.014}
  else if y>flyInitialHeight {yAcc-=5}

  if facing=LEFT {xAcc-=2}
  else {xAcc+=2}
}
//Apply the limits of flySpeed
if flySpeed>100
{
  flySpeed=100
  flySpeedTimer=60
}
else if flySpeed<0 {flySpeed=0}

//Exterior forces on the player
if extForceX!=0
{
  xVel+=extForceX
  if extForceX>0 {extForceX-=0.2}
  else if extForceX<0 {extForceX+=0.2}
  if abs(extForceX)<0.4 {extForceX=0}
}
if extForceY!=0
{
  yVel+=extForceY
  if extForceY>0 {extForceY-=0.2}
  else if extForceY<0 {extForceY+=0.2}
  if abs(extForceY)<0.4 {extForceY=0}
}

//Calculates the horizontal and vertical friction, depending on the state of the charater
if state=CLIMBING
{
  xFric=frictionClimbingX
  yFric=frictionClimbingY
}
else
{
  //Decrease the friction when the character is "flying"
  if canFly and jumps>1 {xFric=frictionFlyingX}
  else if flySpeed>50 {xFric=frictionRunningFastX}
  else if platformCharacterIs(IN_AIR) and kLeft=0 and kRight=0 //In air
  {
    if dashMomentumTime>0
    {
      xFric=0.965
    }
    else {xFric=frictionAirX}
  }
  else //On ground
  {
    if dashMomentumTime>19 {xFric=0.965}
    else
    {
      if groundDashRecovery>0 or backDashRecovery>0 {xFric=0.9}
      else {xFric=frictionRunningX}
    }
  }
  //If the character is underwater
  if global.location=49 //In Gate 5
  {
    if isCollisionWaterBottom(-12)
    {
      if yVel>8 //Water splash effect
      {
        var tEffect,tWaterTarget;
        tWaterTarget=instance_position(x,y,oWater)
        if tWaterTarget=noone {tWaterTarget=instance_nearest(x,y,oWater)}
        if y<tWaterTarget.y+32
        {
          for(i=0;i<yVel*3;i+=1)
          {
            tEffect=instance_create(x-4+random(8),y+4,oWaterEffect)
            tEffect.hspeed=random_range(-1.75,1.75); tEffect.vspeed=-random(3)-4
            tEffect.image_xscale=1+random(0.5); tEffect.image_yscale=1+random(0.5)
            tEffect.image_alpha=0.8+random(0.1); tEffect.image_blend=make_color_rgb(50+random(30),110+random(80),255)
            tEffect.fadeSpd=0.02+random(0.02)
          }
        }
        if global.gameProgress<2820 {yVel=8} //Player does not have Gravity Suit
      }

      if global.gameProgress<2820 //Player does not have Gravity Suit
      {
        xFric=frictionWaterXRun

        if state=FALLING and yVel>0 {yFric=frictionWaterYFall}
        else {yFric=frictionWaterYJump}
      }
      else {yFric=1}
    }
    else {yFric=1}
  }
  else //Normal water circumstance
  {
    if isCollisionWaterBottom(-12)
    {
      if yVel>8 //Water splash effect
      {
        playSound(global.snd_Splash,0,0.95,1)
        var tEffect;
        for(i=0;i<yVel*3;i+=1)
        {
          tEffect=instance_create(x-4+random(8),y+4,oWaterEffect)
          tEffect.hspeed=random_range(-1.75,1.75); tEffect.vspeed=-random(3)-4
          tEffect.image_xscale=1+random(0.5); tEffect.image_yscale=1+random(0.5)
          tEffect.image_alpha=0.8+random(0.1); tEffect.image_blend=make_color_rgb(50+random(30),110+random(80),255)
          tEffect.fadeSpd=0.02+random(0.02)
        }
        yVel=8
      }

      xFric=frictionWaterXRun

      if state=FALLING and yVel>0 {yFric=frictionWaterYFall}
      else {yFric=frictionWaterYJump}
    }
    else {yFric=1}
  }

  if isCollisionWaterBottom(-8) //Water walk splash effect
  {
    if !isCollisionWaterTop(-4) and abs(xVel)>2
    {
      var tEffect,tWaterTarget;
      tWaterTarget=instance_position(x,y,oWater)
      if tWaterTarget=noone {tWaterTarget=instance_nearest(x,y,oWater)}
      tEffect=instance_create(x-4+random(8),tWaterTarget.y+4,oWaterEffect)
      tEffect.hspeed=random_range(-1.75,1.75); tEffect.vspeed=-random(3)-4
      tEffect.image_xscale=1+random(0.5); tEffect.image_yscale=1+random(0.5)
      tEffect.image_alpha=0.8+random(0.1); tEffect.image_blend=make_color_rgb(50+random(30),110+random(80),255)
      tEffect.fadeSpd=0.02+random(0.02)
    }
  }
}

yVelLimit=12
//Limits the acceleration if it is too extreme
if xAcc>xAccLimit {xAcc=xAccLimit}
else if xAcc<-1*xAccLimit {xAcc=-1*xAccLimit}
if yAcc>yAccLimit {yAcc=yAccLimit}
else if yAcc<-1*yAccLimit {yAcc=-1*yAccLimit}
//applies the acceleration
xVel+=xAcc
yVel+=yAcc
//nullifies the acceleration
xAcc=0
yAcc=0
//applies the friction to the velocity, now that the velocity has been calculated
xVel*=xFric
yVel*=yFric
//apply the limits since the velocity may be too extreme
if xVel>xVelLimit {xVel=xVelLimit}
else if xVel<-1*xVelLimit {xVel=-1*xVelLimit}
if yVel>yVelLimit {yVel=yVelLimit}
else if yVel<-16 {yVel=-16}
//approximates the "active" variables
if approximatelyZero(xVel) {xVel=0}
if approximatelyZero(yVel) {yVel=0}
if approximatelyZero(xAcc) {xAcc=0}
if approximatelyZero(yAcc) {yAcc=0}
//prepares the character to move up a hill
//we need to use the "slopeYPrev" variable later to know the "true" y previous value
//keep this condition the same
if maxSlope>0 and platformCharacterIs(ON_GROUND) and xVel!=0
{
  slopeYPrev=y
  for(y=y;y>=slopeYPrev-maxSlope;y-=1)
    if isCollisionTop(1)
      break
  slopeChangeInY=slopeYPrev-y
}
else {slopeChangeInY=0}

//moves the character, and balances out the effects caused by other processes
//keep this condition the same
if maxSlope*abs(xVel)>0 and platformCharacterIs(ON_GROUND)
{
  //we need to check if we should dampen out the speed as the character runs on upward slopes
  xPrev=x
  yPrev=slopeYPrev      //we don't want to use y, because y is too high
  yPrevHigh=y          //we'll use the higher previous variable later
  moveTo(xVel,yVel+slopeChangeInY)
  dist=point_distance(xPrev,yPrev,x,y) //overall distance that has been traveled
  //we should have only ran at xVel
  if dist>abs(xVelInteger)
  {
    //show_message(string(dist)+ " "+string(abs(xVelInteger)))
    excess=dist-abs(xVelInteger)
    if xVelInteger<0 {excess*=-1}
    //move back since the character moved too far
    x=xPrev
    y=yPrevHigh  //we need the character to be high so the character can move down
    //this time we'll move the correct distance, but we need to shorten out the xVel a little
    //these lines can be changed for different types of slowing down when running up hills
    //ratio=abs(xVelInteger)/dist*0.9        //can be changed, init: 0.9
    ratio=1.075
    moveTo(round(xVelInteger*ratio),round(yVelInteger*ratio+slopeChangeInY))
  }
}
else
{
  //we simply move xVel and yVel while in the air or on a ladder
  moveTo(xVel,yVel)
}
//move the character downhill if possible
//we need to multiply maxDownSlope by the absolute value of xVel since the character normally runs at an xVel larger than 1
if isCollisionBottom(1)=0 and maxDownSlope>0 and xVelInteger!=0 and platformCharacterIs(ON_GROUND)
{
  //the character is floating just above the slope, so move the character down
  upYPrev=y
  for(y=y;y<=upYPrev+maxDownSlope;y+=1)
    if isCollisionBottom(1) //we hit a solid below
    {
      upYPrev=y //I know that this doesn't seem to make sense, because of the name of the variable, but it all works out correctly after we break out of this loop
      break
    }
  y=upYPrev
}

//The character is no longer taking damage (in recovery state) when they hit the ground
if bTakingDamage=true and (state=STANDING or state=RUNNING or state=LOOKING_UP) and damageTime<26
{
  bTakingDamage=false
}
if damageTime<=recoverTime
{
  bTakingDamage=false
}

if damageTime>=29 //Fix knockback
{
  if image_xscale=1 {xVel=-2}
  else {xVel=2}
}

//---------- Ability use ----------
if bTakingDamage=false {playerTechStart()}

if chargeSoundCheck=1 //Stop charging sound if all charging buttons are released
{
  if kActA=0 and kActB=0 and kActC=0
  {
    SS_StopSound(global.snd_WepCharge)
    chargeSoundCheck=0
  }
}

//---------- Flash time after taking damage ----------
if bCanTakeHit=false
{
  damageTime-=1
  if sprite_index!=sJF_Damaged
  {
    if image_alpha=0.75 {image_alpha=0.25}
    else {image_alpha=0.75}
  }
  if damageTime<=0
  {
    image_alpha=1
    bCanTakeHit=true
    bTakingDamage=false
  }
}

if attackState=ACT_ATK or attackState=ACT_FIRE or attackState=ACT_FIRE_UP or attackState=ACT_FIRE_DOWN or attackState=ACT_BIRD_CALL
{
  if castRecovering<=0
  {
    atkAnimSpd=-1
    jeremyAct=0
    attackState=0
  }
  else {castRecovering-=1}
}

//---------- Figure out what sprite index the character should be -----------
/*
1: Normal Punch
2: Ground Kick
3: Air Kick
4: Uppercut
*/
if attackState=0 and bTakingDamage=false
{
  if state=STANDING or state=LOOKING_UP or state=CLIMBING
  {
    sprite_index=sJF_Idle
  }
  else if state=RUNNING {sprite_index=sJF_Walk}
  else if state=JUMPING {sprite_index=sJF_Jump}
  else if state=FALLING {sprite_index=sJF_Fall}

  if groundDashRecovery>0 {sprite_index=sJF_DashForward}
  else if backDashRecovery>0 {sprite_index=sJF_DashBack}
}
//attack state animations override action states
if bTakingDamage=false
{
  if attackState=ACT_ATK
  {
    if jeremyAct=1 {sprite_index=sJF_Atk_PunchA}
    else if jeremyAct=2 {sprite_index=sJF_Atk_KickA}
    else if jeremyAct=3 {sprite_index=sJF_Atk_KickB}
  }
  else if attackState=ACT_FIRE {sprite_index=sJF_Atk_SpecialA}
  else if attackState=ACT_FIRE_DOWN {sprite_index=sJF_Atk_DiveKick}
  else if attackState=ACT_FIRE_UP {sprite_index=sJF_Atk_PunchUp}
}
else
{
  sprite_index=sJF_Damaged
}

//calculates the image_speed based on the character's velocity and/or state
if state=RUNNING
  image_speed=abs(xVel)*runAnimSpeed+0.1
else if state=CLIMBING
  image_speed=sqrt(sqr(abs(xVel))+sqr(abs(yVel)))*climbAnimSpeed
else if state=STANDING or state=LOOKING_UP
  image_speed=idleAnimSpeed

if attackState!=0
  image_speed=0.5

if atkAnimSpd!=-1 //Do not use attack anim speed unless needed
  image_speed=atkAnimSpd

if sprite_index=sJF_Damaged //Damage state anim speed
  image_speed=0.75
else if sprite_index=sJF_DashBack //Back flip anim speed
  image_speed=0.4
else if sprite_index=sJF_Atk_PunchUp //Uppercut anim fix
  image_speed=0
else if sprite_index=sJF_Atk_DiveKick //Corkscrew anim speed
  image_speed=0.5

//figures out which direction the sprite should be facing
if facing=LEFT {image_xscale=-1}
else if facing=RIGHT {image_xscale=1}

//sets the previous state and the previously previous state
statePrevPrev=statePrev
statePrev=state
attackStatePrevPrev=attackStatePrev
attackStatePrev=attackState

//limit the image_speed to 1 so the animation always looks good
if image_speed>1 {image_speed=1}
