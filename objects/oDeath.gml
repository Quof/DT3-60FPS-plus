#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-21,-40,21,-1)
image_speed=0
image_xscale=-1
bCanTakeDamage=false

//Enemy base statistics
eName="Death"
eLevel=12
maxLife=6400
life=maxLife
atkPower=5
resType[4]=2
stunResist=50
affiliation=3
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0

//-- Movement Data --
moveSpd=0.5
jumpTime=0
jumpDelay=330

//-- Single Swing Data --
currentAtkSet=0
atkProg=0
atkTime=20
atkDelay=40
atkSwingScale=1 //attack speed scale
spinSizeScale=1
forwardSizeScale=1
upwardSizeScale=1
atkSwingType=-1 //which swing to use
atkSwingTime=0 //swing progress
atkSwingNum=0 //swing num
bSwing=0 //if swing in progress
for(i=0;i<3;i+=1) {atkTypeSw[i]=0}

//-- Flying Scythe Data --
flyScyTime=0
flyScyDelay=180
scythePos=96
scytheSpacing=69

specFSaTime=0
specFSaDelay=680
specFSaProg=0
specSpawnProg=0
specSpawnSeq=0
scyPX=0;scyPY=0

//-- Defense Data --
hitKnife=0
hitWater=0
shielding=0

//-- Super Attack Data --
superProg=0
superTime=0
superScyNum=0 //Attack progress
superScyDist=78 //Circle spawn radius
superScyDir=0
superScySpd=6 //Scythe fly speed
superScySpac=45 //Degrees to offset the next scythe spawn
superScyTime=11 //Scythe spawn frequency

//-- Misc Data --
xCenter=304
yGround=304
roomSpan=304

distMax=0
chkMove=0

deathAnim=0
blendCol=255

jeremyText="Death has decided to duel you toe to toe. I don't recommend backing off from Death as he'll use near-screen filling attacks. Projectiles don't seem to work well either as he'll just build a defense against them. He doesn't have too many flashy attacks, just a scythe summoning thing, which can get bothersome when you're trying to dodge his scythe. The main thing here is to focus on what he's doing. Don't take your eyes off him."
chaoText="I'm sensing that Death has a few other tricks up his sleeves that Jeremy isn't picking up. In comparison to all of his incarnations, Death fights the closest to his Rondo of Blood version, but this is still much different than any Death fight."
devText="I've always enjoyed toe to toe duels, and that's exactly what Death was designed to be. Everything in the fight is meant to keep you close to him. Seeing how Death is also my favorite Castlevania encounter and that it would be the last fight in the Gate, I wanted something special. He needed to be very menacing and scary as well. I feel like I was able to pull that off and definitely make him memorable."
extraInfo="A pain in the ass."

