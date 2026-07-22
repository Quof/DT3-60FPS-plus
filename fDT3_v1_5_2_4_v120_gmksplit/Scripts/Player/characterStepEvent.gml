/* !scriptId=1 */
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
        kLeftPushedSteps+=1*gDeltaTime
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
        kRightPushedSteps+=1*gDeltaTime
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
      kUpPushedSteps+=1*gDeltaTime
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
      kDownPushedSteps+=1*gDeltaTime
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
  if ladderTimer>0 {ladderTimer-=1*gDeltaTime}
}

//Allows the character to run left and right
if attackState!=ACT_IN_BIKE and attackState!=ACT_BLOCK and (grappleState=0 or grappleState=1) and bTakingDamage=false
{
  if state!=DUCKING and state!=CLIMBING and global.hasShoes[0]=2
  {
    if kLeftReleased and approximatelyZero(xVel) {xAcc-=0.5}
    if kRightReleased and approximatelyZero(xVel) {xAcc+=0.5}
    
    if kLeft //-------------------- Run left --------------------
    {
      idleTime=0
      if kLeftPushedSteps<3
      {
        backDashRecovery=0
        if global.activeCharacter=1 and claireBackDashRec>0
        {
          dashMomentumTime=0; claireBackDashRec=0
        }
      }
      if facing=RIGHT
      {
        groundDashRecovery=0
        airDashRecovery=0
        if dashMomentumTime<25 {dashMomentumTime=0}
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
        
        if global.activeCharacter=0 //Jerry
        {
          xAcc-=runAcc
          if platformCharacterIs(IN_AIR) and dashMomentumTime>0
          {
            xAcc-=(xVel/2.1+(dashMomentumTime/2))
            xVel=-(dashVel/2.1+(dashMomentumTime/2))
          }
        }
        else //Claire (Forward dash hold)
        {
          xAcc-=runAcc
          if dashMomentumTime>=1
          {
            if platformCharacterIs(IN_AIR)
            {
              xAcc-=(xVel/2.1+(dashMomentumTime/1.95))
              xVel=-(dashVel/2.1+(dashMomentumTime/1.95))
            }
            if kLeftPushedSteps<=1 {dashMomentumTime=0} //3
          }
        }
      }
      if airDashRecovery=0 {facing=LEFT}
    }
    if kRight //-------------------- Run right --------------------
    {
      idleTime=0
      if kRightPushedSteps<3
      {
        backDashRecovery=0
        if global.activeCharacter=1 and claireBackDashRec>0
        {
          dashMomentumTime=0; claireBackDashRec=0
        }
      }
      if facing=LEFT
      {
        groundDashRecovery=0
        airDashRecovery=0
        if dashMomentumTime<25 {dashMomentumTime=0}
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
        
        if global.activeCharacter=0 //Jerry
        {
          xAcc+=runAcc
          if platformCharacterIs(IN_AIR) and dashMomentumTime>0
          {
            xAcc+=xVel/2.1+(dashMomentumTime/2)
            xVel=dashVel/2.1+(dashMomentumTime/2)
          }
        }
        else //Claire (Forward dash hold)
        {
          xAcc+=runAcc
          if dashMomentumTime>=1
          {
            if platformCharacterIs(IN_AIR)
            {
              xAcc+=xVel/2.1+(dashMomentumTime/1.95)
              xVel=dashVel/2.1+(dashMomentumTime/1.95)
            }
            if kRightPushedSteps<=1 {dashMomentumTime=0} //3
          }
        }
      }
      if airDashRecovery=0 {facing=RIGHT}
    }
  }
  else if state=DUCKING
  {
    if global.hasShoes[0]=2
    {
      if facing=LEFT and kRight {facing=RIGHT}
      else if facing=RIGHT and kLeft {facing=LEFT}
    }
  }
}
else if attackState=ACT_IN_BIKE //On bike
{
  if kActA and kActAPressed=1 and bTakingDamage=false
  {
    if instance_number(oBikeShot)<2
    {
      playSound(global.snd_MMBuster[0],0,1,1)
      var newBikeEffect,newBikeShot;
      newBikeEffect=instance_create(oPlayer1.x+24,oPlayer1.y-15,oEffect)
      newBikeEffect.sprite_index=sEfAbilSwap; newBikeEffect.xSpd=-2
      newBikeEffect.image_xscale=0.5; newBikeEffect.image_yscale=0.5
      newBikeEffect.followID=oPlayer1.id; newBikeEffect.xFollow=24; newBikeEffect.yFollow=-15
      newBikeEffect.newBlend=-1; newBikeEffect.decay=-100; newBikeEffect.xSpd=0; newBikeEffect.ySpd=0
      newBikeShot=instance_create(x+16,y-15,oBikeShot)
    }
  }
  
  if (kActC or kDashLeft or kDashRight) and bikeBoost>=5 and bTakingDamage=false
  {
    instance_create(x,y,oPlayerAfterImage)
    var newSpdEffect;
    newSpdEffect=instance_create(oPlayer1.x+20-random(20),oPlayer1.y-24+random(22),oEffect)
    newSpdEffect.sprite_index=sMMchargeEffect1; newSpdEffect.image_speed=0.5+random(0.1); newSpdEffect.xSpd=-1-random(1)
    newSpdEffect.newBlend=-1; newSpdEffect.followID=-1; newSpdEffect.decay=-100
    newSpdEffect.xSpd=0; newSpdEffect.ySpd=0
    
    xAcc+=8.05
    maxSlope=15; maxDownSlope=15
    bikeBoost-=5*gDeltaTime
    if bikeBoost<0 {bikeBoost=0}
  }
  else
  {
    xAcc+=5.7
    maxSlope=11; maxDownSlope=11
  }
}
else if grappleState=3
{
  if kLeft {facing=LEFT}
  if kRight {facing=RIGHT}
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

xAccInputWalk = xAcc

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
    var tEffect,tYY;
    if attackState=ACT_MORPHBALL {tYY=14}
    else {tYY=45}
    for(i=0;i<3;i+=1)
    {
      tEffect=instance_create(oPlayer1.x,oPlayer1.y-tYY,oEffectB)
      tEffect.type=3; tEffect.sprite_index=sEfDiffusionParticle; tEffect.direction=random(360)+(i*90); tEffect.speed=4; tEffect.newBlend=-1
      tEffect.fadeSpd=0.08; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0; tEffect.friction=0.33
    }
    global.recHeadBonks+=1
  }
}

