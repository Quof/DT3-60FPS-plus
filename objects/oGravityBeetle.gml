#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-21,-45,21,-1)
image_speed=0

//Enemy base statistics
eName="Gravity Beetle"
eLevel=17
maxLife=3000
life=maxLife
atkPower=6
resType[0]=2
resType[1]=2
resType[2]=4
resType[5]=2
stunResist=50
affiliation=4
bIsBoss=true
bNoBonus=true
hitSound=global.snd_EnemyHitMM
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
actionState=0
atkProg=0
runAcc=8
bounceMax=5

specialAttack=0
specProg=0
notDashable=0

//Misc Data
xCenter=240
yGround=288
roomSpan=176

deathAnim=0
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
    bShowHealthBar=true
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=1; showBossHP.lifeFill=1000
    jeremyText="Don't try to go by how this guy used to play out, it won't help you out here that much. The bouncing gravity orbs are still roughly the same, and he still hops around sometimes, and he also still charges, and... okay yeah. He still does all these things he did before, but in a different way, but not in a different way. You'll see, it's weird."
    chaoText="Watch out for his charge attack, when you see him flashing, he can't be dashed through. I think it would be a good idea to remember this sort of thing for later as well. Oh! I found something interesting in his desperation attack data. When I looked through the algorithms, I found there's a slight exploit with it."
    devText="Chapter 8 took me just over 2 months to complete. This seemed like a large amount of time, more than I wanted, but when seeing that there were 7 seperate levels and having each one take roughly a week to make, it made sense. A week is about how much time I gave myself for each level in Gate 4."
    activateBoss=2
  }

  if bActive=true and life>0
  {
    if specialAttack!=2
    {
      if sprite_index!=sGBeetle_Jump and sprite_index!=sGBeetle_BeginThrow and sprite_index!=sGBeetle_Throw and sprite_index!=sGBeetle_Charge
      {
        if x<oPlayer1.x
          image_xscale=1
        else
          image_xscale=-1
      }

      atkProg+=1
      if actionState=0 //----- Throw orb left or right -----
      {
        if atkProg=1 //Check for special
        {
          if specialAttack=1
          {
            atkProg=0
            specialAttack=2
          }
        }

        if atkProg=10 {sprite_index=sGBeetle_BeginThrow}
        else if atkProg=20 {sprite_index=sGBeetle_Throw}
        else if atkProg=25
        {
          playSound(global.snd_HardHit3,0,0.97,1)
          image_index=1
          var myGravBomb;
          myGravBomb=instance_create(x+(16*image_xscale),y-35,oGravityBBomb)
          myGravBomb.atkPower=atkPower; myGravBomb.moveSpd=7; myGravBomb.bounceMax=bounceMax
          myGravBomb.xVel=7*image_xscale; myGravBomb.yVel=0
        }
        else if atkProg>=35
        {
          sprite_index=sGBeetle_Idle
          image_index=0
          atkProg=0
          actionState=1
        }
      }
      else if actionState=1 //----- Hop -----
      {
        if atkProg=10 {sprite_index=sGBeetle_Jump}
        else if atkProg=18
        {
          y-=2
          yVel=-6
          xVel=2*image_xscale
        }
        else if atkProg>=20
        {
          if isCollisionBottom(1)
          {
            sprite_index=sGBeetle_Idle
            xVel=0
            yVel=0
            atkProg=0
            actionState=2
          }
        }
      }
      else if actionState=2 //----- Charge -----
      {
        if atkProg=5 {sprite_index=sGBeetle_BeginThrow; notDashable=1}
        else if atkProg=12
        {
          sprite_index=sGBeetle_Charge
          xVel=runAcc*image_xscale
        }
        else if atkProg>=101
        {
          if isCollisionBottom(1)
          {
            if bossProgress>=3
            {
              playSound(global.snd_Shock,0,0.88,37000)
              for(i=0;i<2;i+=1)
              {
                var tNewAttack;
                tNewAttack=instance_create(x,yGround-8,oPassBullet)
                tNewAttack.sprite_index=sZapTrap; tNewAttack.direction=i*180
                tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=12; tNewAttack.decayTime=-100
              }
            }
            sprite_index=sGBeetle_Idle
            xVel=0
            yVel=0
            atkProg=0
            actionState=3
          }
        }
      }
      else if actionState=3 //----- Throw orb up -----
      {
        if atkProg=1 //Check for special
        {
          if specialAttack=1
          {
            atkProg=0
            specialAttack=2
          }
        }

        if atkProg=10 {sprite_index=sGBeetle_ThrowUp}
        else if atkProg=15
        {
          playSound(global.snd_HardHit3,0,0.97,1)
          image_index=1
          var myGravBomb;
          for(i=0;i<2;i+=1)
          {
            myGravBomb=instance_create(x-(15*image_xscale),y-52,oGravityBBomb)
            myGravBomb.atkPower=atkPower; myGravBomb.moveSpd=4; myGravBomb.bounceMax=bounceMax
            myGravBomb.xVel=0; myGravBomb.yVel=-4; myGravBomb.type=i
          }
        }
        else if atkProg>=30
        {
          sprite_index=sGBeetle_Idle
          image_index=0
          atkProg=0
          actionState=4
        }
      }
      else if actionState=4 //----- Big hop away from wall -----
      {
        if atkProg=10 {sprite_index=sGBeetle_Jump}
        else if atkProg=18
        {
          y-=2
          yVel=-7
          if x>xCenter {xVel=-4}
          else {xVel=4}
        }
        else if atkProg>=20
        {
          if isCollisionBottom(1)
          {
            sprite_index=sGBeetle_Idle
            xVel=0
            yVel=0
            atkProg=0
            actionState=0
          }
        }
      }
    }
    else //Special attack
    {
      specProg+=1
      if specProg=1 //Start
      {
        notDashable=1
        throwType=0
        sprite_index=sGBeetle_BeginThrow
        if x<xCenter {image_xscale=1}
        else {image_xscale=-1}
        for(i=0;i<6;i+=1) {resType[i]=1}
      }
      else if specProg=8
      {
        sprite_index=sGBeetle_Charge
        xVel=(runAcc/2)*image_xscale
      }
      else if specProg>=2 and specProg<=99 //Dash to center
      {
        var tDistToCenter;
        tDistToCenter=point_distance(x,0,xCenter,0)
        if tDistToCenter<8
        {
          x=xCenter
          sprite_index=sGBeetle_Idle
          xVel=0
          specProg=100
        }
      }
      else if specProg=105 {sprite_index=sGBeetle_ThrowUp}
      else if specProg=110 {image_index=1}
      else if specProg>=120 and specProg<=420
      {
        if specProg mod 60=0
        {
          playSound(global.snd_HardHit3,0,0.96,1)
          playSound(global.snd_Shock,0,0.84,40000)
          var myGravBomb;
          if throwType=0
          {
            myGravBomb=instance_create(x,y-52,oGravityBBomb)
            myGravBomb.atkPower=atkPower; myGravBomb.moveSpd=5; myGravBomb.bounceMax=7
            myGravBomb.xVel=4; myGravBomb.yVel=-4; myGravBomb.type=1
            myGravBomb=instance_create(x,y-52,oGravityBBomb)
            myGravBomb.atkPower=atkPower; myGravBomb.moveSpd=5; myGravBomb.bounceMax=7
            myGravBomb.xVel=-4; myGravBomb.yVel=-4; myGravBomb.type=0
          }
          else if throwType=1
          {
            myGravBomb=instance_create(x,y-30,oGravityBBomb)
            myGravBomb.atkPower=atkPower; myGravBomb.moveSpd=5; myGravBomb.bounceMax=7
            myGravBomb.xVel=4; myGravBomb.yVel=0
            myGravBomb=instance_create(x,y-30,oGravityBBomb)
            myGravBomb.atkPower=atkPower; myGravBomb.moveSpd=5; myGravBomb.bounceMax=7
            myGravBomb.xVel=-4; myGravBomb.yVel=0
          }
          else if throwType=2
          {
            myGravBomb=instance_create(x+8,y-52,oGravityBBomb)
            myGravBomb.atkPower=atkPower; myGravBomb.moveSpd=5; myGravBomb.bounceMax=7
            myGravBomb.xVel=0; myGravBomb.yVel=-4; myGravBomb.type=0
            myGravBomb=instance_create(x-8,y-52,oGravityBBomb)
            myGravBomb.atkPower=atkPower; myGravBomb.moveSpd=5; myGravBomb.bounceMax=7
            myGravBomb.xVel=0; myGravBomb.yVel=-4; myGravBomb.type=1
          }
          throwType+=1
          if throwType=3 {throwType=0}
        }
      }
      else if specProg>=560 //End
      {
        sprite_index=sGBeetle_Idle
        notDashable=0; image_blend=baseColor
        for(i=0;i<6;i+=1) {resType[i]=3}
        resType[1]=2; resType[5]=2
        specialAttack=3
      }
    }

    if notDashable=1 {image_blend=make_color_rgb(random(255),random(255),random(255))}

    yVel+=0.5
    if isCollisionBottom(1)
      yVel=0
    if isCollisionLeft(1) and xVel<0
    {
      if sprite_index=sGBeetle_Charge
      {
        sprite_index=sGBeetle_Defeat
        y-=2
        xVel=2; yVel=-4
        playSound(global.snd_Shock,0,0.88,37000)
        var tNewAttack;
        tNewAttack=instance_create(xCenter-roomSpan+8,yGround,oPassBullet)
        tNewAttack.sprite_index=sZapTrap; tNewAttack.direction=90
        tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=12; tNewAttack.decayTime=-100

        notDashable=0; image_blend=baseColor
        atkProg=100
      }
      else {xVel=runAcc}
    }
    if isCollisionRight(1) and xVel>0
    {
      if sprite_index=sGBeetle_Charge
      {
        sprite_index=sGBeetle_Defeat
        y-=2
        xVel=-2; yVel=-4
        playSound(global.snd_Shock,0,0.88,37000)
        var tNewAttack;
        tNewAttack=instance_create(xCenter+roomSpan-8,yGround,oPassBullet)
        tNewAttack.sprite_index=sZapTrap; tNewAttack.direction=90
        tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=12; tNewAttack.decayTime=-100

        notDashable=0; image_blend=baseColor
        atkProg=100
      }
      else {xVel=-runAcc}
    }
    if isCollisionSolid()
      y-=2

    moveTo(xVel,yVel)

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.84 and lifePercent>=0.69 and bossProgress=0
    {
      runAcc+=0.25
      bossProgress+=1
    }
    else if lifePercent<=0.68 and lifePercent>=0.53 and bossProgress=1
    {
      runAcc+=0.25
      var tAtkShield;
      tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
      tAtkShield.xOffset=0; tAtkShield.yOffset=-25; tAtkShield.atkType=2; tAtkShield.atkUp=1
      resType[2]-=1
      bossProgress+=1
    }
    else if lifePercent<=0.52 and lifePercent>=0.37 and bossProgress=2
    {
      runAcc+=0.5
      bounceMax+=1
      specialAttack=1
      bossProgress+=1
    }
    else if lifePercent<=0.36 and lifePercent>=0.21 and bossProgress=3
    {
      runAcc+=0.5
      bossProgress+=1
    }
    else if lifePercent<=0.2 and lifePercent>=0 and bossProgress=4
    {
      runAcc+=0.5
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      sprite_index=sGBeetle_Defeat
      with oEProjectileBase {instance_destroy()}
      with oAttackBase {instance_destroy()}
      notDashable=0
    }
    else if deathAnim>=2 and deathAnim<=90
    {
      if deathAnim mod 9=0 {playSound(global.snd_EnemyDieMM,0,1,1)}
      if oGame.time mod 3=0
      {
        var tEffect;
        tEffect=instance_create(bbox_left+random(abs(sprite_width)),bbox_top+random(abs(sprite_height)),oEffect)
        tEffect.sprite_index=sMMExplosion; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim>=91
    {
      if global.bBossGallery=1
      {
        bossRoomTally(20)
        global.newMapX=1704; global.newMapY=992; room_goto(rBossGallery)
      }
      else {instance_destroy()}
    }
  }
  enemyStepEvent()
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if notDashable=1 {redDmgHit(0)}
else {event_inherited()}