myHS=instance_create(x,y,oDeathHitSpot)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if activateBoss=1
  {
    oGlobalEvent.enemyCount=1
    bActive=true
    myHS.bActive=true
    myHS.bShowHealthBar=true
    myHS.showBossHP=instance_create(0,0,oBossLifeDisplay)
    myHS.showBossHP.bossID=myHS.id
    myHS.showBossHP.type=0
    activateBoss=2
  }

  if bActive=true and myHS.life>0
  {
    if superProg<=1
    {
      chkMove=point_distance(x,0,oPlayer1.x,0)
      if bossProgress=0 {distMax=68}
      else if bossProgress=1 {distMax=88}
      else if bossProgress=2 {distMax=114}
      else if bossProgress=3 {distMax=138}
      else if bossProgress=4 {distMax=164}
      //---------- MOVEMENT ----------
      if sprite_index=sDeathWalk
      {
        if x>oPlayer1.x {image_xscale=-1}
        else {image_xscale=1}

        if chkMove<distMax-(distMax/6)
        {
          if image_xscale=1 {xVel=-moveSpd}
          else {xVel=moveSpd}
        }
        else if chkMove>distMax-(distMax/6) and chkMove<distMax {xVel=0}
        else if chkMove>distMax
        {
          if image_xscale=1 {xVel=moveSpd}
          else {xVel=-moveSpd}
        }
      }
      else
      {
        if sprite_index!=sDeathJump and sprite_index!=sDeathRoll
          xVel=0
      }

      //Jumping
      jumpTime+=1
      if chkMove>208 {jumpTime+=1}
      if jumpTime>=jumpDelay
      {
        if jumpTime<=jumpDelay+100
        {
          if specFSaTime<specFSaDelay and atkTime<atkDelay and shielding=0 //Update check/Jump Back
          {
            sprite_index=sDeathJump
            y-=4
            yVel=-7
            if image_xscale=1
            {
              if chkMove>208 {xVel=4}
              else {xVel=-3}
            }
            else
            {
              if chkMove>208 {xVel=-4}
              else {xVel=3}
            }
            jumpTime=10000
          }
          else {jumpTime=jumpDelay-5}
        }

        if jumpTime>=10001 and jumpTime<=10999 //Dive roll
        {
          if yVel>=-2
          {
            sprite_index=sDeathRoll
            var tDistSpin;
            tDistSpin=chkMove/16
            if tDistSpin>13 {tDistSpin=13}

            if x>oPlayer1.x {xVel=-tDistSpin;image_xscale=-1}
            else {xVel=tDistSpin;image_xscale=1}
            yVel=4
            jumpTime=11000
          }
        }
        if jumpTime>=11001 //Spin
        {
          if oGame.time mod 5=0 {playSound(global.snd_DeathSlash,0,0.95,38000)}
          if xVel>0 {image_angle-=30}
          else {image_angle+=30}
        }
      }

      //---------- PENTAGRAM SHIELD ----------
      if shielding=0 and sprite_index=sDeathWalk //Check updates
      {
        if instance_exists(oBelmontDagger)
        {
          var tPAtkDist;
          tPAtkDist=point_distance(x,0,oBelmontDagger.x,0)
          if tPAtkDist<80 and oBelmontDagger.y>yGround-48
          {
            if atkTime>atkDelay
            {
              atkSwingNum=0
              atkTime=atkDelay-5
              atkSwingTime=0
              atkSwingType=-1
              bSwing=0
            }
            shielding=1
            sprite_index=sDeathBlock
            var newShield;
            newShield=instance_create(x+(24*image_xscale),y-24,oDeathPentagramShield)
            newShield.image_xscale=image_xscale
          }
        }
      }
      else if shielding=1 //Check shield status
      {
        if instance_exists(oBelmontDagger)
        {
          var tPAtkDist;
          tPAtkDist=point_distance(x,0,oBelmontDagger.x,0)
          if tPAtkDist>64 {shielding=2}
        }
        else {shielding=2}
      }
      else if shielding>=2
      {
        shielding+=1
        if shielding>=30
        {
          sprite_index=sDeathWalk
          oDeathPentagramShield.atkProg=10
          shielding=0
        }
      }

      if instance_exists(oDeathPentagramShield)
      {
        resType[0]=1
        oDeathHitSpot.resType[0]=1
      }
      else
      {
        resType[0]=3
        oDeathHitSpot.resType[0]=3
      }

      //---------- ATTACK: COMBO SWING ----------
      if atkProg=0 //3 Strike Combo
      {
        atkTime+=1
        if atkTime>=atkDelay
        {
          if atkTime<=atkDelay+100 //Check updates
          {
            if sprite_index=sDeathWalk
            {
              if chkMove<distMax*1.5
              {
                atkTime=10000
                atkSwingType=1
                currentAtkSet+=1
                if currentAtkSet=1 {atkTypeSw[0]=0; atkTypeSw[1]=1; atkTypeSw[2]=2}
                else if currentAtkSet=2 {atkTypeSw[0]=1; atkTypeSw[1]=2; atkTypeSw[2]=0}
                else if currentAtkSet=3 {atkTypeSw[0]=2; atkTypeSw[1]=0; atkTypeSw[2]=1}
                else if currentAtkSet=4 {atkTypeSw[0]=1; atkTypeSw[1]=1; atkTypeSw[2]=2}
                else if currentAtkSet=5 {atkTypeSw[0]=0; atkTypeSw[1]=0; atkTypeSw[2]=1}
                else if currentAtkSet=6 {atkTypeSw[0]=2; atkTypeSw[1]=1; atkTypeSw[2]=0; currentAtkSet=0}
              }
              else if chkMove>distMax*2.5
              {
                atkTime=10000
                atkSwingType=1
                atkSwingNum=1
                currentAtkSet+=1
                if currentAtkSet=1 {atkTypeSw[0]=1; atkTypeSw[1]=0; atkTypeSw[2]=2}
                else if currentAtkSet=2 {atkTypeSw[0]=0; atkTypeSw[1]=1; atkTypeSw[2]=2}
                else if currentAtkSet=3 {atkTypeSw[0]=1; atkTypeSw[1]=0; atkTypeSw[2]=2}
                else if currentAtkSet=4 {atkTypeSw[0]=0; atkTypeSw[1]=1; atkTypeSw[2]=2}
                else if currentAtkSet=5 {atkTypeSw[0]=1; atkTypeSw[1]=0; atkTypeSw[2]=2}
                else if currentAtkSet=6 {atkTypeSw[0]=0; atkTypeSw[1]=1; atkTypeSw[2]=2; currentAtkSet=0}
              }
              else {atkTime=atkDelay-5}
            }
            else {atkTime=atkDelay-5}
          }

          if atkTime>=10001 and atkTime<=10100 //Swing
          {
            event_user(atkTypeSw[atkSwingNum])
            if atkSwingType=-1
            {
              atkSwingNum+=1
              if atkSwingNum=3
              {
                atkSwingNum=0
                atkTime=0
              }
              else
              {
                atkSwingType=1
                atkTime=10000
              }
            }
          }
        }
      }

      //---------- ATTACK: FLYING SCYTHE ----------
      flyScyTime+=1
      if flyScyTime>=flyScyDelay
      {
        var tAtkScythe,tScyY;
        tScyY=96+(bossProgress*12)
        tAtkScythe=instance_create(scythePos,tScyY,oDeathFlyingScythe)
        tAtkScythe.atkPower=atkPower
        tAtkScythe.bulletSpeed=2.5
        tAtkScythe.direction=point_direction(scythePos,tScyY,oPlayer1.x,returnPlayerYCenter())
        scythePos+=scytheSpacing
        if scythePos=96+(scytheSpacing*7) {scythePos=96}
        flyScyTime=0
      }

      //---------- ATTACK: SPECIAL SCYTHE SPAWN ----------
      specFSaTime+=1
      if specFSaTime>=specFSaDelay
      {
        if specFSaTime<=specFSaDelay+100 //Check updates
        {
          if atkTime<atkDelay and jumpTime<jumpDelay and shielding=0
          {
            playSound(global.snd_FadeAway,0,0.96,17000)
            sprite_index=sDeathDuck
            specFSaTime=10000
          }
          else {specFSaTime=specFSaDelay-5}
        }
        else if specFSaTime>=10001 and specFSaTime<=10024
        {
          for(i=0;i<8;i+=1)
          {
            tEffect=instance_create(x-20+random(40),y-random(3),oEffectB)
            tEffect.type=3; tEffect.sprite_index=sMMchargeEffect1; tEffect.image_alpha=0.8
            tEffect.direction=90; tEffect.image_angle=90; tEffect.friction=0.05
            tEffect.speed=1+random(2); tEffect.fadeSpd=0.02
            tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
          }
        }
        else if specFSaTime=10025 //End attack
        {
          sprite_index=sDeathWalk
          specFSaTime=0
          specSpawnProg=1
        }
      }
      if specSpawnProg>=1 //Spawn special attack scythes
      {
        specSpawnProg+=1
        if specSpawnProg=2
        {
          if random(10)>6
          {
            var newMessage;
            newMessage=instance_create(x-46,y-114,oEnemyChat)
            newMessage.enemyMessage="Perfect night for a curse."
          }
          specSpawnProg=1000+(specFSaProg*1000)
          specFSaProg+=1
          if specFSaProg=1 //Life
          {
            scyPX=70; scyPY=64
          }
          else if specFSaProg=2 //Right
          {
            scyPX=576; scyPY=64
          }
          else if specFSaProg=3 //Top
          {
            scyPX=96; scyPY=0
            specFSaProg=0
          }
        }
        else if specSpawnProg>=1000 and specSpawnProg<=1999 //Left side
        {
          if specSpawnProg mod 4=0
          {
            var tAtkScythe;
            tAtkScythe=instance_create(scyPX,scyPY,oDeathFlyingScythe)
            tAtkScythe.atkPower=atkPower
            tAtkScythe.bulletSpeed=2.5
            tAtkScythe.direction=point_direction(scyPX,scyPY,oPlayer1.x,returnPlayerYCenter())
            scyPY+=48
            specSpawnSeq+=1
          }
          if specSpawnSeq=6 {specSpawnProg=10000}
        }
        else if specSpawnProg>=2000 and specSpawnProg<=2999 //Right side
        {
          if specSpawnProg mod 4=0
          {
            var tAtkScythe;
            tAtkScythe=instance_create(scyPX,scyPY,oDeathFlyingScythe)
            tAtkScythe.atkPower=atkPower
            tAtkScythe.bulletSpeed=2.5
            tAtkScythe.direction=point_direction(scyPX,scyPY,oPlayer1.x,returnPlayerYCenter())
            scyPY+=48
            specSpawnSeq+=1
          }
          if specSpawnSeq=6 {specSpawnProg=10000}
        }
        else if specSpawnProg>=3000 and specSpawnProg<=3999 //Top side
        {
          if specSpawnProg mod 4=0
          {
            var tAtkScythe;
            tAtkScythe=instance_create(scyPX,100,oDeathFlyingScythe)
            tAtkScythe.atkPower=atkPower; tAtkScythe.bulletSpeed=2.5
            tAtkScythe.direction=point_direction(scyPX,100,oPlayer1.x,returnPlayerYCenter())
            scyPX+=scytheSpacing
            specSpawnSeq+=1
          }
          if specSpawnSeq=6 {specSpawnProg=10000}
        }

        if specSpawnProg>=10000 //End attack
        {
          specSpawnSeq=0
          specSpawnProg=0
        }
      }
    }

    //---------- SUPER ATTACK: DEATH'S WRATH ----------
    if superProg=1 //Check updates
    {
      if sprite_index=sDeathWalk and specFSaTime<specFSaDelay and jumpTime<jumpDelay and atkTime<atkDelay and shielding=0
      {
        xVel=0;yVel=0
        sprite_index=sDeathJump
        superProg+=1
      }
    }
    else if superProg=2 //Fly up
    {
      y-=8
      if y<=-8
      {
        x=304; y=-8
        sprite_index=sDeathStandBack
        myHS.bCanTakeDamage=false
        bCanDealDamage=false
        if specFSaTime>=specFSaDelay {specFSaTime=specFSaDelay-90}
        superProg+=1
      }
    }
    else if superProg=3 //Wait and fly down
    {
      superTime+=1
      if superTime>=15
      {
        y+=4
        if y>=224 {superTime=0; superProg+=1}
      }
    }
    else if superProg=4
    {
      superTime+=1
      if superTime mod superScyTime=0 and superTime>=1
      {
        playSound(global.snd_OrbThrow,0,0.95,40000)
        var tAtkScythe;
        tAtkScythe=instance_create(x,y,oDeathFlyingScythe)
        tAtkScythe.x=x+lengthdir_x(superScyDist,superScyDir); tAtkScythe.y=y+lengthdir_y(superScyDist,superScyDir)
        tAtkScythe.atkPower=atkPower; tAtkScythe.bulletSpeed=superScySpd
        tAtkScythe.direction=point_direction(x+lengthdir_x(superScyDist,superScyDir),y+lengthdir_y(superScyDist,superScyDir),oPlayer1.x,oPlayer1.y-26)
        superScyDir+=superScySpac
      }
      
      if superScyNum=0 //First Circle
      {
        if superScyDir>=360
        {
          superTime=-30
          superScyTime=10
          superScySpd=8
          superScySpac=22
          superScyDir=0
          superScyNum+=1
        }
      }
      else if superScyNum=1 //Fast Scythe Circle
      {
        if superScyDir>=540
        {
          superTime=-45
          superScyTime=1
          superScyDist=120
          superScySpd=4
          superScySpac=14
          superScyDir=0
          superScyNum+=1
        }
      }
      else if superScyNum=2 //Fast Spawn Circle
      {
        if superScyDir>=360
        {
          superTime=-15
          superScyDir=0
          superScyNum+=1
        }
      }
      else if superScyNum=3 //End
      {
        if superScyDir>=360 {superProg+=1}
      }
    }
    else if superProg=5 //End super attack
    {
      y-=8
      if y<=-64
      {
        sprite_index=sDeathRoll
        myHS.bCanTakeDamage=true
        bCanDealDamage=true
        yVel=1
        jumpTime=11000
        superProg=0
      }
    }
    
    if superProg<=1
      yVel+=0.2
    
    if isCollisionBottom(1)
    {
      if jumpTime>=11000
      {
        jumpTime=0
        xVel=0
        if atkTime<10000 {sprite_index=sDeathWalk}
        image_angle=0
      }
      yVel=0
    }
    if isCollisionLeft(1)
    {
      x+=2
      xVel*=-1
    }
    if isCollisionRight(1)
    {
      x-=2
      xVel*=-1
    }
    if isCollisionSolid()
      y-=2
    moveTo(xVel,yVel)
    
    //---------- Boss Difficulty Curve ----------
    if myHS.lifePercent<=0.89 and myHS.lifePercent>=0.78 and bossProgress=0
    {
      jumpDelay-=4
      atkDelay-=1
      atkSwingScale+=0.1
      spinSizeScale+=0.125
      forwardSizeScale+=0.2
      upwardSizeScale+=0.125
      flyScyDelay-=5
      specFSaDelay-=15
      bossProgress+=1
    }
    else if myHS.lifePercent<=0.77 and myHS.lifePercent>=0.66 and bossProgress=1
    {
      moveSpd+=0.25
      jumpDelay-=4
      atkDelay-=2
      atkSwingScale+=0.1
      spinSizeScale+=0.125
      forwardSizeScale+=0.2
      upwardSizeScale+=0.125
      flyScyDelay-=5
      specFSaDelay-=15
      bossProgress+=1
    }
    else if myHS.lifePercent<=0.65 and myHS.lifePercent>=0.60 and bossProgress=2
    {
      superProg=1
      bossProgress+=1
    }
    else if myHS.lifePercent<=0.59 and myHS.lifePercent>=0.41 and bossProgress=3
    {
      jumpDelay-=4
      atkDelay-=1
      atkSwingScale+=0.1
      spinSizeScale+=0.125
      forwardSizeScale+=0.2
      upwardSizeScale+=0.125
      flyScyDelay-=5
      specFSaDelay-=15
      bossProgress+=1
    }
    else if myHS.lifePercent<=0.4 and myHS.lifePercent>=0 and bossProgress=4
    {
      moveSpd+=0.25
      jumpDelay-=4
      atkDelay-=1
      spinSizeScale+=0.125
      forwardSizeScale+=0.2
      upwardSizeScale+=0.125
      flyScyDelay-=10
      specFSaDelay-=15
      bossProgress+=1
    }
  }
  else if myHS.life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      depth=26
      image_angle=0
      with oEProjectileBase {instance_destroy()}
      with oDeathPentagramShield {instance_destroy()}
      sprite_index=sDeathWalk; image_speed=0
      bCanDealDamage=false
    }
    else if deathAnim>=2 and deathAnim<=55
    {
      if oGame.time mod 2=0
      {
        var tEffect;
        tEffect=instance_create((x-sprite_width/2)+random(sprite_width),(y-sprite_height)+random(sprite_height),oEffect)
        tEffect.sprite_index=sSamusSMissileHit
        tEffect.image_speed=0.5; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim=56
    {
      if global.bBossGallery=1
      {
        bossRoomTally(13)
        global.newMapX=2712; global.newMapY=1312; room_goto(rBossGallery)
      }
    }
    else if deathAnim>=57 and deathAnim<=999
    {
      if x<xCenter {x+=2}
      else {x-=2}
      
      if y-22<yGround-128 {y+=2}
      else {y-=2}
      
      if blendCol>0 {blendCol-=3}
      myHS.image_blend=make_color_rgb(blendCol,blendCol,blendCol)
      
      if point_distance(x,y-22,xCenter,yGround-128)<3 and blendCol=0 {deathAnim=1000}
    }
    else if deathAnim=1020
    {
      newMessage=instance_create(32,48,oMessagePerson)
      newMessage.message="The night is young!#Let us dance!"
      newMessage.talker="Death"; newMessage.wColor=8; newMessage.wSize=1; newMessage.fadingTime=70
    }
    else if deathAnim=1060
    {
      boss=instance_create(304,176,oLegion)
      boss.image_xscale=0.1
      boss.image_yscale=0.1
      boss.image_blend=c_black
    }
    else if deathAnim>=1061 and deathAnim<=1299
    {
      if deathAnim=1061
      {
        var newMoveSol;
        for(i=0;i<3;i+=1)
        {
          newMoveSol=instance_create(128+(i*144),yGround,oMovingSolid)
          with newMoveSol
          {
            sprite_index=sInvisibleSolidMask
            visible=0
            image_xscale=4
            viscidTop=1
            makeActive()
          }
        }
      }
      else if deathAnim>=1062 and deathAnim<=1121
      {
        oMovingSolid.yVel=-1
        tile_layer_shift(999998,0,-1)
      }
      else if deathAnim=1122 {oMovingSolid.yVel=0}
      
      if boss.image_xscale<1.5
      {
        boss.image_xscale+=0.01
        boss.image_yscale+=0.01
      }
      
      if deathAnim>=1135
      {
        if blendCol<255 {blendCol+=3}
        else {deathAnim=1300}
        boss.image_blend=make_color_rgb(blendCol,blendCol,blendCol)
      }
    }
    else if deathAnim>=1310
    {
      storeStatus(0)
      boss.activateBoss=1
      global.bossTrack=2
      with myHS {instance_destroy()}
      instance_create(0,0,oCheckpointNotice)
      instance_destroy()
    }
  }
  
  if sprite_index=sDeathWalk
  {
    if xVel!=0 {image_index+=0.06+(moveSpd/25)}
  }
  enemyStepEvent()
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//-- ATTACK: SLASH A (SPIN) -- Intended for player to jump

atkSwingTime+=1*atkSwingScale
if atkSwingTime<=2
{
  sprite_index=sDeathReadyA
}
else if atkSwingTime>=24 and atkSwingTime<=26 and bSwing=0
{
  playSound(global.snd_DeathSlash,0,0.97,30000)
  sprite_index=sDeathSwingA
  var newAtk,tTooFar;
  tTooFar=1
  if chkMove>=192 and chkMove<=351 {tTooFar=1.25}
  else if chkMove>=352 {tTooFar=1.5}

  newAtk=instance_create(x,y-26,oDeathScytheAtk)
  newAtk.atkPower=atkPower; newAtk.decay=round(10/atkSwingScale); newAtk.atkSpd=0.25*atkSwingScale
  newAtk.image_xscale=(1.75*spinSizeScale)*tTooFar*image_xscale; newAtk.image_yscale=(1.75*spinSizeScale)*tTooFar

  newAtk=instance_create(x,y-26,oDeathScytheAtk)
  newAtk.atkPower=atkPower; newAtk.decay=round(10/atkSwingScale); newAtk.atkSpd=0.25*atkSwingScale
  newAtk.image_xscale=spinSizeScale*tTooFar*image_xscale; newAtk.image_yscale=spinSizeScale*tTooFar
  bSwing=1
}
else if atkSwingTime>=33
{
  sprite_index=sDeathWalk
  atkSwingTime=0
  atkSwingType=-1
  bSwing=0
}
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//-- ATTACK: SLASH B (LARGE ARC FORWARD) -- Intended for player to dash behind Death

atkSwingTime+=1*atkSwingScale
if atkSwingTime<=2
{
  sprite_index=sDeathReadyB
}
else if atkSwingTime>=30 and atkSwingTime<=32 and bSwing=0
{
  playSound(global.snd_DeathSlash,0,0.97,25000)
  sprite_index=sDeathSwingB
  image_index=1
  var newAtk,tTooFar;
  tTooFar=1
  if chkMove>=192 and chkMove<=351 {tTooFar=1.5}
  else if chkMove>=352 {tTooFar=2}

  newAtk=instance_create(x,y-24,oDeathScytheAtk)
  newAtk.sprite_index=sDeathScytheSlashB; newAtk.atkPower=atkPower
  newAtk.decay=round(10/atkSwingScale); newAtk.atkSpd=0.34*atkSwingScale
  newAtk.image_xscale=(3.1*forwardSizeScale)*tTooFar*image_xscale; newAtk.image_yscale=(1.5*forwardSizeScale)*tTooFar

  newAtk=instance_create(x,y-24,oDeathScytheAtk)
  newAtk.sprite_index=sDeathScytheSlashB; newAtk.atkPower=atkPower
  newAtk.decay=round(10/atkSwingScale); newAtk.atkSpd=0.34*atkSwingScale
  newAtk.image_xscale=(2.325*forwardSizeScale)*tTooFar*image_xscale; newAtk.image_yscale=(1.375*forwardSizeScale)*tTooFar

  newAtk=instance_create(x,y-24,oDeathScytheAtk)
  newAtk.sprite_index=sDeathScytheSlashB; newAtk.atkPower=atkPower
  newAtk.decay=round(10/atkSwingScale); newAtk.atkSpd=0.34*atkSwingScale
  newAtk.image_xscale=(1.55*forwardSizeScale)*tTooFar*image_xscale; newAtk.image_yscale=(1.25*forwardSizeScale)*tTooFar

  newAtk=instance_create(x,y-24,oDeathScytheAtk)
  newAtk.sprite_index=sDeathScytheSlashB; newAtk.atkPower=atkPower
  newAtk.decay=round(10/atkSwingScale); newAtk.atkSpd=0.34*atkSwingScale
  newAtk.image_xscale=forwardSizeScale*tTooFar*image_xscale; newAtk.image_yscale=forwardSizeScale*tTooFar
  bSwing=1
}
else if atkSwingTime>=39
{
  sprite_index=sDeathWalk
  atkSwingTime=0
  atkSwingType=-1
  bSwing=0
}
#define Other_12
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//-- ATTACK: SLASH C (LARGE ARC CURVED UP) -- Intended for player to duck

atkSwingTime+=1*atkSwingScale
if atkSwingTime<=2
{
  sprite_index=sDeathReadyC
}
else if atkSwingTime>=24 and atkSwingTime<=26 and bSwing=0
{
  playSound(global.snd_DeathSlash,0,0.97,35000)
  sprite_index=sDeathSwingB
  image_index=0
  var newAtk;
  newAtk=instance_create(x,y-26,oDeathScytheAtk)
  newAtk.sprite_index=sDeathScytheSlashC; newAtk.atkPower=atkPower
  newAtk.decay=round(10/atkSwingScale); newAtk.atkSpd=0.34*atkSwingScale
  newAtk.image_xscale=(2*upwardSizeScale)*image_xscale; newAtk.image_yscale=2*(upwardSizeScale/1.25)

  newAtk=instance_create(x,y-26,oDeathScytheAtk)
  newAtk.sprite_index=sDeathScytheSlashC; newAtk.atkPower=atkPower
  newAtk.decay=round(10/atkSwingScale); newAtk.atkSpd=0.34*atkSwingScale
  newAtk.image_xscale=upwardSizeScale*image_xscale; newAtk.image_yscale=upwardSizeScale/1.25

  //Straight up swing
  newAtk=instance_create(x,y-26,oDeathScytheAtk)
  newAtk.sprite_index=sDeathScytheSlashC; newAtk.atkPower=atkPower
  newAtk.decay=round(10/atkSwingScale); newAtk.atkSpd=0.34*atkSwingScale
  newAtk.image_xscale=(2*upwardSizeScale)*image_xscale; newAtk.image_yscale=2*(upwardSizeScale/1.25)
  if image_xscale=1 {newAtk.image_angle=45}
  else {newAtk.image_angle=315}
  bSwing=1
}
else if atkSwingTime>=33
{
  sprite_index=sDeathWalk
  atkSwingTime=0
  atkSwingType=-1
  bSwing=0
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,myHS.image_blend,image_alpha)