//---------- Wall jump ----------
if bCanWallJump=1 and attackState!=ACT_MORPHBALL and attackState!=ACT_IN_BIKE and (grappleState=0 or grappleState=1)
{
  if bTakingDamage=false
  {
    if isCollisionRight(3) and platformCharacterIs(IN_AIR) and facing=RIGHT //right wall
    {
      canAirDash=1
      doubleJumpCheck=1
      if (((kDown or kUp) and kJumpPressed and global.optDPadDash=1) or (kDashLeftPressed or kDashRightPressed)) and dashEnergy>=2000
      {
        pMoveWallDash(0)
      }
      else
      {
        if kJumpPressed
        {
          pMoveWallJump(0)
        }
      }
    }
    else if isCollisionLeft(3) and platformCharacterIs(IN_AIR) and facing=LEFT //left wall
    {
      canAirDash=1
      doubleJumpCheck=1
      if (((kDown or kUp) and kJumpPressed and global.optDPadDash=1) or (kDashLeftPressed or kDashRightPressed)) and dashEnergy>=2000
      {
        pMoveWallDash(1)
      }
      else
      {
        if kJumpPressed
        {
          pMoveWallJump(1)
        }
      }
    }
  }
  if walljumpTime>0 {walljumpTime-=1*gDeltaTime}
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
        if ((kDown and kJumpPressed and global.optDPadDash=1) or (kDashRightPressed and facing=LEFT) or (kDashLeftPressed and facing=RIGHT)) and dashEnergy>=2000 and global.hasShoes[2]=2 and backDashRecovery=0 and attackState!=ACT_IN_BIKE //Dash back
        {
          if attackState!=ACT_MORPHBALL and attackState!=ACT_ON_YOSHI
          {
            pMoveDashBack()
          }
        }
        else if ((kUp and kJumpPressed and global.optDPadDash=1) or (kDashLeftPressed and facing=LEFT) or (kDashRightPressed and facing=RIGHT)) and dashEnergy>=2000 and global.hasShoes[2]=2 and groundDashRecovery=0 and attackState!=ACT_IN_BIKE //Dash forward
        {
          if attackState!=ACT_MORPHBALL and attackState!=ACT_ON_YOSHI
          {
            pMoveDashForward()
          }
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
              //yAcc+=initialJumpAcc*0.7
              yVel+=initialJumpAcc*0.7
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
                {
                  pMoveJump()
                }
              }
            }
          }
        }
      }
      else //Right is Forward
      {
        if ((kDown and kJumpPressed and global.optDPadDash=1) or (kDashLeftPressed)) and dashEnergy>=2000 and global.hasShoes[2]=2 and backDashRecovery=0 and attackState!=ACT_IN_BIKE //Dash back
        {
          if attackState!=ACT_MORPHBALL and attackState!=ACT_ON_YOSHI
          {
            pMoveDashBack()
          }
        }
        else if ((kUp and kJumpPressed and global.optDPadDash=1) or (kDashRightPressed)) and dashEnergy>=2000 and global.hasShoes[2]=2 and groundDashRecovery=0 and attackState!=ACT_IN_BIKE //Dash forward
        {
          if attackState!=ACT_MORPHBALL and attackState!=ACT_ON_YOSHI
          {
            pMoveDashForward()
          }
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
              //yAcc+=initialJumpAcc*0.7
              yVel+=initialJumpAcc*0.7
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
                {
                  pMoveJump()
                }
              }
            }
          }
        }
      }
    }
    else if platformCharacterIs(IN_AIR) and mobilityDisable=0 and bWallGrab=0 and attackState!=ACT_MORPHBALL and attackState!=ACT_IN_BIKE and attackState!=ACT_BLOCK //air dash and air jump
    {
      if global.activeCharacter=0 or global.activeCharacter=1
      {
        if (((kUp or kDown) and kJumpPressed and global.optDPadDash=1) or (kDashLeftPressed or kDashRightPressed)) and dashEnergy>=2000 and airDashRecovery=0 and canAirDash=1 and global.hasShoes[3]=2 //Air dash
        {
          if attackState!=ACT_ON_YOSHI
          {
            pMoveAirDash()
          }
        }
        else //Air jump (Double jump)
        {
          if global.hasShoes[1]=2 and kJumpPressed and global.canDoubleJump=2 and doubleJumpCheck=1
          {
            if attackState!=ACT_ON_YOSHI
            {
              pMoveDoubleJump()
            }
          }
        }
      }
      else
      {
        if jumpTime=jumpTimeTotal and kJump and mechFuel>0
        {
          bUseFuel=1
          mechFuel-=1*gDeltaTime
          yVel=0
          yAcc=-mechBoostAcc
        }
        else {bUseFuel=0}
      }
    }
  }
  else if grappleState=3
  {
    if kJumpPressed
    {
      if kDown
      {
        yAcc=2
      }
      else
      {
        playSound(global.snd_PlayerJump[2],0,1,1)
        global.recJumped+=1
        if bombJump=0 {yAcc=initialJumpAcc}
        else {yAcc=initialJumpAcc*bombAcc}
        bombJump=0
        //xAcc+=xVel/2
        var tEffect;
        tEffect=instance_create(oPlayer1.x,oPlayer1.y+2,oEffect)
        tEffect.sprite_index=sSpellCast; tEffect.image_xscale=0.6; tEffect.image_yscale=0.6
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      grappleID.reuseTime=20
      idleTime=0
      busterAnimStay=0
      state=FALLING
      jumpButtonReleased=0
      jumpTime=0
      grappleState=0
    }
  }
  
  //Jump off Yoshi
  if platformCharacterIs(IN_AIR) and mobilityDisable=0 and bWallGrab=0 and kJumpPressed and kUp and attackState=ACT_ON_YOSHI
  {
    playSound(global.snd_PlayerJump[1],0,0.95,1)
    instance_create(x,y,oBTB_GetOnYoshi)
    instance_create(0,0,oBTB_YoshiJump)
    attackState=0
  }
}

