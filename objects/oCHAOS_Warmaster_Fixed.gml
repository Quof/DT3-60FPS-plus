#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
USER DEFINED EVENTS
0: End of attack
1: Behaviors - Form A
2: Behaviors - Form B
3: Behaviors - Form C
4: Behaviors - Form D
5: Swap Forms
6: Choose an attack
7: Set change order
*/
event_inherited()
makeActive()
setCollisionBounds(-14,-44,14,-1)
image_xscale=-1.25
image_yscale=1.25
scaleForFacing=1
image_speed=0

//Enemy base statistics
eName="CHAOS Warmaster"
eLevel=40
maxLife=6250
life=maxLife
atkPower=10
resType[1]=2
resType[2]=1
resType[3]=1
resType[4]=2
resType[5]=1
stunResist=50
affiliation=7
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
ATTACK_FORM=1 //Which form the Warmaster is using --- A1:Main, B2:Fire, C3:Ice, D4:Wind
ATTACK_SPEED=1 //Alters certain attack's speed
DIFFICULTY=1 //Alter certain attack behaviors
shiftType=0 //Alter rules on changing form
shiftTime=0
shiftMaxTime=750
shiftDamage=0
shiftDmgMax=42
superChangeAtk=0 //If the quick change attack is performed
superAtkType=0 //Determines which quick change sequence to use
previousForm=0
orderNum=1 //How far into the order change sequence
prevShTime=0
prevShDmg=0
timeTillLastHit=0 //Time since the Warmaster was damaged last
timeChangeSet=1 //Determine how much time to stay in one form during the last 30%
timeTillChange=210

bChangeSpeed=0
bChangeDifficulty=0
//-- Attack Data --
atkInSequence=0 //This helps determines which behavior to use
currentAttack=0
previousAtk=0

atkNum=0 //current attack in string
atkMax=2 //max attacks in a string
waitTime=30
waitDelay=60 //idle time between attack strings
actTime=0 //progress in an action

dashEfType=0
dashEfFrm=0
jetEfFrm=0

superCharge=0; superMax=5
//-- Form A1 Data --
bRope=0
ropeX=0
ropeYscl=0
swdRollAng=0

//-- Form B2 Data --
fireFreq=5
fireDuration=170
fireType=0
fireSide=1
fireUse=0
for(i=0;i<3;i+=1)
{
  firePlacement[i]=12+(12*i)
}

//-- Form C3 Data --
hoverMode=0 //0: No hover, 1: Follow player but stay above them, 2: Hover near mid-top of room
currHspd=0
currVspd=0
orbitNum=6 //Number of orbiting ice shards to summon
numOfAtks=0 //Number of attacks before swapping between hover/ground mode (Will spend more time in hover mode)

//-- Form D4 Data --
altUppercut=0

//Movement speeds
bGravity=1 //If gravity is in effect for the Warmaster

runAcc=2
dashAcc=8
fastDashAcc=11
jumpAcc=3
dashJumpAcc=4
fastDashJumpAcc=14
superFireDashAcc=20

jumpNum=0
imageEffect=0

//Achievment data
bGoombaStomp=0
goombaStompTime=0

backGroundFlash=0
//--------------------

//Misc Data
xCenter=368
roomSpan=320
yGround=288
roomHeight=224

orderChangeSetting=0
event_user(7)

deathAnim=0

ATTACK_FORM=myType

