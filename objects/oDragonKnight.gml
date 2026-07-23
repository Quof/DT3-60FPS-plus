#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-30,-63,30,-1)
animSpd=0.15
image_speed=0

//Enemy base statistics
eName="Dragon Knight"
eLevel=25
maxLife=2600
life=maxLife
pointWorth=70
atkPower=8
resType[5]=4
stunResist=6
baseItemChance=85
baseDropIndex=85
moneyWorth=20
affiliation=8
dieEffect=0
enemyProg=0
inactiveDist*=2

//-- Movement Data --
runAcc=2.25

//-- Attack Data --
currentAction=0
lastAction=0
attackDelay=0
waitTime=40
atkSpd=0.15
groundHitScl=1.25
shieldDuration=45

//-- Misc Data --
xAdj=0
yAdj=0
swordAng=0
bJumpReady=1
minDistToPlayer=90
imageEffect=0

deathAnim=0

//jeremyText="This guy is on the same level as those Blood Tyrants. Very sturdy and powerful. However, these are slower and more sluggish than the Tyrants and aren't quite as versatile. Watch for when he's about to swing his sword. The trick is it's really a chain sword, much like Ivy from Soul Calibur. That shield isn't just for show either, he becomes nearly immune to damage with it up."
jeremyText="Another piece of data that I can't access. This is getting annoying!"
chaoText="The big thing to watch for is when he's about to dive bomb. He causes a large shockwave as he hits the ground. Also, when he's charging with his shield up, he opens a big vulnerability to EXPLOSIVE damage!"
devText="The second of the 'Elite' enemies. Dealing with these takes some planning and understanding of game mechanics if you're fighting it in small spaces. It's less about reacting. On its own, it's not as bad as a Blood Tyrant."
extraInfo="Boosts Stun Resist when shielding."

if global.location=99 //Warship only
{
  eName="Upgraded Dragon Knight"
  eLevel=38
  maxLife=3000
  life=maxLife
  pointWorth=130
  atkPower=11
  stunResist=9
}