if global.activeCharacter=2
{
  if platformCharacterIs(ON_GROUND)
  {
    bUseFuel=0
    mechFuel=mechMaxFuel
  }
}

if groundDashRecovery>0 or backDashRecovery>0 {maxDownSlope=14} //Fix Jerry's slope sticking when dashing
else {maxDownSlope=8}

if bombJump>0 //Remove bomb boosted effect
{
  tEffect=instance_create(oPlayer1.x-8+random(16),oPlayer1.y-6+random(4),oEffect)
  tEffect.sprite_index=sSamusMissileEffect; tEffect.image_alpha=0.4+random(0.4); tEffect.image_speed=0.2+random(0.2)
  tEffect.decay=-100; tEffect.xSpd=random_range(-0.5,0.5); tEffect.ySpd=1+random(2)
  tEffect.newBlend=-1; tEffect.followID=-1
  bombJump-=1*gDeltaTime
}

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
  groundDashRecovery-=1*gDeltaTime
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
  backDashRecovery-=1*gDeltaTime
  if facing=RIGHT {xVel=-(dashVel+1)}
  else if facing=LEFT {xVel=(dashVel+1)}
}
if claireBackDashRec>0 //For Claire only
{
  claireBackDashRec-=1*gDeltaTime
}

if airDashRecovery>0 //Continue air dash
{
  airDashRecovery-=1*gDeltaTime
  if global.activeCharacter=0 {yVel=-2.9}
  else if global.activeCharacter=1 {yVel=-3.3}
  if facing=RIGHT {xVel=(dashVel-1)}
  else if facing=LEFT {xVel=-(dashVel-1)}
}