activateBoss=1
if myType=1
{
  
}
else if myType=2
{
  sprite_index=sWarmasterB_Idle
  for(i=0;i<6;i+=1)
  {
    resType[i]=3
  }
  resType[0]=2; resType[3]=1; resType[4]=1; resType[5]=2
}
else if myType=3
{
  sprite_index=sWarmasterC_Idle
  for(i=0;i<6;i+=1)
  {
    resType[i]=3
  }
  resType[0]=1; resType[1]=1; resType[2]=1; resType[5]=2
}
else if myType=4
{
  sprite_index=sWarmasterD_Idle
  for(i=0;i<6;i+=1)
  {
    resType[i]=3
  }
  resType[0]=1; resType[1]=1; resType[2]=2; resType[4]=2
}
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
    if myType=1
    {
      showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=0
      showBossHP.newOffsetX=378
    }
    else if myType=2
    {
      showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=0
      showBossHP.newOffsetX=401
    }
    else if myType=3
    {
      showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=0
      showBossHP.newOffsetX=424
    }
    else if myType=4
    {
      showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=0
    }
    bCanDealDamage=true; bCanTakeDamage=true
    jeremyText="The Warmaster is able to employ a wide range of close range sword attacks. Which is trouble for you because he's practically immune to most of your projectiles. He's got a standard sword attack that also launches a fairly close range wave. A dash, jump, and dive attack. Jerry, you cover a lot of space with your sword, but Claire, you have good range. Keep that in mind."
    chaoText="There's definitely more to him than this, there has to be. A bot so renown for being unbeatable would have a lot more than this."
    devText="If you've made it to this, then you've been doing well. I hope you enjoyed the game as much as I enjoyed making it. It was a long process, but a lot was learned. This is also my departure from sprite rips. While I enjoy this type of stuff, I've got a lot of other ideas I'd like to explore. Also this guy is really challenging, hope you're up for it."
    activateBoss=2
  }

  if bActive=true and life>0
  {
    /*if bGoombaStomp=1 and ATTACK_FORM!=3 //Limited time on achievement after Warmaster swaps
    {
      goombaStompTime-=1
      if goombaStompTime<=0 {bGoombaStomp=0}
    }*/

    timeTillLastHit+=1
    //-------------------- Manage form change --------------------
    /*if superChangeAtk=0
    {
      if atkNum=0
      {
        if shiftType=0 or shiftType=1
        {
          if shiftDamage>=4
          {
            shiftTime+=1
            if shiftTime>=shiftMaxTime or shiftDamage>=shiftDmgMax and currentAttack=0 and atkNum=0
            {
              if orderChangeSetting=0
              {
                event_user(7)
                orderChangeSetting=1
              }

              ATTACK_FORM=orderSet[orderNum]
              orderNum+=1
              if orderNum=4 {orderNum=0; event_user(7)}
              event_user(5)
            }
          }
        }
        else
        {
          shiftTime+=1
          if shiftTime>=timeTillChange and currentAttack=0
          {
            ATTACK_FORM=orderSet[orderNum]
            orderNum+=1
            if orderNum=4 {orderNum=0; event_user(7)}
            event_user(5)
            timeChangeSet+=1
            if timeChangeSet=1 {timeTillChange=210}
            else if timeChangeSet=2 {timeTillChange=110}
            else if timeChangeSet=3 {timeTillChange=170}
            else if timeChangeSet=4 {timeTillChange=90}
            else if timeChangeSet=5 {timeTillChange=150; timeChangeSet=0}
            if ATTACK_FORM=3 {timeTillChange+=30}
          }
        }
      }
    }*/

    //-------------------- Facing direction --------------------
    if waitTime<waitDelay or sprite_index=sWarmasterD_Hover
    {
      if x<oPlayer1.x {image_xscale=1.25}
      else {image_xscale=-1.25}
      xVel=0
    }
    if image_xscale>0 {scaleForFacing=1}
    else {scaleForFacing=-1}

    //-------------------- Idle animation speed --------------------
    if sprite_index=sWarmasterA_Idle {image_index+=0.25}
    else if sprite_index=sWarmasterA_JumpUp or sprite_index=sWarmasterA_JumpDown {image_index+=0.25}
    else if sprite_index=sWarmasterB_Idle or sprite_index=sWarmasterC_Idle or sprite_index=sWarmasterD_Idle {image_index+=0.15}

    if sprite_index=sWarmasterA_SwordRoll {swdRollAng-=45*scaleForFacing}

    if sprite_index=sWarmasterA_GrappleRopeB //Keep in place when grappled to the rope
    {
      x=ropeX+(10*image_xscale)
      y=182 //48+96+38 - ceiling_height+rope_length+sprite_height_offset
    }

    //-------------------- Effect timer --------------------
    if dashEfType>0
    {
      dashEfFrm+=0.33
      if dashEfFrm>=2.6 {dashEfType=0}
    }

    if sprite_index=sWarmasterB_Dashing //Super dash trail and fire pillars
    {
      var tAfterI;
      tAfterI=instance_create(x,y,oWMB_DashImage)
      tAfterI.image_xscale=image_xscale; tAfterI.image_yscale=image_yscale

      if actTime mod 3=0 and currentAttack=5
      {
        var tDFPillar;
        tDFPillar=instance_create(x,yGround,oWMB_DashFPillar); tDFPillar.atkPower=atkPower
        tDFPillar.image_xscale=0.6; tDFPillar.image_yscale=0.9
      }
    }

    //Movement - Not linked to attacks
    if ATTACK_FORM=3
    {
      if hoverMode=1 //Follow player, but hover above them
      {
        myDist=player_sprite_center()
        myDist=round(myDist/40)
        if myDist>5 {myDist=5}
        else if myDist<3 {myDist=3}
        maxSpeed=myDist
        //Seek player
        if x>oPlayer1.x
        {
          if currHspd>-maxSpeed {currHspd-=0.15}
          else {currHspd=-maxSpeed}
        }
        else if x<oPlayer1.x
        {
          if currHspd<maxSpeed {currHspd+=0.15}
          else {currHspd=maxSpeed}
        }
        if y>returnPlayerYCenter()-64
        {
          if currVspd>-maxSpeed {currVspd-=0.15}
          else {currVspd=-maxSpeed}
        }
        else if y<returnPlayerYCenter()-64
        {
          if currVspd<maxSpeed {currVspd+=0.15}
          else {currVspd=maxSpeed}
        }
        //Keep within room
        if x<xCenter-roomSpan+16 {currHspd=3}
        else if x>xCenter+roomSpan-16 {currHspd=-3}
        if y-50<yGround-roomHeight {currVspd=3}
        else if y>yGround-2 {currVspd=-3}

        if sprite_index=sWarmasterC_JetB {x+=xVel/1.5} //Atk 2

        x+=currHspd; y+=currVspd

        if waitTime<waitDelay
        {
          if currVspd<-3.5 {sprite_index=sWarmasterC_HoverB}
          else if currVspd>2.5 {sprite_index=sWarmasterC_HoverC}
          else {sprite_index=sWarmasterC_HoverA}
        }
      }
    }

    if currentAttack=0 //-------------------- Choosing an action --------------------
    {
      if superChangeAtk<10
      {
        waitTime+=1
        if superChangeAtk=0 //Standard action
        {
          if waitTime>=waitDelay
          {
            event_user(6)
          }
        }
        else if superChangeAtk>=1 and superChangeAtk<=9 //Wait till other attacks are done
        {
          if waitTime>=waitDelay+5
          {
            bGravity=1; hoverMode=0
            atkNum=0
            waitTime=waitDelay
            prevShTime=shiftTime; prevShDmg=shiftDamage
            superAtkType=superChangeAtk
            previousForm=ATTACK_FORM
            bCanTakeDamage=0
            sprite_index=sWMA_Change; image_index=ATTACK_FORM-1
            playSound(global.snd_Beam,0,1,18000)
            playSound(global.snd_Charge,0,0.9,24000)
            superChangeAtk=10
          }
        }
      }
      else if superChangeAtk>=10 and superChangeAtk<=99 //Charge super attack
      {
        superChangeAtk+=1
        if superChangeAtk>=11 and superChangeAtk<=20
        {
          var tAfterI;
          tAfterI=instance_create(x,y,oEnemyAfterImage)
          tAfterI.sprite_index=sprite_index; tAfterI.image_index=image_index; tAfterI.image_blend=c_white
          tAfterI.image_xscale=image_xscale*scaleForFacing; tAfterI.image_yscale=image_yscale; tAfterI.depth=24; tAfterI.imageFade=0.1
          tAfterI.xScaling=0.125; tAfterI.yScaling=0.125; tAfterI.xShift=0; tAfterI.yShift=0
          tAfterI.bFollow=1; tAfterI.idFollow=id; tAfterI.xFollow=0; tAfterI.yFollow=0

          var tFFScl,tEffect;
          for(i=0;i<2;i+=1)
          {
            tFFScl=random(0.1)
            tEffect=instance_create(x-random_range(-12,12),y-random(48),oEffectB)
            tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
            tEffect.image_alpha=0.3; tEffect.image_xscale=0.15+tFFScl; tEffect.image_yscale=0.15+tFFScl
            tEffect.direction=random_range(70,110); tEffect.speed=random(1)+1; tEffect.friction=random(0.02)+0.02
            tEffect.fadeSpd=0.01; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
          }
        }

        if superChangeAtk>=30
        {
          bCanTakeDamage=1
          superChangeAtk=100
          if superAtkType=1 //Sequence 1
          {
            ATTACK_FORM=3
            event_user(5)
            currentAttack=8
          }
          else if superAtkType=2 //Sequence 2
          {
            ATTACK_FORM=3
            event_user(5)
            currentAttack=9
          }
        }
      }
    }
    else //-------------------- Executing attack --------------------
    {
      actTime+=1
      event_user(ATTACK_FORM)
    }

    //-------------------- Collision --------------------
    if bGravity=1
    {
      yVel+=0.5
      if yVel>10 {yVel=10}
    }
    if hoverMode=0
    {
      if isCollisionBottom(1) //-------------------- Touch ground --------------------
      {
        if yVel>2
        {
          if sprite_index=sWarmasterA_GroundHit //Form 1, Atk 2
          {
            playSound(global.snd_HardHit1,0,0.97,1)
            playSound(global.snd_HardHit3,0,0.9,17000)
            var tAtk;
            tAtk=instance_create(x+(12*scaleForFacing),y,oWMA_SwordGround)
            tAtk.atkPower=atkPower; tAtk.warTarget=id; tAtk.image_xscale=scaleForFacing*1.5; tAtk.image_yscale=1.5
            if DIFFICULTY=1 {tAtk.type=0}
            else {tAtk.type=1}
            actTime=100
          }
          else if sprite_index=sWarmasterA_SwordRoll //Form 1, Atk 5
          {
            playSound(global.snd_HardHit1,0,0.97,1)
            playSound(global.snd_HardHit3,0,0.9,17000)
            y=yGround
            sprite_index=sWarmasterA_SwingAStrike
            with oWMA_SwordRoll {instance_destroy()}
            var tAtk;
            tAtk=instance_create(x,yGround,oWMA_BombExpWave)
            tAtk.atkPower=atkPower; tAtk.image_xscale=2; tAtk.image_yscale=2
            actTime=100
          }
          else if sprite_index=sWarmasterB_HitGroundB //Form 2, Atk 4
          {
            playSound(global.snd_HardHit1,0,0.97,32000)
            playSound(global.snd_Flame1,0,0.95,34000)
            image_index=1
            var tAtk;
            tAtk=instance_create(x,y,oWMB_FirePillar); tAtk.atkPower=atkPower
            tAtk=instance_create(x+16,y,oWMB_FireWave); tAtk.atkPower=atkPower; tAtk.damageType="EXPLOSION"
            tAtk=instance_create(x-16,y,oWMB_FireWave); tAtk.atkPower=atkPower; tAtk.damageType="EXPLOSION"; tAtk.image_xscale=-1
            actTime=200
          }
          else if sprite_index=sWarmasterC_SpearDown //Form 3, Atk 4
          {
            playSound(global.snd_HardHit1,0,0.97,1)
            playSound(global.snd_HardHit3,0,0.9,17000)
            var tAtk;
            tAtk=instance_create(x+(12*scaleForFacing),y,oWMA_SwordGround)
            tAtk.atkPower=atkPower; tAtk.warTarget=id; tAtk.image_xscale=scaleForFacing*1.5; tAtk.image_yscale=1.5
            tAtk.image_blend=c_blue; tAtk.damageType="ELEMENTAL"
            if DIFFICULTY=1 {tAtk.type=0}
            else {tAtk.type=1}
            actTime=100
          }
          else if sprite_index=sWarmasterD_FastDash //Form 4, Atk 5
          {
            playSound(global.snd_HardHit1,0,0.97,1)
            playSound(global.snd_HardHit3,0,0.9,17000)
            var tAtk;
            tAtk=instance_create(x,yGround,oWMD_TornadoB); tAtk.atkPower=atkPower
            actTime=100
          }
          else
          {
            if ATTACK_FORM=1 {sprite_index=sWarmasterA_Idle}
            else if ATTACK_FORM=2 {sprite_index=sWarmasterB_Idle}
            else if ATTACK_FORM=3 {sprite_index=sWarmasterC_Idle}
            else if ATTACK_FORM=4 {sprite_index=sWarmasterD_Idle}
          }
          xVel=0
        }
        if ATTACK_FORM!=3 {bGoombaStomp=0}
        yVel=0
      }
      if isCollisionTop(1) //-------------------- Touch ceiling --------------------
      {
        if sprite_index=sWarmasterB_ZipUpward //Form 2, Atk 4
        {
          playSound(global.snd_Slam,0,0.88,28000)
          playSound(global.snd_HardHit3,0,0.91,26000)
          sprite_index=sWarmasterB_Hang
          yVel=0
          bGravity=0
          var tAtk,tXFireVel,tXOtherVel;
          tXOtherVel=-2
          if DIFFICULTY=1
          {
            tXFireVel=-4
            for(i=0;i<3;i+=1)
            {
              tAtk=instance_create(x,yGround-roomHeight,oGravPassBullet)
              tAtk.sprite_index=sWarmasterB_AtkFireballB; tAtk.atkPower=atkPower; tAtk.grav=0.3; tAtk.xVel=tXFireVel; tAtk.yVel=3
              tXFireVel+=4
            }
          }
          else
          {
            tXFireVel=-6
            for(i=0;i<5;i+=1)
            {
              tAtk=instance_create(x,yGround-roomHeight,oGravPassBullet)
              tAtk.sprite_index=sWarmasterB_AtkFireballB; tAtk.atkPower=atkPower; tAtk.grav=0.3; tAtk.xVel=tXFireVel; tAtk.yVel=3
              tXFireVel+=3
            }
          }
          for(i=0;i<2;i+=1)
          {
            tAtk=instance_create(x,yGround-roomHeight,oGravPassBullet)
            tAtk.sprite_index=sWarmasterB_AtkFireballB; tAtk.atkPower=atkPower; tAtk.grav=0.25; tAtk.xVel=tXOtherVel; tAtk.yVel=1
            tXOtherVel+=4
          }
          actTime=100
        }
      }
      if sprite_index!=sWarmasterA_WallGrabGun
      {
        if isCollisionLeft(1) //-------------------- Left wall --------------------
        {
          if sprite_index=sWarmasterA_Dashing {xVel=dashAcc}
          else if sprite_index=sWarmasterD_Dashing or sprite_index=sWarmasterD_FastDash {xVel=fastDashJumpAcc}
          else {xVel=runAcc}

          if sprite_index=sWarmasterA_JumpUp and currentAttack=6 //Form 1, Atk 6
          {
            sprite_index=sWarmasterA_WallGrabGun
            xVel=0; yVel=0
            bGravity=0
            actTime=100
          }
          else if sprite_index=sWarmasterB_Dashing //Form 2, Atk 5
          {
            if actTime<=100
            {
              playSound(global.snd_HardHit3,0,0.91,17000)
              xVel=0
              actTime=100
            }
          }
          else {image_xscale=1.25}
        }
        if isCollisionRight(1) //-------------------- Right wall --------------------
        {
          if sprite_index=sWarmasterA_Dashing {xVel=-dashAcc}
          else if sprite_index=sWarmasterD_Dashing or sprite_index=sWarmasterD_FastDash {xVel=-fastDashJumpAcc}
          else {xVel=-runAcc}

          if sprite_index=sWarmasterA_JumpUp and currentAttack=6 //Form 1, Atk 6
          {
            sprite_index=sWarmasterA_WallGrabGun
            xVel=0; yVel=0
            bGravity=0
            actTime=100
          }
          else if sprite_index=sWarmasterB_Dashing //Form 2, Atk 5
          {
            if actTime<=100
            {
              playSound(global.snd_HardHit3,0,0.91,17000)
              xVel=0
              actTime=100
            }
          }
          else {image_xscale=-1.25}
        }
      }
      if isCollisionSolid() {y-=2}
      moveTo(xVel,yVel)
    }

    if backGroundFlash>=1 and backGroundFlash<=99 //Normal background flash
    {
      backGroundFlash+=1
      if backGroundFlash>=2 and backGroundFlash<=24
      {
        if backGroundFlash mod 3=0 {background_blend[0]=make_color_rgb(255,128,128)}
        else {background_blend[0]=c_white}
      }
      else if backGroundFlash>=25 and backGroundFlash<=50
      {
        if backGroundFlash mod 5=0 {background_blend[0]=make_color_rgb(255,128,128)}
        else {background_blend[0]=c_white}
      }
      else if backGroundFlash>=51
      {
        background_blend[0]=c_white
        backGroundFlash=0
      }
    }
    if backGroundFlash>=101 and backGroundFlash<=199 //Gray background flash
    {
      backGroundFlash+=1
      if backGroundFlash>=102 and backGroundFlash<=124
      {
        if backGroundFlash mod 3=0 {background_blend[0]=make_color_rgb(120,120,120)}
        else {background_blend[0]=make_color_rgb(50,50,50)}
      }
      else if backGroundFlash>=125 and backGroundFlash<=150
      {
        if backGroundFlash mod 5=0 {background_blend[0]=make_color_rgb(120,120,120)}
        else {background_blend[0]=make_color_rgb(30,30,30)}
      }
      else if backGroundFlash>=151
      {
        background_blend[0]=make_color_rgb(30,30,30)
        backGroundFlash=0
      }
    }

    //-------------------- Boss Difficulty Curve --------------------
    /*
    --Variable Name: Start value -> End value
    --waitDelay: 60 -> 26
    --atkMax: 2 -> 3
    --orbitNum: 6 -> 10
    --ATTACK_SPEED: 1 -> 3
    --DIFFICULTY: 1 -> 3
    */

    if lifePercent<=0.9 and lifePercent>=0.81 and bossProgress=0
    {
      waitDelay-=3
      bossProgress+=1
    }
    else if lifePercent<=0.8 and lifePercent>=0.71 and bossProgress=1
    {
      waitDelay-=3
      orbitNum+=1
      bChangeSpeed=1
      bossProgress+=1
    }
    else if lifePercent<=0.7 and lifePercent>=0.61 and bossProgress=2
    {
      waitDelay-=4
      bChangeDifficulty=1
      shiftType=1
      superChangeAtk=1
      bossProgress+=1
    }
    else if lifePercent<=0.6 and lifePercent>=0.51 and bossProgress=3
    {
      waitDelay-=3
      orbitNum+=1
      atkMax+=1
      bossProgress+=1
    }
    else if lifePercent<=0.5 and lifePercent>=0.41 and bossProgress=4
    {
      waitDelay-=3
      bChangeSpeed=1
      bossProgress+=1
    }
    else if lifePercent<=0.4 and lifePercent>=0.31 and bossProgress=5
    {
      waitDelay-=4
      orbitNum+=1
      bossProgress+=1
    }
    else if lifePercent<=0.3 and lifePercent>=0.21 and bossProgress=6
    {
      waitDelay-=3
      shiftType=2
      bChangeDifficulty=1
      superChangeAtk=2
      bossProgress+=1
    }
    else if lifePercent<=0.2 and lifePercent>=0.11 and bossProgress=7
    {
      waitDelay-=8
      orbitNum+=1
      bossProgress+=1
    }
    else if lifePercent<=0.1 and lifePercent>=0 and bossProgress=8
    {
      waitDelay-=3
      bossProgress+=1
    }
  }
  enemyStepEvent()
}

