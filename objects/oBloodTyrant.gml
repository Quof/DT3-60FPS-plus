#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-19,-52,19,-1)
animSpd=0.33
image_speed=0

//Enemy base statistics
eName="Blood Tyrant"
eLevel=20
maxLife=1600
life=maxLife
pointWorth=40
atkPower=8
stunResist=4
baseItemChance=85
baseDropIndex=85
moneyWorth=10
affiliation=8
dieSound=0
dieEffect=0
enemyProg=0
inactiveDist*=2

runAcc=2.25
bJumpReady=1
minDistToPlayer=80
shielding=0
shieldPower=0
myShield=0
imageEffect=0

atkChosen=0
earthPillar=0
earthX=0
earthY=0
earthPDir=0
earthPilScl=1
atkCloseTime=80
atkCloseDelay=130
atkChargeTime=50
atkChargeDelay=145
atkJumpTime=90
atkJumpDelay=250
resElemTime=-1

jeremyText="I can't read anything on this guy. It's as if someone knows my methods and is blocking them."
chaoText="I'm not blocked out. First up, it can detect different terrain types and navigate fairly well to chase you. During its swing, it lunges forward, which it uses if you're close. If you back away, it'll charge, leaving a trail of fire behind it. Another thing it may do is dash back then leap. Get ready to dash when it does this, it's going to use a projectile attack. Another thing, don't use PIERCE or SHOT type weapons if it's not attacking."
devText="This is the first of a group of 'Elite' class enemies in DT3. Enemies marked like this are supposed to give a sense of fear due to their combat style. Better get used to combat in DT3, enemies of this class ramp it up."
extraInfo="Boosts defenses when guarding."

deathAnim=0