if mobilityDisable>0 {mobilityDisable-=gDeltaTime} //Double jump / Air-dash disable after split party character swap
if dashMomentumTime>0 {dashMomentumTime-=gDeltaTime} //Dash momentum
if doubleJumpAnim>0 {doubleJumpAnim-=gDeltaTime} //Double jump animation

if jumpTime<jumpTimeTotal {jumpTime+=gDeltaTime}
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
  
  if kDown and platformCharacterIs(ON_GROUND) and isCollisionLadder()=0 and attackState!=ACT_IN_BIKE //Drop down platform
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
    else //Duck if solid below character
    {
      if state=STANDING {idleTime=0}
      state=DUCKING
      global.recTimeSpentDucking+=1*gDeltaTime
    }
  }
}

if kDown=0 and state=DUCKING and bTakingDamage=false //Go back to a standing position from ducking
{
  state=STANDING
  //xVel=0
  xAcc=0
  hopOnCount=0
  canAirDash=1
  doubleJumpCheck=1
  doubleJumpAnim=0
  idleTime=0
  if grappleState=0 {busterAnimStay=0}
  airDashDamage=0
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
  if slowFallEffect<1 {slowFallEffect+=0.008*gDeltaTime}
  slowFallTime-=1*gDeltaTime
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
  if state!=DUCKING and state!=LOOKING_UP and state!=CLIMBING and state!=FALLING
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
  flySpeedTimer-=1*gDeltaTime
  flySpeed=100
}
if flyJumpsTimer>0
{
  if flyJumpWasPressed=-1 {flyJumpWasPressed=0}
  else if kJumpPressed {flyJumpWasPressed=1}
  flySpeed=100
  flyJumpsTimer-=1*gDeltaTime
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
if state=CLIMBING or state=DUCKING
{
  flySpeed=0
  flySpeedTimer=0
  flyAccTimer=0
  flyAcc2Timer=0
}
//Causes the actual HUGE jump
if flyAccTimer>0
{
  flyAccTimer-=1*gDeltaTime
  yAcc-=1
}
if flyAcc2Timer>0
{
  flyAcc2Timer-=1*gDeltaTime
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
  xVel+=extForceX // FIXME: does this need delta time? figure it out
  if extForceX>0 {extForceX-=0.2*gDeltaTime}
  else if extForceX<0 {extForceX+=0.2*gDeltaTime}
  if abs(extForceX)<0.4 {extForceX=0}
}
if extForceY!=0
{
  yVel+=extForceY
  if extForceY>0 {extForceY-=0.2*gDeltaTime}
  else if extForceY<0 {extForceY+=0.2*gDeltaTime}
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
  if state=DUCKING
  {
    if attackState!=ACT_MORPHBALL and attackState!=ACT_ON_YOSHI
    {
      if xVel<2 and xVel>-2 {xFric=0.2}
      else {xFric=frictionDuckingX}
    }
    else {xFric=frictionRunningX}
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
        if global.activeCharacter=0 {xFric=0.965}
        else {xFric=0.96}
      }
      else {xFric=frictionAirX}
    }
    else //On ground
    {
      if global.activeCharacter=0
      {
        if dashMomentumTime>19 {xFric=0.965}
        else
        {
          if groundDashRecovery>0 or backDashRecovery>0 {xFric=0.9}
          else {xFric=frictionRunningX}
        }
      }
      else
      {
        if dashMomentumTime>20 {xFric=0.96}
        else {xFric=frictionRunningX}
      }
    }
    
    if attackState=ACT_IN_CANNON //{xFric=0.82}
    {
      xFric=1
      gravityIntensity=0
    }
    else if attackState=ACT_IN_BIKE {xFric=0.65}
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
        if state=DUCKING {xFric=frictionWaterXDuck}
        else {xFric=frictionWaterXRun}
        
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
      
      if state=DUCKING {xFric=frictionWaterXDuck}
      else {xFric=frictionWaterXRun}
      
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

if grappleState=0 or grappleState=1 //Slow falling speed if facing wall when touching it
{
  if bCanWallJump=1 and attackState!=ACT_MORPHBALL and attackState!=ACT_IN_BIKE //Wall slide
  {
    wallGrabEffect-=1*gDeltaTime
    if (isCollisionLeft(3) and facing=LEFT) or (isCollisionRight(3) and facing=RIGHT) and platformCharacterIs(IN_AIR)
    {
      bWallGrab=1
      yVelLimit=4
      if (wallGrabEffect<=0 and yVel>0) or (wallGrabEffect<=0 and sprite_index=sJerryBusterHang)
      {
        var facDir,tEffect;
        if facing=RIGHT {facDir=10}
        else if facing=LEFT {facDir=-10}
        tEffect=instance_create(oPlayer1.x+facDir,oPlayer1.y,oEffect)
        tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.35
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        wallGrabEffect=2
      }
    }
    else
    {
      bWallGrab=0
      yVelLimit=12
    }
  }
  
  if (gDeltaTime==1)
    pMoveToWrapOrig()
  else
    pMoveToWrapNew()
  
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
}
else if grappleState=2 //Player is being pulled toward grapple point
{
  if instance_exists(grappleID)
  {
    if oMMXstrikeChain.extend>12 {oMMXstrikeChain.extend-=12}
    var tGrpDist,tGrpDir,tGrpX;
    tGrpX=7*image_xscale
    tGrpDir=point_direction(x+tGrpX,0,grappleID.x,0)
    x+=12*cos(degtorad(tGrpDir))*gDeltaTime
    
    tGrpDist=point_distance(x+tGrpX,0,grappleID.x,0)
    if tGrpDist<=7
    {
      with oMMXstrikeChain {instance_destroy()}
      grappleID.retractTime=11
      x=grappleID.x
      y=grappleID.y+40
      canAirDash=1
      doubleJumpCheck=1
      grappleState=3
    }
  }
  else
  {
    state=FALLING
    grappleState=0
  }
}
else if grappleState=3
{
  oPlayer1.extForceX=0
  xVel=0
  if instance_exists(grappleID)
  {
    x=grappleID.x
    y=grappleID.y+40
  }
  else
  {
    state=FALLING
    grappleState=0
  }
}

//The character is no longer taking damage (in recovery state) when they hit the ground
if bTakingDamage=true and (state=STANDING or state=RUNNING or state=DUCKING or state=LOOKING_UP) and damageTime<26
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

//--------------------------------------------------------------------------------
if attackState!=ACT_MORPHBALL and attackState!=ACT_IN_BIKE and attackState!=ACT_ON_YOSHI and grappleState=0 and bTakingDamage=false
{
  //---------- Swap characters ---------- (Left trigger - Normally)
  if global.optSwapType>=0 and global.optSwapType<=2 //Standard or Dedicated
  {
    if kCharSwapPressed=1 and bTakingDamage=false
    {
      if global.optSwapType=0 //Standard
      {
        if charSwapRecover=0 and global.canCharSwap=2 {pSwapCharacter()}
      }
      else if global.optSwapType>=1 and global.optSwapType<=2 //Dedicated
      {
        //Jerry only
        if global.activeCharacter=0 {pSwapAbility()}
        else
        {
          if charSwapRecover=0 and global.canCharSwap=2
          {
            if global.optSwapType=2 and global.activeCharacter=1 //Swap to Link on character switch
            {
              if global.hasAbilToken[1]>=2
              {
                global.activeAbility[0]=1; scrSwapEffect()
              }
            }
            pSwapCharacter()
          }
        }
      }
    }
    //-------------------- Swap abilities -------------------- (Right trigger - Normally)
    if kAbilSwapPressed=1 and bTakingDamage=false
    {
      if global.optSwapType=0 //Standard
      {
        pSwapAbility()
      }
      else if global.optSwapType>=1 and global.optSwapType<=2 //Dedicated
      {
        //Claire only
        if global.activeCharacter=1 {pSwapAbility()}
        else
        {
          if charSwapRecover=0 and global.canCharSwap=2
          {
            if global.optSwapType=2 and global.activeCharacter=0 //Swap to Belmont on character switch
            {
              if global.hasAbilToken[2]>=2
              {
                global.activeAbility[1]=1; scrSwapEffect()
              }
            }
            pSwapCharacter()
          }
        }
      }
    }
  }
  else if global.optSwapType=3 //---------- Hold ----------
  {
    if kAbilSwap and bTakingDamage=false
    {
      if kUp //Link
      {
        if (global.activeCharacter=0) or (global.activeCharacter=1 and charSwapRecover=0 and global.canCharSwap=2)
        {
          if global.hasAbilToken[1]>=2
          {
            if global.activeCharacter=1 {pSwapCharacter()}
            global.activeAbility[0]=1; scrSwapEffect();
          }
        }
      }
      else if kDown //Belmont
      {
        if (global.activeCharacter=1) or (global.activeCharacter=0 and charSwapRecover=0 and global.canCharSwap=2)
        {
          if global.hasAbilToken[2]>=2
          {
            if global.activeCharacter=0 {pSwapCharacter()}
            global.activeAbility[1]=1; scrSwapEffect();
          }
        }
      }
      else if kLeft //Mega Man
      {
        if (global.activeCharacter=0) or (global.activeCharacter=1 and charSwapRecover=0 and global.canCharSwap=2)
        {
          if global.hasAbilToken[3]>=2
          {
            if global.activeCharacter=1 {pSwapCharacter()}
            global.activeAbility[0]=2; scrSwapEffect();
          }
        }
      }
      else if kRight //Samus
      {
        if (global.activeCharacter=1) or (global.activeCharacter=0 and charSwapRecover=0 and global.canCharSwap=2)
        {
          if global.hasAbilToken[4]>=2
          {
            if global.activeCharacter=0 {pSwapCharacter()}
            global.activeAbility[1]=2; scrSwapEffect();
          }
        }
      }
    }
    
    if kCharSwap and kCharSwapPressed=1 and bTakingDamage=false //Defender
    {
      if global.bTowerDefense>0
      {
        if global.activeCharacter=0 {global.activeAbility[0]=4; scrSwapEffect();}
        else {global.activeAbility[1]=4; scrSwapEffect();}
      }
      else
      {
        if global.canCharSwap=2 and charSwapRecover=0 {pSwapCharacter()}
      }
    }
  }
}
if charSwapRecover>0 {charSwapRecover-=1*gDeltaTime}

//---------- Ability use ----------
if attackState!=ACT_IN_BIKE and attackState!=ACT_ON_YOSHI and bTakingDamage=false {playerTechStart()}

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
  damageTime-=gDeltaTime
  if sprite_index!=sJerryDamaged or sprite_index!=sClaireDamaged
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
    attackState=0
  }
  else {castRecovering-=1*gDeltaTime}
}