mySword=instance_create(x-18,y-32,oSwordKnightSword)
mySword.ownerID=id; mySword.atkPower=atkPower; mySword.sprite_index=sDKSword
myExtSword=noone
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

    //Set Resistances
    if sprite_index=sDK_DiveReady or sprite_index=sDK_DiveDown or sprite_index=sDK_HitGround or sprite_index=sDK_Roll
      stunResist=9
    else if sprite_index=sDK_ShieldReady or sprite_index=sDK_ShieldWalk
      stunResist=15
    else
      stunResist=6

    if stunResist=15
    {
      for(i=0;i<6;i+=1)
      {
        resType[i]=1
      }
      resType[4]=4
    }
    else
    {
      for(i=0;i<6;i+=1)
      {
        resType[i]=3
      }
      if stunResist=9 or sprite_index=sDK_Fly {resType[0]=2}
      if enemyProg=0 {resType[5]=4}
      else if enemyProg=1 {resType[5]=3}
      else if enemyProg=2 {resType[3]=2; resType[5]=3}
      else if enemyProg=3 {resType[1]=2; resType[2]=2; resType[3]=2; resType[5]=3}
    }

    //---------- Movement ----------
    if currentAction=0 //---------- No action: Ready ----------
    {
      image_speed=0
      image_index+=animSpd

      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}

      if point_distance(x,0,oPlayer1.x,0)>minDistToPlayer+(minDistToPlayer/5)
      {
        if sprite_index!=sDK_Fly {sprite_index=sDK_Walk}
        if image_xscale=1 {xVel=runAcc}
        else {xVel=-runAcc}
      }
      else if point_distance(x,0,oPlayer1.x,0)<minDistToPlayer
      {
        if sprite_index!=sDK_Fly {sprite_index=sDK_Walk}
        if image_xscale=1 {xVel=-runAcc}
        else {xVel=runAcc}
      }
      else
      {
        if sprite_index!=sDK_Fly {sprite_index=sDK_Idle}
        xVel=0
      }

      attackDelay+=1
      if attackDelay>=waitTime //Decide action
      {
        if sprite_index=sDK_Fly
        {
          currentAction=30
        }
        else
        {
          var tBehaviorArc;
          tBehaviorArc=0
          if point_distance(x,0,oPlayer1.x,0)<=96 {tBehaviorArc=0} //Close
          else if point_distance(x,0,oPlayer1.x,0)>=144 {tBehaviorArc=80} //Far
          else {tBehaviorArc=30} //Mid
          tBehaviorArc+=random(100)
          if tBehaviorArc>=0 and tBehaviorArc<=70
          {
            if lastAction=10 {currentAction=40}
            else if lastAction=40 {currentAction=10}
            else {currentAction=choose(10,40)}
          }
          else if tBehaviorArc>=71 and tBehaviorArc<=120
          {
            if lastAction=10 {currentAction=20}
            else if lastAction=20 {currentAction=10}
            else {currentAction=choose(10,20)}
          }
          else
          {
            if lastAction=20 {currentAction=40}
            else if lastAction=40 {currentAction=20}
            else {currentAction=choose(20,40)}
          }
          lastAction=currentAction
        }
        xVel=0
        attackDelay=0
      }
    }
    else if currentAction>=10 and currentAction<=19 //---------- Attack: Chain Sword ----------
    {
      attackDelay+=1
      if attackDelay=1 //Ready sword
      {
        sprite_index=sDK_Swing; image_index=0
      }
      else if attackDelay>=7 and attackDelay<=99 //Swing
      {
        image_index+=atkSpd
        if image_index>=3.3 {attackDelay=100; image_index=3}
      }
      else if attackDelay=104 //Spawn Chain Sword
      {
        myExtSword=instance_create(x+(30*image_xscale),y-16,oDK_ChainSword)
        myExtSword.ownerID=id; myExtSword.atkPower=atkPower; myExtSword.image_xscale=image_xscale
        playSound(global.snd_MMDoorOpen,0,0.96,33000)
      }
      else if attackDelay>=105 and attackDelay<=199
      {
        myExtSword.x=x+(30*image_xscale); myExtSword.y=y-16
      }
      else if attackDelay>=205 //Revert to idle
      {
        sprite_index=sDK_Idle
        attackDelay=0; currentAction=0
      }
    }
    else if currentAction>=20 and currentAction<=29 //---------- Action: Jump and Fly Up ----------
    {
      attackDelay+=1
      if attackDelay=1 //Jump up
      {
        sprite_index=sDK_Fly; image_index=0; image_speed=animSpd
        y-=2; yVel=-7
      }
      else if attackDelay=21
      {
        yVel=0
        attackDelay=0; currentAction=0
      }
    }
    else if currentAction>=30 and currentAction<=39 //---------- Attack: Dive and flip back ----------
    {
      attackDelay+=1
      if attackDelay=1 {sprite_index=sDK_DiveReady}
      else if attackDelay=14 //Dive down
      {
        var tCheckDist;
        tCheckDist=point_distance(x,0,oPlayer1.x,0)
        if tCheckDist>=96 {xVel=6*image_xscale}
        else
        {
          xVel=4*image_xscale
          if image_xscale=1 {image_angle-=20}
          else {image_angle+=20}
        }
        yVel=9
        atkPower=10
        sprite_index=sDK_DiveDown
      }
      else if attackDelay=114 //Flip back
      {
        sprite_index=sDK_Roll; image_speed=animSpd*2
        y-=2; yVel=-5
        xVel=3*-image_xscale
      }
    }
    else if currentAction>=40 and currentAction<=49 //---------- Action: Shielding ----------
    {
      attackDelay+=1
      if attackDelay=1 {sprite_index=sDK_ShieldReady}
      else if attackDelay=12
      {
        if x<oPlayer1.x {image_xscale=1}
        else {image_xscale=-1}
        sprite_index=sDK_ShieldWalk
      }
      else if attackDelay>=13 and attackDelay<=13+shieldDuration //Walk toward player with shield
      {
        image_speed=animSpd*1.5
        if image_xscale=1 {xVel=runAcc*1.5}
        else {xVel=-runAcc*1.5}

        if (x>oPlayer1.x and image_xscale=1) or (x<oPlayer1.x and image_xscale=-1) //If player gets around Dragon Knight
        {
          attackDelay=13+shieldDuration
        }

        if attackDelay=13+shieldDuration //Check end of charge
        {
          sprite_index=sDK_ShieldReady
          xVel=0
        }
      }
      else if attackDelay>=62 //Revert to idle
      {
        sprite_index=sDK_Idle
        attackDelay=0; currentAction=0
      }
    }

    if yVel=0 and bJumpReady=1
    {
      //---------- Check if cliff edge and stop ----------
      //Check if at cliff edge and stop
      if sprite_index!=sDK_Fly and sprite_index!=sDK_DiveReady
      {
        /*if aiCheckSpecial(0,3,4)=1
        {
          sprite_index=sDK_Idle
          xVel=0
        }*/

        var tDrop;
        tDrop=0
        if aiCheckHoriz(1,1,0,16,4)
        {
          if aiCheckVert(0,3,24,16,4)=1 {tDrop=1}
        }

        if tDrop=0
        {
          sprite_index=sDK_Idle
          xVel=0
        }
      }
    }

    event_user(0) //Sword placement

    if sprite_index!=sDK_Fly and sprite_index!=sDK_DiveReady {yVel+=0.3}

    if isCollisionBottom(1)
    {
      yVel=0
      bJumpReady=1
      if sprite_index=sDK_DiveDown
      {
        xVel=0
        sprite_index=sDK_HitGround; image_angle=0; image_speed=0
        playSound(global.snd_HardHit1,0,0.95,1)
        var tNewAtk;
        tNewAtk=instance_create(x,y,oDamageExplosion)
        tNewAtk.atkPower=atkPower; tNewAtk.sprite_index=sGroundBlast
        tNewAtk.image_xscale=groundHitScl; tNewAtk.image_yscale=groundHitScl; tNewAtk.decayTime=-100
        atkPower=8
        attackDelay=100
      }
      else if sprite_index=sDK_Roll
      {
        xVel=0
        sprite_index=sDK_Idle; image_speed=0
        attackDelay=0; currentAction=0
      }
    }
    if isCollisionLeft(1)
      xVel=runAcc
    if isCollisionRight(1)
      xVel=-runAcc
    if isCollisionSolid()
      y-=2

    moveTo(xVel,yVel)

    if y>room_height+24
    {
      with mySword {instance_destroy()}
      if instance_exists(myExtSword)
      {
        with myExtSword {instance_destroy()}
      }
      instance_destroy()
    }
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      image_speed=0
      with mySword {instance_destroy()}
      if instance_exists(myExtSword)
      {
        with myExtSword {instance_destroy()}
      }
      playSound(global.snd_HardHit1,0,1,1)
      tEfCir=instance_create(x,y-32,oEfCircleBlast)
      tEfCir.image_alpha=0.8; tEfCir.myRad=8; tEfCir.radScl=6; tEfCir.fadeSpeed=0.08
    }

    if deathAnim mod 4=0
    {
      if deathAnim mod 8=0 {playSound(global.snd_BombExplode,0,0.8,1)}
      tEffect=instance_create(x+random_range(-24,24),y-1-random(60),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.04
    if image_alpha<0
    {
      instance_destroy()
    }
  }

  if lifePercent<=0.8 and enemyProg=0
  {
    var tAtkShield;
    tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
    tAtkShield.xOffset=0; tAtkShield.yOffset=-40; tAtkShield.atkType=5; tAtkShield.atkUp=1
    runAcc=2.4
    minDistToPlayer=112
    waitTime-=5
    atkSpd+=0.05
    shieldDuration+=3
    enemyProg+=1
  }
  else if lifePercent<=0.6 and enemyProg=1
  {
    var tAtkShield;
    tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
    tAtkShield.xOffset=0; tAtkShield.yOffset=-40; tAtkShield.atkType=3; tAtkShield.atkUp=1
    runAcc=2.55
    minDistToPlayer=130
    waitTime-=5
    atkSpd+=0.05
    shieldDuration+=3
    enemyProg+=1
  }
  else if lifePercent<=0.4 and enemyProg=2
  {
    var tAtkShield;
    tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
    tAtkShield.xOffset=0; tAtkShield.yOffset=-40; tAtkShield.atkType=1; tAtkShield.atkUp=1
    runAcc=2.7
    minDistToPlayer=148
    groundHitScl+=0.15
    waitTime-=4
    atkSpd+=0.05
    shieldDuration+=4
    enemyProg+=1
  }
  enemyStepEvent()
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Sword placement
xAdj=0
yAdj=100000
if sprite_index=sDK_Swing
{
  if image_index>=0 and image_index<=0.99
  {
    xAdj=42
    yAdj=43
    if image_xscale=1
      swordAng=115
    else
      swordAng=65
  }
  else if image_index>=1 and image_index<=1.99
  {
    xAdj=7
    yAdj=60
    swordAng=270
  }
  else if image_index>=2 and image_index<=2.99
  {
    xAdj=-31
    yAdj=53
    if image_xscale=1
      swordAng=150
    else
      swordAng=30
  }
  else if image_index>=3 and image_index<=3.99
  {
    xAdj=-30
    yAdj=16
    if image_xscale=1
      swordAng=0
    else
      swordAng=180
  }
}
else if sprite_index=sDK_ShieldReady
{
  xAdj=42
  yAdj=43
  swordAng=90
}

if image_xscale=1 {mySword.x=x-xAdj}
else {mySword.x=x+xAdj}
mySword.y=y-yAdj
mySword.image_angle=swordAng

if instance_exists(myExtSword) {mySword.visible=0}
else {mySword.visible=1}