if global.gameProgress>=3270
{
  eName="Upgraded Blood Tyrant"
  eLevel=28
  maxLife=2000
  life=maxLife
  pointWorth=60
  atkPower=9
  stunResist=7
  if global.location=99 //Warship only
  {
    eName="Oppressive Blood Tyrant"
    eLevel=38
    maxLife=2400
    life=maxLife
    pointWorth=110
    atkPower=10
    stunResist=9
  }
  jeremyText="Oh man... I can scan them now! Something to note about them that I can actually scan now. They've been upgraded slightly. Its HP has increased a bit as well as its Stun Resist. Oh man, OH MAN. I just saw something else. They've always had this exploit, but right after they do their flashy shield thing and annoyingly spam the screen with projectiles. They take 2x damage to ELEMENTAL type."
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0 and life>0
  {
    imageEffect+=1
    if imageEffect mod 8=0
    {
      var tAfterI;
      tAfterI=instance_create(x,y,oEnemyAfterImage)
      tAfterI.sprite_index=sprite_index; tAfterI.image_index=image_index; tAfterI.image_blend=c_red
      tAfterI.image_alpha=0.35; tAfterI.image_xscale=image_xscale; tAfterI.depth=26; tAfterI.imageFade=0.01
      tAfterI.xScaling=0.04; tAfterI.yScaling=0.04; tAfterI.xShift=0; tAfterI.yShift=0
      tAfterI.bFollow=1; tAfterI.idFollow=id; tAfterI.xFollow=0; tAfterI.yFollow=0
    }

    if sprite_index=sBT_ChargeB
    {
      if pointWorth=40 {stunResist=10}
      else {stunResist=12}
    }
    else
    {
      if pointWorth=40 {stunResist=4}
      else {stunResist=7}
    }

    if resElemTime>0 //Elemental resist goes back to 1x after 1 second from shield use
    {
      resElemTime-=1
      if resElemTime=0
      {
        resType[2]=3
        resElemTime=-1
      }
    }

    //---------- Movement ----------
    if sprite_index!=sBT_Attack and sprite_index!=sBT_EarthStab and sprite_index!=sBT_ChargeA and sprite_index!=sBT_ChargeB and sprite_index!=sBT_DashBack and sprite_index!=sBT_Shield
    {
      image_index+=animSpd
      if yVel=0 and bJumpReady=1
      {
        if x<oPlayer1.x {image_xscale=1}
        else {image_xscale=-1}

        if point_distance(x,y,oPlayer1.x,oPlayer1.y-26)>minDistToPlayer+(minDistToPlayer/5)
        {
          atkChargeTime+=1
          sprite_index=sBT_Walk
          if image_xscale=1 {xVel=runAcc}
          else {xVel=-runAcc}
        }
        else if point_distance(x,y,oPlayer1.x,oPlayer1.y-26)<minDistToPlayer
        {
          atkCloseTime+=2
          sprite_index=sBT_Walk
          if image_xscale=1 {xVel=-runAcc}
          else {xVel=runAcc}
        }
        else
        {
          atkCloseTime+=1
          sprite_index=sBT_Idle
          xVel=0
        }
      }
      else
      {
        if atkJumpTime<atkJumpDelay
        {
          if yVel<0 {sprite_index=sBT_JumpA}
          else {sprite_index=sBT_JumpB}
        }
      }
    }
    else if sprite_index=sBT_Shield {image_index+=animSpd}

    //---------- ENERGY SHIELD ----------
    if shielding=0 and (sprite_index=sBT_Idle or sprite_index=sBT_Walk) //Check updates
    {
      if instance_exists(oAttackBase)
      {
        var tPAtkType;
        tPAtkType=instance_nearest(x,y-25,oAttackBase)
        if tPAtkType.damageType="PIERCE" or tPAtkType.damageType="SHOT"
        {
          var tPAtkDist;
          tPAtkDist=point_distance(x,0,tPAtkType.x,0)
          if tPAtkDist<80 and tPAtkType.y<bbox_bottom-2 and tPAtkType.y>bbox_top+2
          {
            xVel=0
            shielding=1
            sprite_index=sBT_Shield
            myShield=instance_create(x+(18*image_xscale),y-32,oBTShield)
            myShield.image_xscale=image_xscale*1.6; myShield.image_yscale=1.1
            myShield.ownerID=id
          }
        }
      }
    }
    else if shielding=1 //Check shield status
    {
      if instance_exists(oAttackBase)
      {
        var tPAtkType;
        tPAtkType=instance_nearest(x,y-25,oAttackBase)
        if tPAtkType.damageType="PIERCE" or tPAtkType.damageType="SHOT"
        {
          var tPAtkDist;
          tPAtkDist=point_distance(x,0,tPAtkType.x,0)
          if tPAtkDist>64 {shielding=2}
        }
      }
      else {shielding=2}
    }
    else if shielding>=2 and shielding<=9
    {
      shielding+=1
      if shielding>=8
      {
        sprite_index=sBT_Idle
        with myShield {instance_destroy()}
        shielding=0
      }
    }

    if shieldPower<2
    {
      if instance_exists(myShield)
      {
        resType[0]=1
        resType[3]=2
        resType[5]=1
      }
      else
      {
        resType[0]=3
        resType[3]=3
        if enemyProg=0 {resType[5]=3}
        else resType[5]=2
      }
    }

    //---------- Release shield energy ----------
    if shieldPower=2
    {
      with myShield {instance_destroy()}
      //Set other attacks just below threshold if they are over it
      if atkCloseTime>atkCloseDelay {atkCloseTime=atkCloseDelay-5}
      if atkChargeTime>atkChargeDelay {atkChargeTime=atkChargeDelay-10}
      if atkJumpTime>atkJumpDelay {atkJumpTime=atkJumpDelay-15}
      xVel=0
      sprite_index=sBT_Shield
      shielding=11
      for(i=0;i<6;i+=1)
      {
        resType[i]=1
      }
      shieldPower+=1
    }
    else if shieldPower>=3
    {
      shieldPower+=1
      image_blend=make_color_rgb(random(255),random(255),random(255))

      if shieldPower=30 //Fire shield energy blasts
      {
        var tFire,tFDir;
        if image_xscale=1 {tFDir=330}
        else {tFDir=150}
        for(i=0;i<5;i+=1)
        {
          tFire=instance_create(x+(8*image_xscale),y-20,oPassBullet)
          tFire.sprite_index=sBTFireball; tFire.direction=tFDir; tFire.atkPower=atkPower
          tFire.bulletSpeed=7; tFire.decayTime=120
          tFDir+=15
        }
      }
      else if shieldPower=40 //Fire shield energy blasts
      {
        var tFire,tFDir;
        if image_xscale=1 {tFDir=330}
        else {tFDir=150}
        for(i=0;i<4;i+=1)
        {
          tFire=instance_create(x+(8*image_xscale),y-20,oPassBullet)
          tFire.sprite_index=sBTFireball; tFire.direction=tFDir; tFire.atkPower=atkPower
          tFire.bulletSpeed=7; tFire.decayTime=120
          tFDir+=20
        }

        shielding+=1
        if shielding>=13 //End shield cycle
        {
          sprite_index=sBT_Idle
          image_blend=baseColor
          for(i=0;i<6;i+=1)
          {
            resType[i]=3
          }
          resType[2]=4
          resElemTime=30
          if enemyProg=1 {resType[5]=2}
          shieldPower=0
          shielding=0
        }
        else {shieldPower=20}
      }
    }

    if yVel=0 and bJumpReady=1
    {
      //---------- Check if wall and jump up ----------
      if aiCheckHoriz(0,3,16,16,-8)=1
      {
        if collision_point(x,y+4,oSolid,0,1) {y-=4}
        yVel=-6.5
      }

      //---------- Check if cliff edge and jump ----------
      var tDrop;
      tDrop=0
      if aiCheckHoriz(1,1,0,16,4)
      {
        if aiCheckVert(0,3,24,16,4)=1 {tDrop=1}
      }

      if tDrop=0
      {
        if atkCloseTime>atkCloseDelay {atkCloseTime=atkCloseDelay-30}
        if atkChargeTime>atkChargeDelay {atkChargeTime=atkChargeDelay-40}
        if sprite_index=sBT_ChargeB {xVel=(runAcc*2)*image_xscale}
        else {xVel=(runAcc*1.25)*image_xscale}
        sprite_index=sBT_JumpA
        y-=4
        yVel=-6
        bJumpReady=0
      }
    }

    //---------- Attack close range ----------
    atkCloseTime+=1
    if atkCloseTime>=atkCloseDelay and atkCloseTime<=atkCloseDelay+100
    {
      if point_distance(x,y,oPlayer1.x,oPlayer1.y-26)<minDistToPlayer+(minDistToPlayer/5)+1 and atkChargeTime<atkChargeDelay and sprite_index!=sBT_Shield and bJumpReady=1
      {
        xVel=0
        atkChosen=enemyProg+1
        if atkChosen=1 {sprite_index=sBT_Attack}
        else if atkChosen=2 {sprite_index=sBT_EarthStab}
        image_index=0
        atkCloseTime=1000
      }
      else {atkCloseTime=atkCloseDelay-20}
    }

    if atkChosen=1 //Normal swing
    {
      if atkCloseTime=1015
      {
        if image_xscale=1 {xVel=runAcc*2}
        else {xVel=-runAcc*2}
      }
      else if atkCloseTime>=1016 and atkCloseTime<=9999
      {
        image_index+=animSpd*1.25
        if image_xscale=1 {xVel-=0.075}
        else {xVel+=0.075}

        if image_index>=5.5
        {
          image_index=1
          xVel=0
          atkCloseTime=10000
        }
      }
    }
    else if atkChosen=2 //Earth Spike
    {
      if atkCloseTime>=1007 and atkCloseTime<=9999
      {
        if atkCloseTime=1011
        {
          earthX=x+(image_xscale*20)
          earthY=y
          earthPDir=image_xscale
          earthPilScl=0.3
          earthPillar=1
        }
        image_index+=animSpd
        if image_index>=4.5 {atkCloseTime=10009}
      }
    }

    if atkCloseTime>=10010
    {
      sprite_index=sBT_Idle
      atkCloseTime=0
    }

    if earthPillar>=1
    {
      earthPillar+=1
      if earthPillar mod 5=0
      {
        var tFire;
        tFire=instance_create(earthX,earthY,oDamageExplosion)
        tFire.sprite_index=sBTFirePillar; tFire.image_yscale=earthPilScl
        tFire.atkPower=atkPower; tFire.damageType="EXPLOSION"; tFire.decayTime=15
        earthX+=18*earthPDir
        earthPilScl+=0.15
      }
      if earthPillar>=40 {earthPillar=0}
    }

    //---------- Charge if player is too far ----------
    atkChargeTime+=1
    if atkChargeTime>=atkChargeDelay and atkChargeTime<=atkChargeDelay+100
    {
      if point_distance(x,y,oPlayer1.x,oPlayer1.y-26)>minDistToPlayer+(minDistToPlayer/2) and atkCloseTime<atkCloseDelay and sprite_index!=sBT_Shield and bJumpReady=1
      {
        sprite_index=sBT_ChargeA
        xVel=0
        atkChargeTime=1000
      }
      else {atkChargeTime=atkChargeDelay-20}
    }
    else if atkChargeTime=1015
    {
      sprite_index=sBT_ChargeB
      if image_xscale=1 {xVel=runAcc*4}
      else {xVel=-runAcc*4}
    }
    else if atkChargeTime>=1016
    {
      if atkChargeTime mod 2=0 //Ground fire
      {
        var tFire;
        tFire=instance_create(x,y,oDamageExplosion)
        tFire.sprite_index=sFlameUp; tFire.image_speed=0.5; tFire.atkPower=atkPower
        tFire.damageType="ELEMENTAL"; tFire.decayTime=15
      }

      if (image_xscale=1 and x>oPlayer1.x+32) or (image_xscale=-1 and x<oPlayer1.x-32) or (atkChargeTime>=1060)
      {
        sprite_index=sBT_Idle
        atkChargeTime=0
      }
    }

    //---------- Jump and attack player ----------
    atkJumpTime+=1
    if atkJumpTime>=atkJumpDelay and atkJumpTime<=atkJumpDelay+100
    {
      if point_distance(x,y,oPlayer1.x,oPlayer1.y-26)<minDistToPlayer+(minDistToPlayer/2) and atkCloseTime<atkCloseDelay and sprite_index!=sBT_Shield and bJumpReady=1
      {
        sprite_index=sBT_DashBack
        if image_xscale=1 {xVel=-runAcc*3}
        else {xVel=runAcc*3}
        bJumpReady=0
        atkJumpTime=1000
      }
      else {atkJumpTime=atkJumpDelay-20}
    }
    else if atkJumpTime>=1001 and atkJumpTime<=1010 //Dash back
    {
      if image_xscale=1 {xVel+=0.075}
      else {xVel-=0.075}
    }
    else if atkJumpTime=1011 //Jump
    {
       xVel=(runAcc*1.25)*image_xscale
       sprite_index=sBT_JumpA
       y-=4
       yVel=-8
    }
    else if atkJumpTime=1019 //Attack
    {
      sprite_index=sBT_JumpAttack
      image_index=0

      var tFire,tFDir;
      tFDir=point_direction(x+(8*image_xscale),y-20,oPlayer1.x,oPlayer1.y-26)-20

      for(i=0;i<3;i+=1)
      {
        tFire=instance_create(x+(8*image_xscale),y-20,oPassBullet)
        tFire.sprite_index=sBTFireball; tFire.direction=tFDir
        tFire.atkPower=atkPower; tFire.bulletSpeed=7; tFire.decayTime=120
        tFDir+=20
      }
    }
    else if atkJumpTime>=1020 //Anim end
    {
      if image_index>=4.5
      {
        sprite_index=sBT_JumpA
        atkJumpTime=0
      }
    }

    yVel+=0.3
    if isCollisionBottom(1)
    {
      yVel=0
      if atkJumpTime<atkJumpDelay {bJumpReady=1}
    }
    if isCollisionLeft(1)
      xVel=runAcc
    if isCollisionRight(1)
      xVel=-runAcc
    if isCollisionSolid()
      y-=2

    moveTo(xVel,yVel)

    if y>room_height+24 {instance_destroy()}
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      image_speed=0
      playSound(global.snd_HardHit1,0,1,1)
      tEfCir=instance_create(x,y-24,oEfCircleBlast)
      tEfCir.image_alpha=0.8; tEfCir.myRad=4; tEfCir.radScl=5; tEfCir.fadeSpeed=0.08
    }

    if deathAnim mod 4=0
    {
      if deathAnim mod 8=0 {playSound(global.snd_BombExplode,0,0.8,1)}
      tEffect=instance_create(x+random_range(-10,10),y-1-random(42),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.04
    if image_alpha<0 {instance_destroy()}
  }

  if lifePercent<=0.5 and enemyProg=0
  {
    runAcc=2.5
    minDistToPlayer=100
    if shieldPower<2 {shieldPower=2}
    enemyProg=1
  }
  enemyStepEvent()
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.damageType="NORMAL"
{
  if atkJumpTime<atkJumpDelay {atkJumpTime+=10}
}