if life<=0 //-------------------- Defeat animation --------------------
{
  deathAnim+=1
  if deathAnim=1
  {
    oWM_A.warmasterCheck+=1
  }
  y=-64
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

if ATTACK_FORM!=3
{
  if bGoombaStomp=1 and superChangeAtk=0 //Achievement
  {
    var tCheckAchieve;
    tCheckAchieve=string_char_at(global.tokenRecognitions,45)
    if tCheckAchieve="0"
    {
      var tAchievement;
      tAchievement=instance_create(0,0,oAchievementNotice)
      tAchievement.myAchievement="Goomba Stomped"; tAchievement.checkNum=45
    }
    bGoombaStomp=0
  }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///END ATTACK
if ATTACK_FORM=1 {sprite_index=sWarmasterA_Idle}
else if ATTACK_FORM=2 {sprite_index=sWarmasterB_Idle}
else if ATTACK_FORM=3 {sprite_index=sWarmasterC_Idle}
else if ATTACK_FORM=4 {sprite_index=sWarmasterD_Idle}
actTime=0
previousAtk=currentAttack
currentAttack=0

//Check for behavior changes
if bChangeSpeed=1
{
  ATTACK_SPEED+=1
  bChangeSpeed=0
}
if bChangeDifficulty=1
{
  DIFFICULTY+=1
  fireFreq=4 //5 -> 4
  fireDuration+=10 //170 -> 190
  bChangeDifficulty=0
}
if superCharge<superMax {superCharge+=1}

//Increment attack cycle
atkNum+=1
if atkNum=1 {waitTime=waitDelay-9}
else if atkNum>=2 {waitTime=waitDelay-7}
numOfAtks+=1

if superChangeAtk=1 //Super change attack check
{
  bGravity=1; hoverMode=0
  atkNum=0
  waitTime=0
}
else if superChangeAtk>=10 //End super attack
{
  shiftTime=prevShTime; shiftDamage=prevShDmg
  ATTACK_FORM=previousForm
  event_user(5)
  superCharge=2
  superChangeAtk=0; superAtkType=0
  waitTime=-10
}

if atkNum>=atkMax
{
  atkInSequence+=1
  if atkInSequence>=4 {atkInSequence=0} //0 - 3
  waitTime=0; atkNum=0
}
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///MAIN FORM
if currentAttack=1 //==================== ATK A: SWORD SWING 1 - (Leads into Atk B) ====================
{
  if actTime=1
  {
    sprite_index=sWarmasterA_SwingAReady; image_index=0
    if ATTACK_SPEED>=2 {actTime=2}
  }
  else if actTime=4
  {
    image_index=1
    if ATTACK_SPEED>=3 {actTime=5}
  }
  else if actTime=7
  {
    image_index=2
    if ATTACK_SPEED>=3 {actTime=8}
  }
  else if actTime=13 //Strike
  {
    playSound(global.snd_DeathSlash,0,1,28500)
    sprite_index=sWarmasterA_SwingAStrike; image_index=0
    var tAtk;
    tAtk=instance_create(x,y,oWMA_SwordSlash)
    tAtk.atkPower=atkPower; tAtk.image_xscale=image_xscale; tAtk.image_yscale=image_yscale

    tAtk=instance_create(x+(12*scaleForFacing),y-30,oWMA_SwordWave)
    tAtk.atkPower=atkPower; tAtk.warTarget=id
    if image_xscale<0 {tAtk.direction=180; tAtk.image_angle=180}
    if DIFFICULTY=1 {tAtk.moveSpd=5} else {tAtk.moveSpd=10}
    if ATTACK_SPEED>=2 {actTime=14}
  }
  else if actTime=17 {image_index=1}
  else if actTime=19 {image_index=2}
  else if actTime=21
  {
    image_index=3
    with oWMA_SwordSlash {instance_destroy()}
    if ATTACK_SPEED=2 {actTime=22}
    else if ATTACK_SPEED>=3 {actTime=23}
  }
  else if actTime>=28
  {
    actTime=0
    currentAttack=2
  }
}
else if currentAttack=2 //==================== ATK B: SWORD SWING 2 ====================
{
  if actTime=1
  {
    if x<oPlayer1.x {image_xscale=1.25; scaleForFacing=1}
    else {image_xscale=-1.25; scaleForFacing=-1}
    sprite_index=sWarmasterA_SwingBReady; image_index=0
    if ATTACK_SPEED>=2 {actTime=2}
  }
  else if actTime=4
  {
    image_index=1
    if ATTACK_SPEED>=2 {actTime=5}
  }
  else if actTime=9 //Strike
  {
    playSound(global.snd_DeathSlash,0,1,30500)
    sprite_index=sWarmasterA_SwingBStrike; image_index=0
    var tAtk,tWaveDir;
    tWaveDir=point_direction(x+(12*scaleForFacing),y-30,oPlayer1.x,returnPlayerYCenter())
    tAtk=instance_create(x,y,oWMA_SwordSlash)
    tAtk.atkPower=atkPower; tAtk.image_xscale=image_xscale; tAtk.image_yscale=image_yscale; tAtk.sprite_index=sWarmasterA_AtkB

    if scaleForFacing=1 //Keep sword wave from going behind
    {
      if tWaveDir>90 and tWaveDir<270 {tWaveDir+=180}
    }
    else
    {
      if tWaveDir>90 and tWaveDir<270 {}
      else {tWaveDir+=180}
    }

    tAtk=instance_create(x+(12*scaleForFacing),y-30,oWMA_SwordWave)
    tAtk.atkPower=atkPower; tAtk.direction=tWaveDir; tAtk.image_angle=tWaveDir; tAtk.warTarget=id
    if DIFFICULTY=1 {tAtk.moveSpd=5} else {tAtk.moveSpd=10}
    if ATTACK_SPEED>=2 {actTime=11}
  }
  else if actTime=17
  {
    image_index=1
    with oWMA_SwordSlash {instance_destroy()}
    if ATTACK_SPEED=2 {actTime=18}
    else if ATTACK_SPEED>=3 {actTime=19}
  }
  else if actTime>=24
  {
    event_user(0)
  }
}
else if currentAttack=3 //==================== ATK C: DASH + JUMP SLASH ====================
{
  if actTime=1
  {
    sprite_index=sWarmasterA_DashReady; image_index=0
    if ATTACK_SPEED=2 {actTime=2}
    else if ATTACK_SPEED>=3 {actTime=3}
  }
  else if actTime=10 //Dash
  {
    playSound(global.snd_ChargeStrike,0,0.92,32000)
    sprite_index=sWarmasterA_Dashing
    xVel=dashAcc*scaleForFacing
  }
  else if actTime=22 //Jump
  {
    sprite_index=sWarmasterA_JumpUp
    xVel=dashJumpAcc*scaleForFacing
    y-=2; yVel=-12
  }
  else if actTime=37 //Stop midair
  {
    bGravity=0
    xVel=0; yVel=0
    if x<oPlayer1.x {image_xscale=1.25; scaleForFacing=1}
    else {image_xscale=-1.25; scaleForFacing=-1}
    sprite_index=sWarmasterA_AirSwingA
    if ATTACK_SPEED>=2 {actTime=39}
  }
  else if actTime=47 //Strike down fast
  {
    sprite_index=sWarmasterA_GroundHit
    bGravity=1
    bGoombaStomp=0
    xVel=2*scaleForFacing
    yVel=8
  }
  else if actTime>=106
  {
    event_user(0)
  }
}
else if currentAttack=4 //==================== ATK D: ROPE AND BOMB (Goes into Atk E) ====================
{
  if actTime=1
  {
    sprite_index=sWarmasterA_Kneel; image_index=0
    if ATTACK_SPEED=2 {actTime=2}
    else if ATTACK_SPEED>=3 {actTime=3}
  }
  else if actTime=8 //Place bomb
  {
    tAtk=instance_create(x,y-7,oWMA_GroundBomb)
    tAtk.atkPower=atkPower; tAtk.warTarget=id
  }
  else if actTime=10 //Spawn rope
  {
    sprite_index=sWarmasterA_GrabKneel
    bRope=1; ropeX=x-(10*image_xscale); ropeYscl=0
    if ATTACK_SPEED>=3 {actTime=13}
  }
  else if actTime=20
  {
    sprite_index=sWarmasterA_GrappleRopeA
    if ATTACK_SPEED>=2 {actTime=21}
  }
  else if actTime=26 //Jump up
  {
    sprite_index=sWarmasterA_JumpUp
    y-=2; yVel=-12
  }
  else if actTime>=27 and actTime<=99 //Grab rope
  {
    if y<=yGround-160+sprite_height-6
    {
      bGravity=0
      sprite_index=sWarmasterA_GrappleRopeB
      if ATTACK_SPEED=2 {actTime=103}
      else if ATTACK_SPEED>=3 {actTime=106}
      else {actTime=100}
    }
  }
  else if actTime>=120
  {
    actTime=0
    currentAttack=5
  }

  if actTime>=11 and actTime<=20
  {
    if ATTACK_SPEED>=3 {ropeYscl+=0.2}
    else {ropeYscl+=0.1}
  }
}
else if currentAttack=5 //==================== ATK E: SWORD ROLL ====================
{
  if actTime=1
  {
    sprite_index=sWarmasterA_SwordRoll; image_index=0
    var tAtk;
    tAtk=instance_create(x,y,oWMA_SwordRoll); tAtk.atkPower=atkPower; tAtk.warTarget=id
    bGravity=1
    var xRollDist;
    xRollDist=point_distance(x,0,oPlayer1.x,0)/20
    if xRollDist>14 {xRollDist=14}
    else if xRollDist<0.75 {xRollDist=0.75}
    if x<oPlayer1.x {xVel=xRollDist; image_xscale=1.25; scaleForFacing=1}
    else {xVel=-xRollDist; image_xscale=-1.25; scaleForFacing=-1}
    yVel=3
  }
  else if actTime=102 {image_index=1}
  else if actTime=104 {image_index=2}
  else if actTime=106 {image_index=3}
  else if actTime>=108
  {
    ropeYscl=0; bRope=0
    if superAtkType=1
    {
      actTime=0
      ATTACK_FORM=4
      event_user(5)
      currentAttack=3
    }
    else if superAtkType=2
    {
      actTime=0
      ATTACK_FORM=2
      event_user(5)
      currentAttack=2
    }
    else {event_user(0)}
  }

  if ropeYscl>0 {ropeYscl-=0.1}
}
else if currentAttack=6 //==================== ATK F: BIG LEAP TOWARD WALL + LEAP OFF WALL (Needs charge) ====================
{
  if actTime=1
  {
    tEffect=instance_create(x,y-20,oEffectB)
    tEffect.type=1; tEffect.sprite_index=sWarSpellWave; tEffect.image_alpha=0.8; tEffect.fadeSpd=0; tEffect.image_speed=0.75
    tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=1; tEffect.followID=-1; tEffect.rotation=0; tEffect.image_alpha=0.66
    for(i=0;i<8;i+=1)
    {
      tEffect=instance_create(x+random_range(-16,16),y-random(4),oEffectB)
      tEffect.type=3; tEffect.sprite_index=sMMchargeEffect1; tEffect.image_alpha=0.8
      tEffect.direction=90; tEffect.image_angle=90; tEffect.friction=0.05; tEffect.image_xscale=2; tEffect.image_yscale=2
      tEffect.speed=1+random(2); tEffect.fadeSpd=0.02; tEffect.image_blend=make_color_rgb(190,10,190)
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
    }
    sprite_index=sWarmasterA_BigLeapReady; image_index=0
    if ATTACK_SPEED=2 {actTime=5}
    else if ATTACK_SPEED>=3 {actTime=10}
  }
  else if actTime=18 //Jump toward wall
  {
    playSound(global.snd_ChargeStrike,0,0.92,32000)
    if x<xCenter {image_xscale=-1.25; scaleForFacing=-1}
    else {image_xscale=1.25; scaleForFacing=1}
    sprite_index=sWarmasterA_JumpUp
    xVel=fastDashJumpAcc*scaleForFacing
    y-=2; yVel=-12
  }
  else if actTime=108 //Fire shot
  {
    playSound(global.snd_SpearShot,0,0.98,28000)
    var tNewAttack,tShotDir;
    tShotDir=point_direction(x-(28*image_xscale),y-20,oPlayer1.x,returnPlayerYCenter())
    if DIFFICULTY=1
    {
      tNewAttack=instance_create(x-(28*image_xscale),y-20,oPassBullet)
      tNewAttack.sprite_index=sWarmasterA_ShotA; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=11
      tNewAttack.image_speed=0.33; tNewAttack.decayTime=-100; tNewAttack.direction=tShotDir; tNewAttack.image_angle=tShotDir
    }
    else
    {
      tShotDir-=10
      for(i=0;i<3;i+=1)
      {
        tNewAttack=instance_create(x-(28*image_xscale),y-20,oPassBullet)
        tNewAttack.sprite_index=sWarmasterA_ShotA; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=11
        tNewAttack.image_speed=0.33; tNewAttack.decayTime=-100; tNewAttack.direction=tShotDir; tNewAttack.image_angle=tShotDir
        tShotDir+=10
      }
    }
    if ATTACK_SPEED>=2 {actTime=111}
  }
  else if actTime=116 //Jump off wall
  {
    bGravity=1
    if x<xCenter {x+=2; xVel=fastDashJumpAcc}
    else {x-=2; xVel=-fastDashJumpAcc}
    yVel=-4
    sprite_index=sWarmasterA_JumpUp
  }
  else if actTime=132 //Stop midair
  {
    bGravity=0
    xVel=0; yVel=0
    if x<oPlayer1.x {image_xscale=1.25; scaleForFacing=1}
    else {image_xscale=-1.25; scaleForFacing=-1}
    sprite_index=sWarmasterA_MidairCall
    var tEffect;
    tEffect=instance_create(x+(17*image_xscale),y-(27*image_yscale),oEffect)
    tEffect.sprite_index=sCWM_Ef_AtkPulse; tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    if ATTACK_SPEED>=2 {actTime=134}
  }
  else if actTime=137 //Spear shots down
  {
    playSound(global.snd_SpearShot,0,1,19000)
    var tNewAttack;
    for(i=0;i<8;i+=1)
    {
      tNewAttack=instance_create(200+(48*i),0,oPassBullet)
      tNewAttack.sprite_index=sWarmasterA_ShotB; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=12
      tNewAttack.decayTime=-100; tNewAttack.image_speed=0.33; tNewAttack.direction=270; tNewAttack.image_angle=270
    }
    tNewAttack=instance_create(168,0,oPassBullet)
    tNewAttack.sprite_index=sWarmasterA_ShotB; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=12
    tNewAttack.decayTime=-100; tNewAttack.image_speed=0.33; tNewAttack.direction=270; tNewAttack.image_angle=270
    tNewAttack=instance_create(568,0,oPassBullet)
    tNewAttack.sprite_index=sWarmasterA_ShotB; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=12
    tNewAttack.decayTime=-100; tNewAttack.image_speed=0.33; tNewAttack.direction=270; tNewAttack.image_angle=270

    tNewAttack=instance_create(oPlayer1.x,0,oPassBullet)
    with tNewAttack
    {
      sprite_index=sWarmasterA_ShotB; atkPower=oCHAOS_Warmaster_Fixed.atkPower; bulletSpeed=12
      decayTime=-100; image_speed=0.33; direction=270; tNewAttack.image_angle=270
      move_snap(8,1)
    }
    if ATTACK_SPEED=2 {actTime=139}
    else if ATTACK_SPEED>=3 {actTime=140}
  }
  else if actTime=143
  {
    sprite_index=sWarmasterA_JumpDown
    yVel=4
    bGravity=1
  }
  else if actTime>=150
  {
    event_user(0)
  }
}
#define Other_12
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///FIRE FORM
if currentAttack=1 //==================== ATK A: HIT GROUND AND CAUSE FLAME PILLARS ====================
{
  if actTime=1
  {
    sprite_index=sWarmasterB_HitGroundA; image_index=0
    if ATTACK_SPEED>=2 {actTime=2}
  }
  else if actTime=5
  {
    image_index=1
    if ATTACK_SPEED=2 {actTime=6}
    else if ATTACK_SPEED>=3 {actTime=7}
  }
  else if actTime=13 {sprite_index=sWarmasterB_HitGroundB; image_index=0}
  else if actTime=15 //Strike
  {
    playSound(global.snd_HardHit1,0,0.95,29000)
    playSound(global.snd_Flame1,0,0.97,31000)
    image_index=1
    var tAtk;
    tAtk=instance_create(x+44,y,oWMB_FirePillar); tAtk.atkPower=atkPower
    tAtk=instance_create(x-44,y,oWMB_FirePillar); tAtk.atkPower=atkPower
    tAtk=instance_create(x+16,y,oWMB_FireWave); tAtk.atkPower=atkPower; tAtk.damageType="EXPLOSION"
    tAtk=instance_create(x-16,y,oWMB_FireWave); tAtk.atkPower=atkPower; tAtk.damageType="EXPLOSION"; tAtk.image_xscale=-1
  }
  else if actTime=17 {image_index=2}
  else if actTime=19 {image_index=3}
  else if actTime=21
  {
    image_index=4
    if ATTACK_SPEED>=2 {actTime=22}
  }
  else if actTime=24 {sprite_index=sWarmasterB_HitGroundC; image_index=0}
  else if actTime=26 {image_index=1}
  else if actTime>=29
  {
    event_user(0)
  }
}
else if currentAttack=2 //==================== ATK B: FIRE SPAM (Needs charge) ====================
{
  if actTime=1
  {
    tEffect=instance_create(x,y-20,oEffectB)
    tEffect.type=1; tEffect.sprite_index=sWarSpellWave; tEffect.image_alpha=0.8; tEffect.fadeSpd=0; tEffect.image_speed=0.75
    tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=1; tEffect.followID=-1; tEffect.rotation=0; tEffect.image_alpha=0.66
    for(i=0;i<8;i+=1)
    {
      tEffect=instance_create(x+random_range(-16,16),y-random(4),oEffectB)
      tEffect.type=3; tEffect.sprite_index=sMMchargeEffect1; tEffect.image_alpha=0.8
      tEffect.direction=90; tEffect.image_angle=90; tEffect.friction=0.05; tEffect.image_xscale=2; tEffect.image_yscale=2
      tEffect.speed=1+random(2); tEffect.fadeSpd=0.02; tEffect.image_blend=make_color_rgb(190,50,10)
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
    }
    if x<xCenter {image_xscale=1.25; scaleForFacing=1}
    else {image_xscale=-1.25; scaleForFacing=-1}
    sprite_index=sWarmasterB_DashReady; image_index=0
    if ATTACK_SPEED=2 {actTime=2}
    else if ATTACK_SPEED>=3 {actTime=3}
  }
  else if actTime=11 {sprite_index=sWarmasterB_Dashing}
  else if actTime>=12 and actTime<=99 //Dash to center
  {
    x+=8*scaleForFacing
    var tXcenterCheck;
    tXcenterCheck=point_distance(x,0,xCenter,0)
    if tXcenterCheck<=32 {actTime=100}
  }
  else if actTime=101 //Ready the spam animation
  {
    sprite_index=sWarmasterB_FireSpamA; image_index=0
    if ATTACK_SPEED>=2 {actTime=102}
  }
  else if actTime=105
  {
    instance_create(x-24,yGround,oWarmasterB_MoltenRock)
    instance_create(x+24,yGround,oWarmasterB_MoltenRock)
    image_index=1
    if ATTACK_SPEED=2 {actTime=106}
    else if ATTACK_SPEED>=3 {actTime=107}
  }
  else if actTime=112 {sprite_index=sWarmasterB_FireSpamB; image_index=0; image_speed=0.25}
  else if actTime=fireDuration+1
  {
    with oWarmasterB_MoltenRock {instance_destroy()}
    sprite_index=sWarmasterB_FireSpamA; image_index=1; image_speed=0
  }
  else if actTime=fireDuration+3 {sprite_index=sWarmasterB_FireSpamA; image_index=1}
  else if actTime>=fireDuration+5
  {
    event_user(0)
  }

  if actTime>=114 and actTime<=fireDuration and actTime mod fireFreq=0 //Shoot fireballs
  {
    playSound(global.snd_Fireball,0,0.98,28000)
    var tAtk;
    tAtk=instance_create(x+(10*fireSide),y-52,oWMB_Fireball)
    tAtk.atkPower=atkPower; tAtk.type=fireType; tAtk.warTarget=id
    if fireType=0 //Curve
    {
      tAtk.bulletSpeed=3.5; tAtk.direction=90; tAtk.image_angle=90
      tAtk.turnDir=(firePlacement[fireUse]/7)*fireSide
      fireType=1
    }
    else if fireType=1 //Stop then aim
    {
      tAtk.image_blend=c_yellow; tAtk.bulletSpeed=5
      tAtk.direction=90+(firePlacement[fireUse]*fireSide); tAtk.image_angle=90+(firePlacement[fireUse]*fireSide)
      tAtk.stopY=yGround-160-(fireUse*10)
      fireUse+=1
      if fireUse=3 {fireUse=0}
      fireType=2
    }
    else if fireType=2 //Up then down
    {
      tAtk.image_blend=c_orange; tAtk.bulletSpeed=12
      tAtk.direction=90+(3*fireSide); tAtk.image_angle=90+(3*fireSide)
      tAtk.xFall=x+(32*fireSide)
      fireType=0
    }

    if fireSide=1 {fireSide=-1}
    else {fireSide=1}
  }
}
else if currentAttack=3 //==================== ATK C: FIREBALL ====================
{
  if actTime=1
  {
    sprite_index=sWarmasterB_ArmUpFireA; image_index=3
    if ATTACK_SPEED=2 {actTime=2}
    else if ATTACK_SPEED>=3 {actTime=3}
  }
  else if actTime=11 //Shoot fireball
  {
    playSound(global.snd_Fireball,0,0.98,24000)
    image_index=0
    var tAtk,tFireDir;
    if scaleForFacing=1 {tFireDir=0}
    else {tFireDir=180}
    tAtk=instance_create(x+(30*scaleForFacing),y-32,oPassBullet)
    tAtk.sprite_index=sWarmasterB_AtkFireballA; tAtk.atkPower=atkPower; tAtk.bulletSpeed=9
    tAtk.decayTime=-100; tAtk.damageType="EXPLOSION"; tAtk.image_speed=0.33; tAtk.direction=tFireDir; tAtk.image_angle=tFireDir
    if DIFFICULTY>=2
    {
      tAtk=instance_create(x+(30*scaleForFacing),y-32,oPassBullet)
      tAtk.sprite_index=sWarmasterB_AtkFireballA; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3
      tAtk.decayTime=-100; tAtk.damageType="EXPLOSION"; tAtk.image_speed=0.33; tAtk.direction=tFireDir; tAtk.image_angle=tFireDir
    }
  }
  else if actTime=13 {image_index=1}
  else if actTime=15 {image_index=2}
  else if actTime>=17
  {
    event_user(0)
  }
}
else if currentAttack=4 //==================== ATK D: ZIP UP + HANG + DIVE ====================
{
  if actTime=1
  {
    sprite_index=sWarmasterB_Kneel; image_index=0
    if ATTACK_SPEED=2 {actTime=3}
    else if ATTACK_SPEED>=2 {actTime=5}
  }
  else if actTime=14 //Jump up
  {
    sprite_index=sWarmasterB_ZipUpward
    y-=2; yVel=-20
  }
  else if actTime=110
  {
    sprite_index=sWarmasterB_HitGroundB; image_index=0
    var xRollDist;
    xRollDist=point_distance(x,0,oPlayer1.x,0)/20
    if xRollDist>14 {xRollDist=14}
    else if xRollDist<0.75 {xRollDist=0.75}
    if x<oPlayer1.x {xVel=xRollDist; image_xscale=1.25; scaleForFacing=1}
    else {xVel=-xRollDist; image_xscale=-1.25; scaleForFacing=-1}
    y+=2; yVel=4
    bGravity=1
  }
  else if actTime=202 {image_index=2}
  else if actTime=204 {image_index=3}
  else if actTime=206 {image_index=4}
  else if actTime=209 {sprite_index=sWarmasterB_HitGroundC; image_index=0}
  else if actTime=211
  {
    image_index=1
    if ATTACK_SPEED>=2 {actTime=212}
  }
  else if actTime>=214
  {
    event_user(0)
  }
}
else if currentAttack=5 //==================== ATK E: DASH ACROSS MAP (Fire Pillars) + JUMP OFF WALL ====================
{
  if actTime=1
  {
    if x<oPlayer1.x {image_xscale=1.25; scaleForFacing=1}
    else {image_xscale=-1.25; scaleForFacing=-1}
    sprite_index=sWarmasterB_DashReady; image_index=0
    if ATTACK_SPEED=2 {actTime=2}
    else if ATTACK_SPEED>=2 {actTime=3}
  }
  else if actTime>=2 and actTime<=14 {sprite_index=sWarmasterB_DashReady; image_index=0}
  else if actTime=15 //Fast Dash
  {
    playSound(global.snd_ChargeStrike,0,0.94,39000)
    sprite_index=sWarmasterB_Dashing
    xVel=superFireDashAcc*scaleForFacing
  }
  else if actTime=101 //Jump back
  {
    sprite_index=sWarmasterB_JumpBack
    if x<xCenter {x+=4; xVel=2}
    else {x-=4; xVel=-2}
    y-=2; yVel=-4
    if ATTACK_SPEED=2 {actTime=102}
    else if ATTACK_SPEED>=3 {actTime=104}
  }
  else if actTime>=120
  {
    if superAtkType=2
    {
      actTime=0
      ATTACK_FORM=4
      event_user(5)
      currentAttack=9
    }
    else {event_user(0)}
  }
}
else if currentAttack=6 //==================== ATK F: SHORT HOP + AIMED FIREBALL ====================
{
  if actTime=1
  {
    sprite_index=sWarmasterB_JumpReady; image_index=0
    if ATTACK_SPEED=2 {actTime=2}
    else if ATTACK_SPEED>=3 {actTime=3}
  }
  else if actTime=7 //Jump up
  {
    sprite_index=sWarmasterB_JumpUp
    y-=2; yVel=-7
  }
  else if actTime=15 //Shoot fireball
  {
    playSound(global.snd_Fireball,0,0.98,24000)
    sprite_index=sWarmasterB_JumpFire
    var tAtk,tFireDir;
    tFireDir=point_direction(x+(21*image_xscale),y-(24*image_yscale),oPlayer1.x,returnPlayerYCenter())
    tAtk=instance_create(x+(21*image_xscale),y-(24*image_yscale),oPassBullet)
    tAtk.sprite_index=sWarmasterB_AtkFireballA; tAtk.atkPower=atkPower; tAtk.bulletSpeed=10
    tAtk.decayTime=-100; tAtk.damageType="EXPLOSION"; tAtk.image_speed=0.33; tAtk.direction=tFireDir; tAtk.image_angle=tFireDir
    if DIFFICULTY>=2
    {
      tAtk=instance_create(x+(21*image_xscale),y-(24*image_yscale),oPassBullet)
      tAtk.sprite_index=sWarmasterB_AtkFireballA; tAtk.atkPower=atkPower; tAtk.bulletSpeed=2
      tAtk.decayTime=-100; tAtk.damageType="EXPLOSION"; tAtk.image_speed=0.33; tAtk.direction=tFireDir; tAtk.image_angle=tFireDir
    }
    if ATTACK_SPEED>=2 {yVel=1}
  }
  else if actTime=17 {image_index=1}
  else if actTime=19
  {
    image_index=2
    if ATTACK_SPEED>=2 {actTime=21}
  }
  else if actTime>=23
  {
    event_user(0)
  }
}
#define Other_13
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///ICE FORM
if currentAttack=1 //==================== ATK A: SUMMON ORBITING ICE (Needs charge) ====================
{
  if actTime=1
  {
    tEffect=instance_create(x,y-20,oEffectB)
    tEffect.type=1; tEffect.sprite_index=sWarSpellWave; tEffect.image_alpha=0.8; tEffect.fadeSpd=0; tEffect.image_speed=0.75
    tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=1; tEffect.followID=-1; tEffect.rotation=0; tEffect.image_alpha=0.66
    for(i=0;i<8;i+=1)
    {
      tEffect=instance_create(x+random_range(-16,16),y-random(4),oEffectB)
      tEffect.type=3; tEffect.sprite_index=sMMchargeEffect1; tEffect.image_alpha=0.8
      tEffect.direction=90; tEffect.image_angle=90; tEffect.friction=0.05; tEffect.image_xscale=2; tEffect.image_yscale=2
      tEffect.speed=1+random(2); tEffect.fadeSpd=0.02; tEffect.image_blend=make_color_rgb(10,140,190)
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
    }
    sprite_index=sWarmasterC_ShootIceStand; image_index=0
    if ATTACK_SPEED=2 {actTime=2}
    else if ATTACK_SPEED>=3 {actTime=4}
  }
  else if actTime=15 //Summon ice
  {
    sprite_index=sWarmasterC_HoverA
    var tAtk,tAngDiff;
    tAngDiff=360/orbitNum
    for(i=0;i<orbitNum;i+=1)
    {
      tAtk=instance_create(x,y-26,oWMC_IceHoverA)
      tAtk.atkPower=atkPower; tAtk.warTarget=id; tAtk.myDist=2; tAtk.myDir=i*tAngDiff; tAtk.fireDelay=30+(i*15)
    }
    if ATTACK_SPEED=2 {actTime=17}
    else if ATTACK_SPEED>=3 {actTime=18}
  }
  else if actTime>=25
  {
    event_user(0)
  }
}
else if currentAttack=2 //==================== ATK B: DASH ACROSS ROOM AND SHOOT ICE SHOTS DOWN (Hover mode only) ====================
{
  if actTime=1
  {
    sprite_index=sWarmasterC_JetA; image_index=0
    if ATTACK_SPEED=2 {actTime=2}
    else if ATTACK_SPEED>=3 {actTime=3}
  }
  else if actTime=13 //Jet start
  {
    playSound(global.snd_ChargeStrike,0,0.93,24000)
    sprite_index=sWarmasterC_JetB
    if x<xCenter {xVel=8; image_xscale=1.25; scaleForFacing=1}
    else {xVel=-8; image_xscale=-1.25; scaleForFacing=-1}
  }
  else if actTime>=14 and actTime<=99
  {
    if actTime mod 7=0
    {
      playSound(global.snd_IceShot,0,0.95,27000)
      var tAtk;
      tAtk=instance_create(x,y,oWMC_IceShotA)
      tAtk.sprite_index=sWarmasterC_IceShot; tAtk.atkPower=atkPower; tAtk.moveSpd=6; tAtk.type=0; tAtk.warTarget=id
      tAtk.decayTime=-100; tAtk.damageType="ELEMENTAL"; tAtk.direction=270; tAtk.image_angle=270
    }

    if (xVel>0 and x>=xCenter+roomSpan-20) or (xVel<0 and x<=xCenter-roomSpan+20)
    {
      xVel=0
      actTime=100
      sprite_index=sWarmasterC_HoverA
    }
  }
  else if actTime>=105
  {
    hoverMode=1; numOfAtks=0
    event_user(0)
  }
}
else if currentAttack=3 //==================== ATK C: JUMP (Ground mode only) (Leads into Atk D (Dive)) ====================
{
  if actTime=1 //Jump
  {
    sprite_index=sWarmasterC_SpearJump
    xVel=dashJumpAcc*scaleForFacing
    y-=2
    yVel=-12
    if ATTACK_SPEED=2 {actTime=2}
    else if ATTACK_SPEED>=3 {actTime=3}
  }
  else if actTime=17 //Lead into Dive
  {
    actTime=0
    currentAttack=4
  }
}
else if currentAttack=4 //==================== ATK D: DIVE (Ends hover mode) ====================
{
  if actTime=1
  {
    sprite_index=sWarmasterC_SpearDown
    bGravity=0; hoverMode=0; numOfAtks=0
    xVel=0; yVel=0
    if ATTACK_SPEED>=3 {actTime=2}
  }
  else if actTime=9 //Dive down fast
  {
    if x<oPlayer1.x {image_xscale=1.25; scaleForFacing=1}
    else {image_xscale=-1.25; scaleForFacing=-1}
    xVel=3*scaleForFacing
    yVel=8
    bGravity=1
  }
  else if actTime>=106
  {
    event_user(0)
  }
}
else if currentAttack=5 //==================== ATK E: SPEAR SWIRL ====================
{
  if actTime=1
  {
    sprite_index=sWarmasterC_SpearHover
    var tEffect;
    tEffect=instance_create(x,y-(27*image_yscale),oEffect)
    tEffect.sprite_index=sCWM_Ef_AtkPulse; tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    if ATTACK_SPEED>=2 {actTime=3}
  }
  else if actTime=12 //Summon spear
  {
    playSound(global.snd_LightballSpread,0,0.96,18000)
    playSound(global.snd_SpearShot,0,0.9,1)
    sprite_index=sWarmasterC_SpearSwirl
    var tAtk;
    tAtk=instance_create(x,y-27,oWMC_SpearSwirl)
    tAtk.atkPower=atkPower; tAtk.warTarget=id
  }
  else if actTime=20 //Summon spiral projectiles
  {
    var tAtk,tIceDir;
    tIceDir=0
    for(i=0;i<orbitNum;i+=1)
    {
      tAtk=instance_create(x,y-27,oPassArcBullet)
      tAtk.sprite_index=sSeraAtkIceC; tAtk.image_xscale=0.75; tAtk.image_yscale=0.75; tAtk.decayTime=-100; tAtk.atkPower=atkPower
      tAtk.bulletSpeed=5; tAtk.arcAmt=7; tAtk.falloff=0.125; tAtk.direction=tIceDir; tAtk.image_angle=tIceDir; tAtk.damageType="ELEMENTAL"
      tAtk=instance_create(x,y-27,oPassArcBullet)
      tAtk.sprite_index=sSeraAtkIceC; tAtk.image_xscale=0.75; tAtk.image_yscale=0.75; tAtk.decayTime=-100; tAtk.atkPower=atkPower
      tAtk.bulletSpeed=5; tAtk.arcAmt=-7; tAtk.falloff=0.125; tAtk.direction=tIceDir; tAtk.image_angle=tIceDir; tAtk.damageType="ELEMENTAL"
      tIceDir+=360/orbitNum
    }
  }
  else if actTime=25 //Send spear toward player
  {
    oWMC_SpearSwirl.atkProg=1
    if ATTACK_SPEED>=3 {actTime=26}
  }
  else if actTime>=30
  {
    event_user(0)
  }
}
else if currentAttack=6 //==================== ATK F: ICE SHOT TO PLAYER ====================
{
  if actTime=1
  {
    if hoverMode=0 {sprite_index=sWarmasterC_ShootIceStand}
    else if hoverMode=1 {sprite_index=sWarmasterC_ShootIceHover}
    if ATTACK_SPEED=2 {actTime=2}
    else if ATTACK_SPEED>=3 {actTime=3}
  }
  else if actTime=13
  {
    playSound(global.snd_SpearShot,0,1,27000)
    var tAtk,tIceDir;
    tIceDir=point_direction(x+(17*image_xscale),y-(28*image_yscale),oPlayer1.x,returnPlayerYCenter())
    if DIFFICULTY=1
    {
      tAtk=instance_create(x+(17*image_xscale),y-(28*image_yscale),oPassBullet)
      tAtk.sprite_index=sWarmasterC_IceShard; tAtk.atkPower=atkPower; tAtk.bulletSpeed=9
      tAtk.decayTime=-100; tAtk.damageType="ELEMENTAL"; tAtk.direction=tIceDir; tAtk.image_angle=tIceDir
    }
    else
    {
      tIceDir-=2
      for(i=0;i<2;i+=1)
      {
        tAtk=instance_create(x+(17*image_xscale),y-(28*image_yscale),oPassBullet)
        tAtk.sprite_index=sWarmasterC_IceShard; tAtk.atkPower=atkPower; tAtk.bulletSpeed=9
        tAtk.decayTime=-100; tAtk.damageType="ELEMENTAL"; tAtk.direction=tIceDir; tAtk.image_angle=tIceDir
        tIceDir+=4
      }
    }
  }
  else if actTime>=18
  {
    event_user(0)
  }
}
else if currentAttack=7 //==================== ATK G: ICE BLOCKS ====================
{
  if actTime=1
  {
    playSound(global.snd_OrbThrow,0,0.97,29000)
    if hoverMode=0 {sprite_index=sWarmasterC_ShootIceStand}
    else if hoverMode=1 {sprite_index=sWarmasterC_ShootIceHover}

    var tAtk,tMyXPlace;
    if x<xCenter {tMyXPlace=176}
    else {tMyXPlace=368}
    for(i=0;i<7;i+=1)
    {
      tAtk=instance_create(tMyXPlace+(i*32),96,oWMC_IceBlock)
      tAtk.atkPower=atkPower; tAtk.xPlace=tMyXPlace+(i*32); tAtk.yPlace=96; tAtk.warTarget=id
    }
    if ATTACK_SPEED=2 {actTime=2}
    else if ATTACK_SPEED>=3 {actTime=3}
  }
  else if actTime>=15
  {
    event_user(0)
  }
}
else if currentAttack=8 //==================== ATK H: JUMP UP + SPREAD ATTACK (Ground mode only) (Starts hover mode) ====================
{
  if actTime=1
  {
    sprite_index=sWarmasterC_JumpReady
    if ATTACK_SPEED>=3 {actTime=2}
  }
  else if actTime=12
  {
    playSound(global.snd_LightballSpread,0,0.95,28000)
    playSound(global.snd_CShotA,0,0.93,44100)
    sprite_index=sWarmasterC_JumpUp
    y-=2; yVel=-11
    tAtk=instance_create(x+16,y,oWMB_FireWave); tAtk.atkPower=atkPower; tAtk.damageType="ELEMENTAL"; tAtk.image_blend=c_blue
    tAtk=instance_create(x-16,y,oWMB_FireWave); tAtk.atkPower=atkPower; tAtk.damageType="ELEMENTAL"; tAtk.image_blend=c_blue; tAtk.image_xscale=-1
  }
  else if actTime=21
  {
    if superAtkType=0 {hoverMode=1; numOfAtks=0}
    var tAtk,tIceDir;
    tIceDir=0
    for(i=0;i<10;i+=1)
    {
      tAtk=instance_create(x,y-29,oPassBullet)
      tAtk.sprite_index=sWarmasterC_IceShard; tAtk.atkPower=atkPower; tAtk.bulletSpeed=7
      tAtk.decayTime=-100; tAtk.damageType="ELEMENTAL"; tAtk.direction=tIceDir; tAtk.image_angle=tIceDir
      tIceDir+=360/10
    }
    if ATTACK_SPEED>=2 {actTime=22}
  }
  else if actTime>=26
  {
    if superAtkType=1
    {
      actTime=0
      ATTACK_FORM=1
      event_user(5)
      currentAttack=5
    }
    else {event_user(0)}
  }
}
else if currentAttack=9 //==================== ATK I: ICE SHOT TO CEILING AND BREAK ====================
{
  if actTime=1
  {
    if hoverMode=0 {sprite_index=sWarmasterC_ShootIceStand}
    else if hoverMode=1 {sprite_index=sWarmasterC_ShootIceHover}
    if ATTACK_SPEED=2 {actTime=3}
    else if ATTACK_SPEED>=3 {actTime=5}
  }
  else if actTime=16
  {
    playSound(global.snd_IceShot,0,1,20000)
    var tAtk;
    tAtk=instance_create(x+(17*image_xscale),y-(27*image_yscale),oWMC_IceShotB)
    tAtk.atkPower=atkPower; tAtk.bulletSpeed=11; tAtk.warTarget=id
    tAtk.type=1; tAtk.direction=90
    if ATTACK_SPEED>=3 {actTime=18}
  }
  else if actTime>=23
  {
    if superAtkType=2
    {
      actTime=0
      ATTACK_FORM=2
      event_user(5)
      currentAttack=5
    }
    else {event_user(0)}
  }
}
#define Other_14
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///WIND FORM
if currentAttack=1 //==================== ATK A: DASH FORWARD ====================
{
  if actTime=1
  {
    sprite_index=sWarmasterD_DashReady; image_index=0
    if ATTACK_SPEED>=2 {actTime=2}
  }
  else if actTime=9 //Dash
  {
    playSound(global.snd_ChargeStrike,0,0.92,35000)
    sprite_index=sWarmasterD_Dashing
    dashEfFrm=0; dashEfType=1
    xVel=fastDashJumpAcc*scaleForFacing
    var tAtk;
    tAtk=instance_create(x,yGround,oWMD_TornadoB); tAtk.atkPower=atkPower
  }
  else if actTime>=11 and actTime<=23 //Check if passed up player
  {
    if scaleForFacing>0 //Right
    {
      if x+4>oPlayer1.x
      {
        xVel=0
        altUppercut=1
        actTime=0
        currentAttack=2
      }
    }
    else //Left
    {
      if x-4<oPlayer1.x
      {
        xVel=0
        altUppercut=1
        actTime=0
        currentAttack=2
      }
    }
  }
  else if actTime>=25
  {
    xVel=0
    event_user(0)
  }
}
else if currentAttack=2 //==================== ATK B: UPPERCUT ====================
{
  if actTime=1
  {
    sprite_index=sWarmasterD_DashUpReady; image_index=0
    if x<oPlayer1.x {image_xscale=1.25; scaleForFacing=1}
    else {image_xscale=-1.25; scaleForFacing=-1}
    if ATTACK_SPEED>=2 {actTime=2}
  }
  else if actTime=4 //Jump
  {
    playSound(global.snd_LightballSpread,0,0.93,32000)
    playSound(global.snd_WindBlow,0,0.93,44100)
    sprite_index=sWarmasterD_DashingUp
    dashEfFrm=0; dashEfType=2
    xVel=runAcc*scaleForFacing
    y-=2
    yVel=-14
    if altUppercut=1 {actTime=8}
  }
  else if actTime=20 //Hover
  {
    xVel=0; yVel=0
    bGravity=0
    sprite_index=sWarmasterD_Hover
    if altUppercut=1
    {
      if ATTACK_SPEED>=2 {actTime=27}
      else {actTime=26}
    }
    else
    {
      if ATTACK_SPEED=2 {actTime=22}
      else if ATTACK_SPEED>=3 {actTime=23}
    }
  }
  else if actTime=30
  {
    actTime=0
    if altUppercut=1 {altUppercut=0; currentAttack=5}
    else {altUppercut=2; currentAttack=3}
  }
}
else if currentAttack=3 //==================== ATK C: TORNADO ====================
{
  if actTime=1
  {
    sprite_index=sWarmasterD_TornSummonA; image_index=0
    if ATTACK_SPEED=2 {actTime=2}
    else if ATTACK_SPEED>=3 {actTime=3}
    if altUppercut=2
    {
      if ATTACK_SPEED=2 {actTime=7}
      else if ATTACK_SPEED>=3 {actTime=8}
      else {actTime=6}
    }
  }
  else if actTime=18
  {
    playSound(global.snd_WindBlow,0,1,1)
    sprite_index=sWarmasterD_TornSummonB
    var tAtk,tTornadoSpd;
    if altUppercut=2 {tTornadoSpd=5}
    else {tTornadoSpd=7}
    tAtk=instance_create(x+28,yGround,oWMD_TornadoA)
    tAtk.atkPower=atkPower; tAtk.moveSpd=tTornadoSpd; tAtk.fadeSpd=0.01
    tAtk=instance_create(x-28,yGround,oWMD_TornadoA)
    tAtk.atkPower=atkPower; tAtk.moveSpd=-tTornadoSpd; tAtk.fadeSpd=0.01
    if ATTACK_SPEED=2 {actTime=21}
    else if ATTACK_SPEED>=3 {actTime=23}
  }
  else if actTime=30
  {
    bGravity=1
    yVel=2
    if altUppercut=2
    {
      actTime=0
      currentAttack=4
    }
    else
    {
      if superAtkType=1
      {
        actTime=0
        ATTACK_FORM=2
        event_user(5)
        currentAttack=5
      }
      else {event_user(0)}
    }
    altUppercut=0
  }
}
else if currentAttack=4 //==================== ATK D: SHOOT WIND SHOT ====================
{
  if actTime=1
  {
    sprite_index=sWarmasterD_WindShotAir; image_index=0
    var tEffect;
    tEffect=instance_create(x+(17*image_xscale),y-(27*image_yscale),oEffect)
    tEffect.sprite_index=sCWM_Ef_ShotPulse; tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    if ATTACK_SPEED=2 {actTime=2}
    else if ATTACK_SPEED>=3 {actTime=3}
  }
  else if actTime=10
  {
    playSound(global.snd_Wave,0,0.97,16000)
    var tAtk,tWindDir;
    tWindDir=point_direction(x+(17*image_xscale),y-(28*image_yscale),oPlayer1.x,returnPlayerYCenter())
    if DIFFICULTY=1
    {
      tAtk=instance_create(x+(17*image_xscale),y-(27*image_yscale),oPassBullet)
      tAtk.sprite_index=sWarmasterD_AtkWindA; tAtk.atkPower=atkPower; tAtk.bulletSpeed=6
      tAtk.decayTime=-100; tAtk.damageType="ELEMENTAL"; tAtk.direction=tWindDir; tAtk.image_angle=tWindDir
    }
    else
    {
      tWindDir-=3
      for(i=0;i<3;i+=1)
      {
        tAtk=instance_create(x+(17*image_xscale),y-(27*image_yscale),oPassBullet)
        tAtk.sprite_index=sWarmasterD_AtkWindA; tAtk.atkPower=atkPower; tAtk.bulletSpeed=6
        tAtk.decayTime=-100; tAtk.damageType="ELEMENTAL"; tAtk.direction=tWindDir; tAtk.image_angle=tWindDir
        tWindDir+=3
      }
    }
    if ATTACK_SPEED>=3 {actTime=11}
  }
  else if actTime=13
  {
    if y>yGround-3 {sprite_index=sWarmasterD_Idle}
    else {sprite_index=sWarmasterD_Hover}
    if ATTACK_SPEED>=3 {actTime=14}
  }
  else if actTime>=17
  {
    event_user(0)
  }
}
else if currentAttack=5 //==================== ATK E: SUPER DIVE ====================
{
  if actTime=1
  {
    sprite_index=sWarmasterD_FastDash; image_index=0
    if ATTACK_SPEED>=2 {actTime=2}
  }
  else if actTime=5
  {
    playSound(global.snd_ChargeStrike,0,0.92,44100)
    playSound(global.snd_LightballSpread,0,0.8,44100)
    bGravity=1
    dashEfFrm=0; dashEfType=1
    var yDiveSpd;
    yDiveSpd=point_distance(x,0,oPlayer1.x,0)/20
    if yDiveSpd>10 {yDiveSpd=10}
    else if yDiveSpd<5 {yDiveSpd=5}
    if x<oPlayer1.x {yVel=yDiveSpd; image_xscale=1.25; scaleForFacing=1}
    else {yVel=-yDiveSpd; image_xscale=-1.25; scaleForFacing=-1}
    xVel=fastDashJumpAcc*scaleForFacing
  }
  else if actTime>=104
  {
    event_user(0)
  }
}
else if currentAttack=6 //==================== ATK F: SWORD SWING 1 - (Leads into Atk G) ====================
{
  if actTime=1
  {
    sprite_index=sWarmasterD_SwingAReady; image_index=0
    if ATTACK_SPEED>=2 {actTime=2}
  }
  else if actTime=4
  {
    if ATTACK_SPEED>=2 {actTime=5}
  }
  else if actTime=11 //Strike
  {
    playSound(global.snd_DeathSlash,0,1,28500)
    playSound(global.snd_WindBlow,0,0.9,48000)
    sprite_index=sWarmasterD_SwingAStrike; image_index=0
    var tAtk;
    tAtk=instance_create(x,y,oWMD_SwordSlash)
    tAtk.atkPower=atkPower; tAtk.image_xscale=image_xscale; tAtk.image_yscale=image_yscale; tAtk.type=0

    tAtk=instance_create(x+(12*scaleForFacing),y-30,oWMD_SwordWave)
    tAtk.atkPower=atkPower; tAtk.type=0
    if image_xscale<0 {tAtk.direction=180; tAtk.image_angle=180}
    if ATTACK_SPEED>=2 {actTime=13}
  }
  else if actTime=19
  {
    image_index=1
    with oWMD_SwordSlash {instance_destroy()}
    if ATTACK_SPEED=2 {actTime=20}
    else if ATTACK_SPEED>=3 {actTime=21}
  }
  else if actTime>=26
  {
    actTime=0
    currentAttack=7
  }
}
else if currentAttack=7 //==================== ATK G: SWORD SWING 2 - (Leads into Atk H) ====================
{
  if actTime=1
  {
    if x<oPlayer1.x {image_xscale=1.25; scaleForFacing=1}
    else {image_xscale=-1.25; scaleForFacing=-1}
    sprite_index=sWarmasterD_SwingBReady; image_index=0
    if ATTACK_SPEED>=2 {actTime=2}
  }
  else if actTime=4
  {
    if ATTACK_SPEED>=2 {actTime=5}
  }
  else if actTime=10 //Strike
  {
    playSound(global.snd_DeathSlash,0,1,30500)
    playSound(global.snd_WindBlow,0,0.9,48000)
    sprite_index=sWarmasterD_SwingBStrike; image_index=0
    var tAtk,tWaveDir;
    tWaveDir=point_direction(x+(12*scaleForFacing),y-30,oPlayer1.x,returnPlayerYCenter())
    tAtk=instance_create(x,y,oWMD_SwordSlash)
    tAtk.atkPower=atkPower; tAtk.image_xscale=image_xscale; tAtk.image_yscale=image_yscale; tAtk.sprite_index=sWarmasterD_AtkB; tAtk.type=1

    tAtk=instance_create(x+(12*scaleForFacing),y-30,oWMD_SwordWave)
    tAtk.atkPower=atkPower; tAtk.direction=tWaveDir; tAtk.image_angle=tWaveDir; tAtk.sprite_index=sWarmasterD_AtkWindB; tAtk.type=1
    if ATTACK_SPEED>=2 {actTime=11}
  }
  else if actTime=18
  {
    image_index=1
    with oWMD_SwordSlash {instance_destroy()}
    if ATTACK_SPEED=2 {actTime=19}
    else if ATTACK_SPEED>=3 {actTime=20}
  }
  else if actTime>=25
  {
    actTime=0
    currentAttack=8
  }
}
else if currentAttack=8 //==================== ATK H: SWORD SWING 3 ====================
{
  if actTime=1
  {
    if x<oPlayer1.x {image_xscale=1.25; scaleForFacing=1}
    else {image_xscale=-1.25; scaleForFacing=-1}
    sprite_index=sWarmasterD_SwingCReady; image_index=0
    if ATTACK_SPEED>=2 {actTime=2}
  }
  else if actTime=4
  {
    if ATTACK_SPEED>=2 {actTime=5}
  }
  else if actTime=11 //Strike
  {
    playSound(global.snd_DeathSlash,0,1,32500)
    playSound(global.snd_WindBlow,0,0.9,48000)
    sprite_index=sWarmasterD_SwingCStrike; image_index=0
    var tAtk,tWaveDir;
    tWaveDir=point_direction(x+(12*scaleForFacing),y-30,oPlayer1.x,returnPlayerYCenter())
    tAtk=instance_create(x,y,oWMD_SwordSlash)
    tAtk.atkPower=atkPower; tAtk.image_xscale=image_xscale; tAtk.image_yscale=image_yscale; tAtk.sprite_index=sWarmasterD_AtkC; tAtk.type=2

    tAtk=instance_create(x+(12*scaleForFacing),y-30,oWMD_SwordWave)
    tAtk.atkPower=atkPower; tAtk.direction=tWaveDir; tAtk.image_angle=tWaveDir; tAtk.sprite_index=sWarmasterD_AtkWindC; tAtk.type=2
    if ATTACK_SPEED>=2 {actTime=12}
  }
  else if actTime=19
  {
    image_index=1
    with oWMD_SwordSlash {instance_destroy()}
    if ATTACK_SPEED=2 {actTime=20}
    else if ATTACK_SPEED>=3 {actTime=21}
  }
  else if actTime>=26
  {
    event_user(0)
  }
}
else if currentAttack=9 //==================== ATK I: SUMMON SEEKER ORB (Needs charge) ====================
{
  if actTime=1
  {
    tEffect=instance_create(x,y-20,oEffectB)
    tEffect.type=1; tEffect.sprite_index=sWarSpellWave; tEffect.image_alpha=0.8; tEffect.fadeSpd=0; tEffect.image_speed=0.75
    tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=1; tEffect.followID=-1; tEffect.rotation=0; tEffect.image_alpha=0.66
    for(i=0;i<8;i+=1)
    {
      tEffect=instance_create(x+random_range(-16,16),y-random(4),oEffectB)
      tEffect.type=3; tEffect.sprite_index=sMMchargeEffect1; tEffect.image_alpha=0.8
      tEffect.direction=90; tEffect.image_angle=90; tEffect.friction=0.05; tEffect.image_xscale=2; tEffect.image_yscale=2
      tEffect.speed=1+random(2); tEffect.fadeSpd=0.02; tEffect.image_blend=make_color_rgb(10,190,70)
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
    }
    sprite_index=sWarmasterD_SummonOrb; image_index=0
    var tEffect;
    tEffect=instance_create(x+(17*image_xscale),y-(27*image_yscale),oEffect)
    tEffect.sprite_index=sCWM_Ef_AtkPulse; tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    if ATTACK_SPEED>=2 {actTime=2}
  }
  else if actTime=11
  {
    playSound(global.snd_OrbThrow,0,0.9,16000)
    playSound(global.snd_WindBlow,0,0.8,17000)
    with oWMD_SeekerOrb {instance_destroy()}
    var tAtk;
    tAtk=instance_create(x,y-68,oWMD_SeekerOrb)
    tAtk.atkPower=atkPower
    if ATTACK_SPEED=2 {actTime=13}
    else if ATTACK_SPEED>=3 {actTime=16}
  }
  else if actTime=25
  {
    if superAtkType=2
    {
      actTime=0
      ATTACK_FORM=1
      event_user(5)
      currentAttack=4
    }
    else {event_user(0)}
  }
}
#define Other_15
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///SWAPPING FORM
if instance_exists(oWMC_IceHoverA)
{
  with oWMC_IceHoverA
  {
    bOrbit=0
    moveProg=2
    moveTime=fireDelay-5
  }
}

if superChangeAtk=0 //If Warmaster was about to attack, set back attack timer
{
  if waitTime>=waitDelay-20 {waitTime=waitDelay-20}
}

bGravity=1; hoverMode=0
currHspd=0; currVspd=0

var tEffect;
tEffect=instance_create(x,y-(27*image_yscale),oEffect)
tEffect.sprite_index=sCWM_Ef_AtkPulse; tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
shiftTime=0; shiftDamage=0
if ATTACK_FORM=1
{
  sprite_index=sWarmasterA_Idle
  jeremyText="The Warmaster is able to employ a wide range of close range sword attacks. Which is trouble for you because he's practically immune to most of your projectiles. He's got a standard sword attack that also launches a fairly close range wave. A dash, jump, and dive attack. Jerry, you cover a lot of space with your sword, but Claire, you have good range. Keep that in mind. He can cling to the walls too and when you see that, he's got quite a nasty energy attack from the ceiling that he can summon."
  chaoText="I figured there was a lot more he could do. When I first saw the Warmaster, I was wondering if he'd be able to employ those Mega Man ZX abilities like this."
  for(i=0;i<6;i+=1)
  {
    resType[i]=3
  }
  resType[1]=2; resType[2]=1; resType[3]=1; resType[4]=2; resType[5]=1
  if DIFFICULTY>=2 {resType[1]=1}
  if DIFFICULTY>=3 {resType[4]=1}
  if shiftType=0 {shiftDmgMax=42; shiftMaxTime=750}
  else {shiftDmgMax=30; shiftMaxTime=660}
}
else if ATTACK_FORM=2
{
  sprite_index=sWarmasterB_Idle
  jeremyText="Oh wow, so he CAN do a lot more. Okay, something worth noting is that all of his fire attacks are counted as Explosive damage. The biggest threat with this form that I can see is his charge attack. It's super fast and leave a bunch of fire pillars along his path. I doubt you'll be able to reliably use i-frames to avoid damage, so keep their spacing in mind. That and I think it would be best if you didn't dash when unnecessary."
  chaoText="Uh oh, things suddenly got a lot worse for you guys. It looks like he can do the same type of thing you two can do. He'll periodically swap forms to match the situation. I'm sure he's got a limitation on when he can swap... at least I hope so. Would suck if he started combining attacks from the different forms..."
  for(i=0;i<6;i+=1)
  {
    resType[i]=3
  }
  resType[0]=2; resType[3]=1; resType[4]=1; resType[5]=2
  if DIFFICULTY>=2 {resType[0]=1}
  if DIFFICULTY>=3 {resType[1]=1; resType[5]=1}
  if shiftType=0 {shiftDmgMax=81; shiftMaxTime=750}
  else {shiftDmgMax=60; shiftMaxTime=660}
}
else if ATTACK_FORM=3
{
  bGoombaStomp=1; goombaStompTime=15
  numOfAtks=0
  sprite_index=sWarmasterC_Idle
  jeremyText="In this form, he can hover and he'll do it very often. I'd recommend Claire stay active for this one since she's got a bit more maneuverability and she has the Morph Ball for tight bullet storms. He can spam projectiles in this form quite a bit and he's rather scary with those projectile patterns as well. Just a thought I had. Learn his attacks and his openings. If he starts going crazy with attacks, keep calm and wait for moments to counter."
  chaoText="If you haven't noticed yet, he telegraphs EVERY attack before he performs them, though he does get faster the more you damage him. There's something else I've noticed. He has a sort of 'super attack' per form, but each of those can only be used after he charges up enough. It looks like all he has to do to charge is use his wide variety of standard attacks."
  for(i=0;i<6;i+=1)
  {
    resType[i]=3
  }
  resType[0]=1; resType[1]=1; resType[2]=1; resType[5]=2
  if DIFFICULTY>=2 {resType[5]=1}
  if DIFFICULTY>=3 {resType[4]=1}
  if shiftType=0 {shiftDmgMax=132; shiftMaxTime=750}
  else {shiftDmgMax=90; shiftMaxTime=660}
}
else if ATTACK_FORM=4
{
  sprite_index=sWarmasterD_Idle
  jeremyText="I'd recommend staying away from this form mainly due to his ability to call up tornados around him. He's immune to melee damage in this form anyway. While he doesn't spam projectiles too bad in this form, the projectiles he does have are large. He has a lot of field control in this form, though I don't feel it's as significant as his main one, luckily for you."
  chaoText="He's fast in this form and tends to use his own body as his weapon along with his wind attacks and blade strikes. That seeking wind orb that he summons isn't so bad until he starts covering the field in tornados. If he's close to the middle of the field, you have to dash to dodge those. Keep that in mind when managing your dash energy."
  for(i=0;i<6;i+=1)
  {
    resType[i]=3
  }
  resType[0]=1; resType[1]=1; resType[2]=2; resType[4]=2
  if DIFFICULTY>=2 {resType[3]=1}
  if DIFFICULTY>=3 {resType[2]=1; resType[4]=1}
  if shiftType=0 {shiftDmgMax=75; shiftMaxTime=750}
  else {shiftDmgMax=54; shiftMaxTime=660}
}
#define Other_16
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///DECISION MAKING
if ATTACK_FORM=1 //======================================== MAIN FORM ========================================
{
  if atkNum=0 //----- First attack -----
  {
    if point_distance(x,0,oPlayer1.x,0)<100 //-- Player is close --
    {
      if oPlayer1.attackState=0 //Player is not attacking
      {
        if atkInSequence mod 2=0 {currentAttack=4}
        else {currentAttack=1}
      }
      else //Player is attacking
      {
        if atkInSequence=1 {currentAttack=4}
        else {currentAttack=1}
      }
    }
    else //-- Player is far --
    {
      if atkInSequence=0 or atkInSequence=2
      {
        if oPlayer1.attackState=0 //Player is not attacking
        {
          if superCharge<superMax {currentAttack=1}
          else {currentAttack=6; superCharge=0}
        }
        else //Player is attacking
        {
          currentAttack=3
        }
      }
      else
      {
        if oPlayer1.attackState=0 //Player is not attacking
        {
          currentAttack=3
        }
        else //Player is attacking
        {
          if superCharge<superMax {currentAttack=3}
          else {currentAttack=6; superCharge=0}
        }
      }
    }
  }
  else if atkNum>=1 //----- Second and third attack -----
  {
    if point_distance(x,0,oPlayer1.x,0)<100 //-- Player is close --
    {
      if oPlayer1.attackState=0 //Player is not attacking
      {
        if atkInSequence mod 2=0 {currentAttack=1}
        else
        {
          if superCharge<superMax {currentAttack=1}
          else {currentAttack=6; superCharge=0}
        }
      }
      else //Player is attacking
      {
        if atkInSequence mod 2=0 {currentAttack=1}
        else {currentAttack=4}
      }
    }
    else //-- Player is far --
    {
      if oPlayer1.attackState=0 //Player is not attacking
      {
        if atkInSequence mod 2=0 {currentAttack=4}
        else {currentAttack=1}
      }
      else //Player is attacking
      {
        if atkInSequence mod 2=0 {currentAttack=3}
        else
        {
          if superCharge<superMax {currentAttack=3}
          else {currentAttack=6; superCharge=0}
        }
      }
    }
  }
}
else if ATTACK_FORM=2 //======================================== FIRE FORM ========================================
{
  if atkNum=0 //----- First attack -----
  {
    if point_distance(x,0,oPlayer1.x,0)<120 //-- Player is close --
    {
      if oPlayer1.attackState=0 //Player is not attacking
      {
        if atkInSequence mod 2=0 {currentAttack=1}
        else
        {
          if superCharge<superMax {currentAttack=6}
          else {currentAttack=2; superCharge=0}
        }
      }
      else //Player is attacking
      {
        if atkInSequence=1
        {
          if superCharge<superMax {currentAttack=1}
          else {currentAttack=2; superCharge=0}
        }
        else {currentAttack=1}
      }
    }
    else //-- Player is far --
    {
      if atkInSequence=0 or atkInSequence=2
      {
        if oPlayer1.attackState=0 //Player is not attacking
        {
          currentAttack=3
        }
        else //Player is attacking
        {
          currentAttack=6
        }
      }
      else
      {
        if oPlayer1.attackState=0 //Player is not attacking
        {
          currentAttack=4
        }
        else //Player is attacking
        {
          currentAttack=3
        }
      }
    }
  }
  else if atkNum=1 //----- Second attack -----
  {
    if point_distance(x,0,oPlayer1.x,0)<120 //-- Player is close --
    {
      if oPlayer1.attackState=0 //Player is not attacking
      {
        if superCharge<superMax
        {
          if atkInSequence=1 {currentAttack=6}
          else {currentAttack=3}
        }
        else {currentAttack=2; superCharge=0}
      }
      else //Player is attacking
      {
        if atkInSequence=1 {currentAttack=1}
        else {currentAttack=4}
      }
    }
    else //-- Player is far --
    {
      if atkInSequence=0 or atkInSequence=2
      {
        if oPlayer1.attackState=0 //Player is not attacking
        {
          currentAttack=5
        }
        else //Player is attacking
        {
          currentAttack=1
        }
      }
      else
      {
        if oPlayer1.attackState=0 //Player is not attacking
        {
          if superCharge<superMax {currentAttack=6}
          else {currentAttack=2; superCharge=0}
        }
        else //Player is attacking
        {
          currentAttack=5
        }
      }
    }
  }
  else if atkNum>=2 //----- Third attack -----
  {
    if point_distance(x,0,oPlayer1.x,0)<120 //-- Player is close --
    {
      if oPlayer1.attackState=0 //Player is not attacking
      {
        if superCharge<superMax
        {
          if atkInSequence=1 {currentAttack=3}
          else {currentAttack=6}
        }
        else {currentAttack=2; superCharge=0}
      }
      else //Player is attacking
      {
        if atkInSequence=1 {currentAttack=5}
        else {currentAttack=6}
      }
    }
    else //-- Player is far --
    {
      if atkInSequence=0 or atkInSequence=2
      {
        if oPlayer1.attackState=0 //Player is not attacking
        {
          currentAttack=5
        }
        else //Player is attacking
        {
          currentAttack=6
        }
      }
      else
      {
        if oPlayer1.attackState=0 //Player is not attacking
        {
          currentAttack=4
        }
        else //Player is attacking
        {
          currentAttack=3
        }
      }
    }
  }
}
else if ATTACK_FORM=3 //======================================== ICE FORM ========================================
{
  if atkNum=0 //----- First attack -----
  {
    if point_distance(x,y-29,oPlayer1.x,returnPlayerYCenter())<132 //-- Player is close --
    {
      if numOfAtks<=1
      {
        if hoverMode=0 {currentAttack=3}
        else {currentAttack=6}
      }
      else
      {
        if atkInSequence=0 or atkInSequence=2 {currentAttack=6}
        else {currentAttack=7}
      }
    }
    else //-- Player is far --
    {
      if numOfAtks<=1
      {
        if atkInSequence=0 or atkInSequence=2 {currentAttack=6}
        else {currentAttack=5}
      }
      else
      {
        if atkInSequence=0 or atkInSequence=2 {currentAttack=9}
        else {currentAttack=6}
      }
    }
  }
  else if atkNum=1 //----- Second attack -----
  {
    if point_distance(x,y-29,oPlayer1.x,returnPlayerYCenter())<132 //-- Player is close --
    {
      if numOfAtks<=1
      {
        if superCharge<superMax or instance_exists(oWMC_IceHoverA) or instance_exists(oWMC_IceHoverB) {currentAttack=5}
        else {currentAttack=1; superCharge=0}
      }
      else
      {
        if atkInSequence=0 or atkInSequence=2 {currentAttack=7}
        else {currentAttack=9}
      }
    }
    else //-- Player is far --
    {
      if numOfAtks<=1
      {
        if superCharge<superMax or instance_exists(oWMC_IceHoverA) or instance_exists(oWMC_IceHoverB)
        {
          if atkInSequence=0 or atkInSequence=2 {currentAttack=9}
          else {currentAttack=5}
        }
        else {currentAttack=1; superCharge=0}
      }
      else
      {
        if atkInSequence=0 or atkInSequence=2
        {
          if hoverMode=1
          {
            if numOfAtks>=3 {currentAttack=2}
            else {currentAttack=5}
          }
          else {currentAttack=6}
        }
        else
        {
          if hoverMode=0 {currentAttack=3}
          else {currentAttack=7}
        }
      }
    }
  }
  else if atkNum>=2 //----- Third attack -----
  {
    if point_distance(x,y-29,oPlayer1.x,returnPlayerYCenter())<132 //-- Player is close --
    {
      if numOfAtks<=1
      {
        if atkInSequence=0 or atkInSequence=1 {currentAttack=6}
        else {currentAttack=5}
      }
      else
      {
        if atkInSequence=0 or atkInSequence=2
        {
          if hoverMode=0 {currentAttack=3}
          else {currentAttack=6}
        }
        else
        {
          if hoverMode=1
          {
            if numOfAtks>=3 {currentAttack=2}
            else {currentAttack=5}
          }
          else {currentAttack=7}
        }
      }
    }
    else //-- Player is far --
    {
      if numOfAtks<=1 {currentAttack=6}
      else
      {
        if atkInSequence=0 or atkInSequence=2
        {
          if superCharge<superMax or instance_exists(oWMC_IceHoverA) or instance_exists(oWMC_IceHoverB) {currentAttack=9}
          else {currentAttack=1; superCharge=0}
        }
        else {currentAttack=9}
      }
    }
  }

  if currentAttack!=1 //Change from ground to hover or vice versa (Orbiting ice must not have been chosen)
  {
    if hoverMode=0 //To hover mode
    {
      if shiftType=2 {if numOfAtks>=1 {currentAttack=8; numOfAtks=0}}
      else
      {
        if ATTACK_SPEED=3 {if numOfAtks>=2 {currentAttack=8; numOfAtks=0}}
        else {if numOfAtks>=3 {currentAttack=8; numOfAtks=0}}
      }
    }
    else //To ground mode
    {
      if numOfAtks>=6 {currentAttack=4; numOfAtks=0}
    }
  }
}
else if ATTACK_FORM=4 //======================================== WIND FORM ========================================
{
  if atkNum=0 //----- First attack -----
  {
    if point_distance(x,y-29,oPlayer1.x,returnPlayerYCenter())<128 //-- Player is close --
    {
      if atkInSequence=0 or atkInSequence=1 {currentAttack=6}
      else {currentAttack=2}
    }
    else //-- Player is far --
    {
      if atkInSequence=0 or atkInSequence=1 {currentAttack=1}
      else {currentAttack=4}
    }
  }
  else if atkNum=1 //----- Second attack -----
  {
    if superCharge<superMax
    {
      if point_distance(x,y-29,oPlayer1.x,returnPlayerYCenter())<128 //-- Player is close --
      {
        if atkInSequence=0 or atkInSequence=1 {currentAttack=3}
        else {currentAttack=4}
      }
      else //-- Player is far --
      {
        if atkInSequence=0 or atkInSequence=1 {currentAttack=2}
        else {currentAttack=6}
      }
    }
    else {currentAttack=9; superCharge=0}
  }
  else if atkNum>=2 //----- Third attack -----
  {
    if point_distance(x,y-29,oPlayer1.x,returnPlayerYCenter())<128 //-- Player is close --
    {
      if atkInSequence=0 or atkInSequence=1 {currentAttack=1}
      else {currentAttack=3}
    }
    else //-- Player is far --
    {
      if atkInSequence=0 or atkInSequence=1
      {
        if oPlayer1.attackState=0 {currentAttack=4}
        else {currentAttack=3}
      }
      else {currentAttack=2}
    }
  }
}
#define Other_17
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///SET CHANGE ORDER
var tMakeOrder;
tMakeOrder=1
if oPlayer1.x<=xCenter {tMakeOrder=1}
if oPlayer1.x<=xCenter-(roomSpan/2) {tMakeOrder=2}
if oPlayer1.x>=xCenter {tMakeOrder=3}
if oPlayer1.x>=xCenter+(roomSpan/2) {tMakeOrder=4}

if tMakeOrder=1
{
  orderSet[0]=1
  orderSet[1]=2
  orderSet[2]=3
  orderSet[3]=4
}
else if tMakeOrder=2
{
  orderSet[0]=1
  orderSet[1]=4
  orderSet[2]=3
  orderSet[3]=2
}
else if tMakeOrder=3
{
  orderSet[0]=1
  orderSet[1]=3
  orderSet[2]=2
  orderSet[3]=4
}
else if tMakeOrder=4
{
  orderSet[0]=1
  orderSet[1]=4
  orderSet[2]=2
  orderSet[3]=3
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///ALTER SHIFT TIME
/*
if ATTACK_FORM=1 //======================================== MAIN FORM ========================================
{
  if other.damageType="NORMAL"
  {
    if timeTillLastHit<=25 {shiftDamage+=6; shiftTime+=6}
    else {shiftDamage+=3; shiftTime+=4}
  }
  else
  {
    if timeTillLastHit<=25 {shiftDamage+=2; shiftTime+=3}
    else {shiftDamage+=2; shiftTime+=2}
  }
}
else if ATTACK_FORM=2 //======================================== FIRE FORM ========================================
{
  if other.damageType="PIERCE" or other.damageType="ELEMENTAL"
  {
    if timeTillLastHit<=25 {shiftDamage+=6; shiftTime+=6}
    else {shiftDamage+=3; shiftTime+=4}
    if other.weaponTag=32 {shiftDamage+=2; shiftTime+=3}
  }
  else
  {
    if timeTillLastHit<=25 {shiftDamage+=2; shiftTime+=3}
    else {shiftDamage+=2; shiftTime+=2}
  }
}
else if ATTACK_FORM=3 //======================================== ICE FORM ========================================
{
  if other.damageType="SHOT" or other.damageType="EXPLOSION"
  {
    if timeTillLastHit<=25 {shiftDamage+=6; shiftTime+=6}
    else {shiftDamage+=3; shiftTime+=4}
  }
  else
  {
    if timeTillLastHit<=25 {shiftDamage+=2; shiftTime+=3}
    else {shiftDamage+=2; shiftTime+=2}
  }
}
else if ATTACK_FORM=4 //======================================== WIND FORM ========================================
{
  if other.damageType="SPECIAL"
  {
    if timeTillLastHit<=25 {shiftDamage+=6; shiftTime+=6}
    else {shiftDamage+=3; shiftTime+=4}
  }
  else
  {
    if timeTillLastHit<=25 {shiftDamage+=2; shiftTime+=3}
    else {shiftDamage+=2; shiftTime+=2}
  }
}*/

if myType!=1
{

}

timeTillLastHit=0
if waitTime<waitDelay {waitTime+=1}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Rope (Form A)
if bRope=1
{
  draw_sprite_ext(sWarmasterA_RopeA,dashEfFrm,ropeX,48,1,ropeYscl,0,c_white,1)
}

//Dash effect
if dashEfType=1
{
  draw_sprite_ext(sWarmasterD_DashEfA,dashEfFrm,x,y,image_xscale,image_yscale,image_angle,c_white,0.9)
}
else if dashEfType=2
{
  draw_sprite_ext(sWarmasterD_DashEfB,dashEfFrm,x,y,image_xscale,image_yscale,image_angle,c_white,0.9)
}
if sprite_index=sWarmasterC_JetB
{
  jetEfFrm+=0.33
  draw_sprite_ext(sWarmasterC_JetEfA,jetEfFrm,x-(7*image_xscale),y-46,image_xscale,image_yscale,image_angle,c_white,0.9)
}
else if sprite_index=sWarmasterD_Hover
{
  jetEfFrm+=0.33
  draw_sprite_ext(sWarmasterD_HoverEfA,jetEfFrm,x-(3*image_xscale),y-24,image_xscale,image_yscale,image_angle,c_white,0.9)
}

if sprite_index=sWarmasterA_SwordRoll {draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,swdRollAng,image_blend,image_alpha)}
else {draw_self()}