//---------- Figure out what sprite index the character should be -----------
if global.activeCharacter=0 //-------------------- JERRY --------------------
{
  if attackState=0 and bTakingDamage=false
  {
    if state=STANDING {sprite_index=sJerryIdle}
    else if state=RUNNING {sprite_index=sJerryWalk}
    else if state=DUCKING {sprite_index=sJerryDuck}
    else if state=LOOKING_UP {sprite_index=sJerryLookUp}
    else if state=CLIMBING {sprite_index=sJerryIdle}
    else if state=JUMPING
    {
      if airDashRecovery=0
      {
        if facing=RIGHT
        {
          if xVel>10 {sprite_index=sJerryJumpForward}
          else if xVel<-7.5 or walljumpTime>0 {sprite_index=sJerryJumpBack}
          else {sprite_index=sJerryJump}
        }
        else
        {
          if xVel>7.5 or walljumpTime>0 {sprite_index=sJerryJumpBack}
          else if xVel<-10 {sprite_index=sJerryJumpForward}
          else {sprite_index=sJerryJump}
        }
      }
      else {sprite_index=sJerryAirDash}
    }
    else if state=FALLING and statePrev=FALLING //and statePrevPrev=FALLING
    {
      if airDashRecovery=0
      {
        if bWallGrab=0 {sprite_index=sJerryJump}
        else
        {
          if global.activeAbility[0]=2 {sprite_index=sJerryBusterHang}
          else {sprite_index=sJerryHang}
        }
      }
      else {sprite_index=sJerryAirDash}
    }
    else if flySpeed>90 and jumps>0 and jumps<flyMaxJumps and platformCharacterIs(IN_AIR) {sprite_index=sJerryJumpForward}
    
    if doubleJumpAnim>0 and yVel<4 {sprite_index=sJerryJumpForward}
    if groundDashRecovery>0 {sprite_index=sJerryAirDash}
    else if backDashRecovery>0 {sprite_index=sJerryJumpBack}
  }
  //attack state animations override action states
  if grappleState=0
  {
    if busterAnimStay>0 {busterAnimStay-=1*gDeltaTime}
  }
  else if grappleState=1 or grappleState=2
  {
    if state=STANDING or state=LOOKING_UP {mmState=BUSTER_STAND}
    else if state=RUNNING {mmState=BUSTER_RUN}
    else if (state=JUMPING or state=FALLING) {mmState=BUSTER_JUMP}
  }
  
  if bTakingDamage=false
  {
    if attackState=ACT_ATK {sprite_index=sJerrySword}
    else if attackState=ACT_FIRE {sprite_index=sJerryFire1}
    else if attackState=ACT_FIRE_UP {sprite_index=sJerryFire2}
    else if attackState=ACT_FIRE_DOWN {sprite_index=sJerryFire3}
    else if attackState=ACT_IN_CANNON {sprite_index=sJerryJumpForward}
    else if attackState=ACT_IN_BIKE {sprite_index=sJerryBike}
    else if attackState=ACT_BIRD_CALL {sprite_index=sJerryCasting}
    else if attackState=ACT_BLOCK {sprite_index=sJerryGuard}
    else if attackState=ACT_ON_YOSHI
    {
      if state=STANDING or state=LOOKING_UP or state=DUCKING {sprite_index=sJerryOnYoshiIdle}
      else if state=JUMPING or state=FALLING {sprite_index=sJerryOnYoshiJump}
      else {sprite_index=sJerryOnYoshiRun}
    }
    if busterAnimStay>0
    {
      if mmState=BUSTER_STAND {sprite_index=sJerryBusterStand}
      else if mmState=BUSTER_RUN {sprite_index=sJerryBusterRun}
      else if mmState=BUSTER_JUMP {sprite_index=sJerryBusterJump}
      else if mmState=BUSTER_DUCK {sprite_index=sJerryBusterDuck}
      if bWallGrab=1 {sprite_index=sJerryBusterHang}
      if grappleState=3 {sprite_index=sJerryBusterGrapple}
    }
  }
  else
  {
    if attackState!=ACT_IN_BIKE {sprite_index=sJerryDamaged}
    else {sprite_index=sJerryBike}
  }
}
else if global.activeCharacter=1 //-------------------- CLAIRE --------------------
{
  if attackState=0 and bTakingDamage=false
  {
    if state=STANDING {sprite_index=sClaireIdle}
    else if state=RUNNING {sprite_index=sClaireWalk}
    else if state=DUCKING {sprite_index=sClaireDuck}
    else if state=LOOKING_UP {sprite_index=sClaireLookUp}
    else if state=CLIMBING {sprite_index=sClaireIdle}
    else if state=JUMPING
    {
      if airDashRecovery=0
      {
        if facing=RIGHT
        {
          if xVel>10 {sprite_index=sClaireJumpForward}
          else if xVel<-7.5 or walljumpTime>0 {sprite_index=sClaireJumpBack}
          else {sprite_index=sClaireJump}
        }
        else
        {
          if xVel>7.5 or walljumpTime>0 {sprite_index=sClaireJumpBack}
          else if xVel<-10 {sprite_index=sClaireJumpForward}
          else {sprite_index=sClaireJump}
        }
      }
      else {sprite_index=sClaireAirDash}
    }
    else if state=FALLING and statePrev=FALLING //and statePrevPrev=FALLING
    {
      if airDashRecovery=0
      {
        if bWallGrab=0 {sprite_index=sClaireJump}
        else {sprite_index=sClaireWallGrab}
      }
      else {sprite_index=sClaireAirDash}
    }
    else if flySpeed>90 and jumps>0 and jumps<flyMaxJumps and platformCharacterIs(IN_AIR) {sprite_index=sClaireJumpForward}
    
    if doubleJumpAnim>0 and yVel<4 {sprite_index=sClaireAirRoll}
  }
  if busterAnimStay>0 {busterAnimStay-=1*gDeltaTime}
  //attack state animations override action states
  if bTakingDamage=false
  {
    if attackState=ACT_ATK
    {
      if global.activeAbility[1]=1 {sprite_index=sClaireHairWhip}
      else if global.activeAbility[1]=3 {sprite_index=sClaireBladeStrike}
    }
    else if attackState=ACT_FIRE {sprite_index=sClaireThrow}
    else if attackState=ACT_IN_CANNON {sprite_index=sClaireAirRoll}
    else if attackState=ACT_HIDE {sprite_index=sClaireDuck}
    else if attackState=ACT_BLOCK {sprite_index=sClaireGuard}
    if busterAnimStay>0
    {
      if mmState=BUSTER_STAND {sprite_index=sClaireCannonStandA}
      else if mmState=BUSTER_STAND_UP {sprite_index=sClaireCannonStandB}
      else if mmState=BUSTER_RUN {sprite_index=sClaireCannonRunA}
      else if mmState=BUSTER_RUN_UP {sprite_index=sClaireCannonRunB}
      else if mmState=BUSTER_JUMP {sprite_index=sClaireCannonJumpA}
      else if mmState=BUSTER_JUMP_UP {sprite_index=sClaireCannonJumpB}
      else if mmState=BUSTER_JUMP_DOWN {sprite_index=sClaireCannonJumpC}
      else if mmState=BUSTER_DUCK {sprite_index=sClaireCannonDuck}
    }
    if attackState=ACT_MORPHBALL {sprite_index=sClaireMorphBall}
  }
  else
  {
    if attackState=ACT_MORPHBALL {sprite_index=sClaireMorphBall}
    else {sprite_index=sClaireDamaged}
  }
}
else if global.activeCharacter=2 //-------------------- JEREMY - MECH --------------------
{
  if xVel>0 or xVel<0 and sprite_index=sJeremyMechWalk //Footstep sound
  {
    if image_index>=4 and image_index<=4.99
    {
      if footStepSound=0
      {
        if global.location=110 {playSound(global.snd_MechStepA,0,0.88,14000)}
        else {playSound(global.snd_MechStepA,0,0.95,1)}
        footStepSound=1
      }
    }
    else if image_index>=0 and image_index<=0.99
    {
      if footStepSound=1
      {
        if global.location=110 {playSound(global.snd_MechStepA,0,0.88,14000)}
        else {playSound(global.snd_MechStepA,0,0.95,1)}
        footStepSound=0
      }
    }
  }
  else {footStepSound=0}
  
  if attackState=0 and bTakingDamage=false
  {
    if state=STANDING or state=LOOKING_UP or state=DUCKING or state=CLIMBING
    {
      if mechFireRate>0 {sprite_index=sJeremyMechWalk; image_index=0}
      else {sprite_index=sJeremyMechIdle}
    }
    else if state=RUNNING {sprite_index=sJeremyMechWalk}
    else if state=JUMPING or state=FALLING and statePrev=FALLING {sprite_index=sJeremyMechJump}
    
    if state=JUMPING or bUseFuel=1
    {
      var tEffect,tRanScl,tFuelCol;
      tFuelCol=c_white
      tRanScl=random(0.25)
      if bUseFuel=1 {tFuelCol=c_orange; tRanScl+=0.1}
      tEffect=instance_create(x-(16*image_xscale),y-31,oEffect)
      tEffect.sprite_index=sMMSmokeCloud; tEffect.image_xscale=0.5+tRanScl; tEffect.image_yscale=0.5+tRanScl; tEffect.image_alpha=0.5+random(0.25)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=random_range(-0.5,0.5); tEffect.ySpd=3+random(2)
      tEffect.image_blend=tFuelCol
    }
  }
}

//calculates the image_speed based on the character's velocity and/or state
if state=RUNNING
  image_speed=abs(xVel)*runAnimSpeed+0.1
else if state=CLIMBING
  image_speed=sqrt(sqr(abs(xVel))+sqr(abs(yVel)))*climbAnimSpeed
else if state=STANDING or state=DUCKING or state=LOOKING_UP
  image_speed=idleAnimSpeed

if attackState!=0
  image_speed=0.5
else if attackState=ACT_FIRE or attackState=ACT_FIRE_UP or attackState=ACT_FIRE_DOWN
  image_speed=1

if atkAnimSpd!=-1 //Do not use attack anim speed unless needed
  image_speed=atkAnimSpd

if sprite_index=sJerryDamaged or sprite_index=sClaireDamaged //Damage state anim speed
  image_speed=0.75
else if sprite_index=sJerryJumpForward or sprite_index=sClaireJumpForward or sprite_index=sClaireAirRoll //Air roll anim speed
  image_speed=0.4

if attackState=ACT_IN_BIKE //Dirt effect on the ground when on bike
{
  if platformCharacterIs(ON_GROUND)
  {
    var tBikeEffect;
    tBikeEffect=instance_create(x-16-random(6),y-3+random(4),oEffect)
    tBikeEffect.sprite_index=sMMSmokeCloud; tBikeEffect.image_blend=make_color_rgb(248,240,144)
    tBikeEffect.image_alpha=0.75; tBikeEffect.xSpd=-2-random(2); tBikeEffect.ySpd=-2-random(2)
    tBikeEffect.newBlend=-1; tBikeEffect.followID=-1; tBikeEffect.decay=-100
  }
  bikeAnimFrm+=0.4*gDeltaTime
  image_speed=0
}

//figures out which direction the sprite should be facing
if facing=LEFT {image_xscale=-1}
else if facing=RIGHT {image_xscale=1}

//sets the previous state and the previously previous state
statePrevPrev=statePrev
statePrev=state
attackStatePrevPrev=attackStatePrev
attackStatePrev=attackState

//image_speed *= gDeltaTime

//limit the image_speed to 1 so the animation always looks good
if image_speed>1 {image_speed=1}
