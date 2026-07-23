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
eName="CHAOS Warmaster EX"
eLevel=40
maxLife=16400
life=maxLife
atkPower=12
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
EX_SWORDSWING=0
EX_DROPDASH=0

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
EX_GROUNDHIT=0
EX_FIREBALL=0

//-- Form C3 Data --
hoverMode=0 //0: No hover, 1: Follow player but stay above them, 2: Hover near mid-top of room
currHspd=0
currVspd=0
orbitNum=6 //Number of orbiting ice shards to summon
numOfAtks=0 //Number of attacks before swapping between hover/ground mode (Will spend more time in hover mode)
EX_ICESHOT=0

//-- Form D4 Data --
tornadoNum=0
altUppercut=0
EX_WINDSHOT=0
EX_SWIRLGUN=0
EX_TOPGUNS=0

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

//----- EX MODE STATS -----
waitTime=13
waitDelay=26
timeTillChange=200
orbitNum=11
ATTACK_SPEED=3
DIFFICULTY=3
shiftType=2
fireFreq=4
fireDuration=190
FASTER_CHANGE=2
weaknessChange=0
//--------------------
//DELETE THIS
//ATTACK_FORM=4
//timeTillChange=10000
//--------------------

//Misc Data
xCenter=368
roomSpan=208
yGround=304
roomHeight=256

orderChangeSetting=0
event_user(7)

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
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=2
    bCanDealDamage=true; bCanTakeDamage=true
    jeremyText="This variation of the Warmaster has him in his turbo mode for the entire duration of the fight. Other alterations are dealing slightly more damage and HP, and having more attacks. You have a modification too, your dash recovery is faster for this fight."
    chaoText="Can you imagine the reaction people would have had if this was the original version of the fight? Oh right, helpful tips. Uh, his weaknesses are the same as the original encounter, but after half of his HP is depleted, his weaknesses change to the original fight's final phase variant."
    devText="There are no in-game rewards for winning this fight, it's a bonus that was primarily asked for by NZZ. Warmaster's final 30% was a more fast paced and constant change up and NZZ had always wanted a version with that being the entire fight. While that was the initial goal, altering the fight in much bigger ways had won. This isn't meant as a 'definitive' variant of the fight, simply a far more extreme version for silliness."
    activateBoss=2
  }

  if bActive=true and life>0
  {
    if bGoombaStomp=1 and ATTACK_FORM!=3 //Limited time on achievement after Warmaster swaps
    {
      goombaStompTime-=1
      if goombaStompTime<=0 {bGoombaStomp=0}
    }

    timeTillLastHit+=1
    //-------------------- Manage form change --------------------
    if superChangeAtk=0
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
            if orderChangeSetting=0
            {
              event_user(7)
              orderChangeSetting=1
            }

            ATTACK_FORM=orderSet[orderNum]
            orderNum+=1
            if orderNum=4 {orderNum=0; event_user(7)}
            event_user(5)
            timeChangeSet+=1
            if FASTER_CHANGE=0
            {
              if timeChangeSet=1 {timeTillChange=260}
              else if timeChangeSet=2 {timeTillChange=160}
              else if timeChangeSet=3 {timeTillChange=220}
              else if timeChangeSet=4 {timeTillChange=140}
              else if timeChangeSet=5 {timeTillChange=200; timeChangeSet=0}
            }
            else
            {
              if timeChangeSet=1 {timeTillChange=210}
              else if timeChangeSet=2 {timeTillChange=110}
              else if timeChangeSet=3 {timeTillChange=170}
              else if timeChangeSet=4 {timeTillChange=90}
              else if timeChangeSet=5 {timeTillChange=150; timeChangeSet=0}
            }
            if ATTACK_FORM=3 {timeTillChange+=30}
          }
        }
      }
    }

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

      if currentAttack=5
      {
        var tDFPillar;
        tDFPillar=instance_create(x,yGround,oWMB_EX_MiniFPillar); tDFPillar.atkPower=atkPower //EX MODE

        if actTime mod 3=0
        {
          var tDFPillar;
          tDFPillar=instance_create(x,yGround,oWMB_DashFPillar); tDFPillar.atkPower=atkPower
          tDFPillar.image_xscale=0.6; tDFPillar.image_yscale=0.9
        }
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
          if superAtkType=1 //Sequence 1 (Not in this variant)
          {
            ATTACK_FORM=3
            event_user(5)
            currentAttack=8
          }
          else if superAtkType=2 //Sequence 2 (Not in this variant)
          {
            ATTACK_FORM=3
            event_user(5)
            currentAttack=9
          }
          else if superAtkType=3 //Sequence 3 (60% super phase)
          {
            ATTACK_FORM=3
            event_user(5)
            currentAttack=8
          }
          else if superAtkType=4 //Sequence 4 (40% super phase)
          {
            ATTACK_FORM=1
            event_user(5)
            currentAttack=7
          }
          else if superAtkType=5 //Sequence 5 (80% super phase)
          {
            ATTACK_FORM=1
            event_user(5)
            currentAttack=8
          }
          else if superAtkType=6 //Sequence 6 (20% super phase)
          {
            ATTACK_FORM=2
            event_user(5)
            currentAttack=7
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
          if sprite_index=sWarmasterA_GroundHit //Form 1, Atk 2 (ATK C: DASH + JUMP SLASH)
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
          else if sprite_index=sWarmasterA_SwordRoll //Form 1, Atk 5 (ATK E: SWORD ROLL)
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
          else if sprite_index=sWarmasterB_HitGroundB //Form 2, Atk 4 (ZIP UP + HANG + DIVE)
          {
            playSound(global.snd_HardHit1,0,0.97,32000)
            playSound(global.snd_Flame1,0,0.95,34000)
            image_index=1
            var tAtk;
            if currentAttack=7
            {
              var tAtk;
              tAtk=instance_create(x+44,y,oWMB_FirePillar); tAtk.atkPower=atkPower; tAtk.image_xscale=1.5; tAtk.image_yscale=1.5
              tAtk=instance_create(x-44,y,oWMB_FirePillar); tAtk.atkPower=atkPower; tAtk.image_xscale=1.5; tAtk.image_yscale=1.5
              tAtk=instance_create(x+88,y,oWMB_FirePillar); tAtk.atkPower=atkPower
              tAtk=instance_create(x-88,y,oWMB_FirePillar); tAtk.atkPower=atkPower
              tAtk=instance_create(x+16,y,oWMB_FireWave); tAtk.atkPower=atkPower; tAtk.damageType="EXPLOSION"; tAtk.image_xscale=1.6; tAtk.image_yscale=1.6
              tAtk=instance_create(x-16,y,oWMB_FireWave); tAtk.atkPower=atkPower; tAtk.damageType="EXPLOSION"; tAtk.image_xscale=-1.6; tAtk.image_yscale=1.6
              tAtk=instance_create(x+16,y,oWMB_FireWave); tAtk.atkPower=atkPower; tAtk.damageType="EXPLOSION"; tAtk.image_xscale=-1.3; tAtk.image_yscale=1.3
              tAtk=instance_create(x-16,y,oWMB_FireWave); tAtk.atkPower=atkPower; tAtk.damageType="EXPLOSION"; tAtk.image_xscale=1.3; tAtk.image_yscale=1.3
              tAtk=instance_create(x+16,y,oWMB_FireWave); tAtk.atkPower=atkPower; tAtk.damageType="EXPLOSION"; tAtk.image_xscale=1.1; tAtk.image_yscale=1.1
              tAtk=instance_create(x-16,y,oWMB_FireWave); tAtk.atkPower=atkPower; tAtk.damageType="EXPLOSION"; tAtk.image_xscale=-1.1; tAtk.image_yscale=1.1
            }
            else
            {
              tAtk=instance_create(x,y,oWMB_FirePillar); tAtk.atkPower=atkPower
              tAtk=instance_create(x+16,y,oWMB_FireWave); tAtk.atkPower=atkPower; tAtk.damageType="EXPLOSION"
              tAtk=instance_create(x-16,y,oWMB_FireWave); tAtk.atkPower=atkPower; tAtk.damageType="EXPLOSION"; tAtk.image_xscale=-1
            }
            actTime=200
          }
          else if sprite_index=sWarmasterC_SpearDown //Form 3, Atk 4 (ATK D: DIVE)
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
          else if sprite_index=sWarmasterD_FastDash //Form 4, Atk 5 (ATK E: SUPER DIVE)
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
          if currentAttack!=8 {xVel=0}
        }
        if ATTACK_FORM!=3 {bGoombaStomp=0}
        yVel=0
      }
      if isCollisionTop(1) //-------------------- Touch ceiling --------------------
      {
        if sprite_index=sWarmasterB_ZipUpward //Form 2, Atk 4 (ZIP UP + HANG + DIVE)
        {
          playSound(global.snd_Slam,0,0.88,28000)
          playSound(global.snd_HardHit3,0,0.91,26000)
          if currentAttack=7
          {
            sprite_index=sWarmasterB_GunDown; xVel=0
            if x<xCenter {image_xscale=1.25; scaleForFacing=1}
            else {image_xscale=-1.25; scaleForFacing=-1}
          }
          else {sprite_index=sWarmasterB_Hang}
          yVel=0
          bGravity=0
          var tAtk,tXFireVel,tXOtherVel;
          tXOtherVel=-1

          tXFireVel=-6
          for(i=0;i<7;i+=1)
          {
            tAtk=instance_create(x,yGround-roomHeight,oGravPassBullet)
            tAtk.sprite_index=sWarmasterB_AtkFireballB; tAtk.atkPower=atkPower; tAtk.grav=0.3; tAtk.xVel=tXFireVel; tAtk.yVel=3
            tXFireVel+=2
          }

          for(i=0;i<2;i+=1)
          {
            tAtk=instance_create(x,yGround-roomHeight,oGravPassBullet)
            tAtk.sprite_index=sWarmasterB_AtkFireballB; tAtk.atkPower=atkPower; tAtk.grav=0.25; tAtk.xVel=tXOtherVel; tAtk.yVel=1
            tXOtherVel+=2
          }
          if actTime<100 {actTime=100}
        }
      }
      if sprite_index!=sWarmasterA_WallGrabGun
      {
        if isCollisionLeft(1) //-------------------- Left wall --------------------
        {
          if sprite_index=sWarmasterA_Dashing
          {
            xVel=dashAcc
            if currentAttack=8 //Form 1, Atk 8 (ATK H)
            {
              xVel=0
              actTime=100
            }
          }
          else if sprite_index=sWarmasterD_Dashing or sprite_index=sWarmasterD_FastDash {xVel=fastDashJumpAcc}
          else {xVel=runAcc}

          if sprite_index=sWarmasterA_JumpUp and (currentAttack=6 or currentAttack=7) //Form 1, Atk 6 (ATK F: BIG LEAP TOWARD WALL + LEAP OFF WALL)
          {
            sprite_index=sWarmasterA_WallGrabGun
            xVel=0; yVel=0
            bGravity=0
            if actTime>=105 {actTime=200}
            else {actTime=100}
          }
          else if sprite_index=sWarmasterB_Dashing //Form 2, Atk 5 (ATK E: DASH ACROSS MAP (Fire Pillars) + JUMP OFF WALL)
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
          if sprite_index=sWarmasterA_Dashing
          {
            xVel=-dashAcc
            if currentAttack=8 //Form 1, Atk 8 (ATK H)
            {
              xVel=0
              actTime=100
            }
          }
          else if sprite_index=sWarmasterD_Dashing or sprite_index=sWarmasterD_FastDash {xVel=-fastDashJumpAcc}
          else {xVel=-runAcc}

          if sprite_index=sWarmasterA_JumpUp and (currentAttack=6 or currentAttack=7) //Form 1, Atk 6 (ATK F: BIG LEAP TOWARD WALL + LEAP OFF WALL)
          {
            sprite_index=sWarmasterA_WallGrabGun
            xVel=0; yVel=0
            bGravity=0
            if actTime>=105 {actTime=200}
            else {actTime=100}
          }
          else if sprite_index=sWarmasterB_Dashing //Form 2, Atk 5 (ATK E: DASH ACROSS MAP (Fire Pillars) + JUMP OFF WALL)
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
    --waitDelay: 26 -> 19
    --atkMax: 2 -> 3
    */
    if lifePercent<=0.9 and lifePercent>=0.81 and bossProgress=0
    {
      waitDelay-=1
      backGroundFlash=1
      bossProgress+=1
    }
    else if lifePercent<=0.8 and lifePercent>=0.71 and bossProgress=1
    {
      superChangeAtk=5
      backGroundFlash=1
      bossProgress+=1
    }
    else if lifePercent<=0.7 and lifePercent>=0.61 and bossProgress=2
    {
      waitDelay-=1
      backGroundFlash=1
      bossProgress+=1
    }
    else if lifePercent<=0.6 and lifePercent>=0.51 and bossProgress=3
    {
      superChangeAtk=3
      backGroundFlash=1
      bossProgress+=1
    }
    else if lifePercent<=0.5 and lifePercent>=0.41 and bossProgress=4
    {
      waitDelay-=3
      atkMax+=1
      FASTER_CHANGE=3
      weaknessChange=1
      backGroundFlash=1
      bossProgress+=1
    }
    else if lifePercent<=0.4 and lifePercent>=0.31 and bossProgress=5
    {
      superChangeAtk=4
      backGroundFlash=1
      bossProgress+=1
    }
    else if lifePercent<=0.3 and lifePercent>=0.21 and bossProgress=6
    {
      waitDelay-=1
      backGroundFlash=101
      bossProgress+=1
    }
    else if lifePercent<=0.2 and lifePercent>=0.11 and bossProgress=7
    {
      superChangeAtk=6
      backGroundFlash=101
      bossProgress+=1
    }
    else if lifePercent<=0.1 and lifePercent>=0 and bossProgress=8
    {
      waitDelay-=1
      backGroundFlash=101
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
    bossRoomTally(64)
    global.newMapX=2920; global.newMapY=224; room_goto(rBossGallery)
  }
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
if FASTER_CHANGE=2
{
  if atkNum=1 {waitTime=waitDelay-9}
  else if atkNum>=2 {waitTime=waitDelay-7}
}
else
{
  if atkNum=1 {waitTime=waitDelay-8}
  else if atkNum>=2 {waitTime=waitDelay-6}
}
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
  waitTime=-9
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
if currentAttack=1 //==================== ATK A: SWORD SWING 1 - (Leads into Atk B) ==================== EX
{
  if EX_SWORDSWING=0
  {
    if actTime=1
    {
      sprite_index=sWarmasterA_SwingAReady; image_index=0
      actTime=2
    }
    else if actTime=4
    {
      image_index=1
      if FASTER_CHANGE>=2 {actTime=5}
    }
    else if actTime=7
    {
      image_index=2
      if FASTER_CHANGE>=2 {actTime=9}
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
      actTime=14
    }
    else if actTime=17 {image_index=1}
    else if actTime=19 {image_index=2}
    else if actTime=21
    {
      image_index=3
      with oWMA_SwordSlash {instance_destroy()}
      if FASTER_CHANGE>=2 {actTime=23}
    }
    else if actTime>=28
    {
      actTime=0
      currentAttack=2
    }
  }
  else //EX MODE
  {
    if actTime=1
    {
      image_index=0
      var tEffect;
      tEffect=instance_create(x,y-24,oEffect)
      tEffect.sprite_index=sCWM_Ef_ChargeUp; tEffect.image_speed=0.45; tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
      tEffect.newBlend=-1; tEffect.followID=id; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.xFollow=0; tEffect.yFollow=-26
      if x<oPlayer1.x
      {
        image_xscale=1.25; scaleForFacing=1
        if x>xCenter {sprite_index=sWarmasterA_SwingAReady; actTime=2} //Dash back
        else {sprite_index=sWarmasterA_SwingBReady} //Blink dash forward
      }
      else
      {
        image_xscale=-1.25; scaleForFacing=-1
        if x<xCenter {sprite_index=sWarmasterA_SwingAReady; actTime=2} //Dash back
        else {sprite_index=sWarmasterA_SwingBReady} //Blink dash forward
      }
    }
    else if actTime=3
    {
      if EX_DROPDASH=2 {actTime=10}
    }
    else if actTime=19
    {
      if sprite_index=sWarmasterA_SwingBReady //Blink dash forward
      {
        sprite_index=sWarmasterA_SwingBStrike
        x+=128*scaleForFacing
        if x>xCenter+roomSpan {x=xCenter+roomSpan-16}
        if x<xCenter-roomSpan {x=xCenter-roomSpan+16}
        actTime=100
      }
      else //Dash back
      {
        xVel=superFireDashAcc*-scaleForFacing
        actTime=40
      }
    }
    else if actTime=41
    {
      if EX_DROPDASH=2 {actTime=42}
    }
    else if actTime=45 //Strike
    {
      xVel=0
      playSound(global.snd_DeathSlash,0,1,28500)
      sprite_index=sWarmasterA_SwingAStrike; image_index=0
      var tAtk;
      tAtk=instance_create(x,y,oWMA_SwordSlash)
      tAtk.atkPower=atkPower; tAtk.image_xscale=image_xscale; tAtk.image_yscale=image_yscale
      for(i=0;i<5;i+=1)
      {
        tAtk=instance_create(x+(12*scaleForFacing),y-30-(30*i),oWMA_EX_SwordWave)
        tAtk.atkPower=atkPower
        if image_xscale<0 {tAtk.direction=180; tAtk.image_angle=180}
      }
    }
    else if actTime=47 {image_index=1}
    else if actTime=49 {image_index=2}
    else if actTime=51
    {
      image_index=3
      with oWMA_SwordSlash {instance_destroy()}
      if EX_DROPDASH=2 {actTime=52}
    }
    else if actTime=53
    {
      if EX_SWORDSWING=1 //Swing again
      {
        sprite_index=sWarmasterA_SwingAReady
        EX_SWORDSWING=2
        actTime=39
      }
      else
      {
        EX_SWORDSWING=3
        actTime=200
      }
    }
    else if actTime=101
    {
      playSound(global.snd_DeathSlash,0,1,30500)
      sprite_index=sWarmasterA_SwingBStrike; image_index=0

      tAtk=instance_create(x-(64*scaleForFacing),y-7,oWMA_GroundBomb)
      tAtk.atkPower=atkPower; tAtk.warTarget=id

      var tAtk,tWaveDir;
      tWaveDir=point_direction(x+(12*scaleForFacing),y-30,oPlayer1.x,returnPlayerYCenter())
      tAtk=instance_create(x,y,oWMA_SwordSlash)
      tAtk.atkPower=atkPower; tAtk.image_xscale=image_xscale; tAtk.image_yscale=image_yscale; tAtk.sprite_index=sWarmasterA_AtkB
    }
    else if actTime=108
    {
      image_index=1
      with oWMA_SwordSlash {instance_destroy()}
      actTime=200
    }

    if actTime>=202
    {
      if EX_DROPDASH=2 {EX_DROPDASH=0}
      EX_SWORDSWING=0
      event_user(0)
    }

    if actTime>=20 and actTime<=26 and EX_SWORDSWING=1 {instance_create(x,y,oWMA_EX_DashImage)} //Dash back effect
  }
}
else if currentAttack=2 //==================== ATK B: SWORD SWING 2 ==================== EX
{
  if actTime=1
  {
    if x<oPlayer1.x {image_xscale=1.25; scaleForFacing=1}
    else {image_xscale=-1.25; scaleForFacing=-1}
    sprite_index=sWarmasterA_SwingBReady; image_index=0
    actTime=2
  }
  else if actTime=4
  {
    image_index=1
    if FASTER_CHANGE>=2 {actTime=5}
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
    actTime=11
  }
  else if actTime=17
  {
    image_index=1
    with oWMA_SwordSlash {instance_destroy()}
    if FASTER_CHANGE>=2 {actTime=19}
  }
  else if actTime>=24
  {
    EX_SWORDSWING=!EX_SWORDSWING
    event_user(0)
  }
}
else if currentAttack=3 //==================== ATK C: DASH + JUMP SLASH ==================== EX
{
  if actTime=1
  {
    sprite_index=sWarmasterA_DashReady; image_index=0
    if FASTER_CHANGE>=2 {actTime=3}
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
    y-=2; yVel=-14
  }
  else if actTime=32 //Stop midair
  {
    bGravity=0
    xVel=0; yVel=0
    if x<oPlayer1.x {image_xscale=1.25; scaleForFacing=1}
    else {image_xscale=-1.25; scaleForFacing=-1}
    if FASTER_CHANGE>=2 {actTime=34}
  }
  else if actTime=36 //Prepare to fall
  {
    if x<oPlayer1.x {image_xscale=1.25; scaleForFacing=1}
    else {image_xscale=-1.25; scaleForFacing=-1}
    sprite_index=sWarmasterA_AirSwingA
    if FASTER_CHANGE>=2 {actTime=39}
  }
  else if actTime=43 //Strike down fast
  {
    sprite_index=sWarmasterA_GroundHit
    bGravity=1
    bGoombaStomp=0
    xVel=2.3*scaleForFacing
    yVel=9.5
  }
  else if actTime>=106
  {
    if EX_DROPDASH=0
    {
      EX_DROPDASH+=1
      event_user(0)
    }
    else
    {
      EX_SWORDSWING=1
      EX_DROPDASH=2
      actTime=0
      currentAttack=1
    }
  }
}
else if currentAttack=4 //==================== ATK D: ROPE AND BOMB (Goes into Atk E) ==================== EX
{
  if actTime=1
  {
    sprite_index=sWarmasterA_Kneel; image_index=0
    if FASTER_CHANGE>=2 {actTime=4}
  }
  else if actTime=8 //Place bomb
  {
    tAtk=instance_create(x,y-7,oWMA_GroundBomb)
    tAtk.atkPower=atkPower; tAtk.warTarget=id
    if FASTER_CHANGE>=2 {actTime=9}
  }
  else if actTime=11 //Spawn rope
  {
    sprite_index=sWarmasterA_GrabKneel
    bRope=1; ropeX=x-(10*image_xscale); ropeYscl=0
    actTime=13
  }
  else if actTime=21
  {
    sprite_index=sWarmasterA_GrappleRopeA
    if FASTER_CHANGE>=2 {actTime=22}
  }
  else if actTime=27 //Jump up
  {
    sprite_index=sWarmasterA_JumpUp
    y-=2; yVel=-12
  }
  else if actTime>=28 and actTime<=99 //Grab rope
  {
    if y<=yGround-160+sprite_height-6
    {
      bGravity=0
      sprite_index=sWarmasterA_GrappleRopeB
      actTime=106
    }
  }
  else if actTime=107
  {
    if FASTER_CHANGE>=2 {actTime=114}
  }
  else if actTime>=121
  {
    actTime=0
    currentAttack=5
  }

  if actTime>=12 and actTime<=20
  {
    ropeYscl+=0.2
  }
}
else if currentAttack=5 //==================== ATK E: SWORD ROLL ==================== EX
{
  if actTime=1
  {
    var tAtk;
    tAtk=instance_create(x,y-24,oWMA_EX_Gun); tAtk.type=0; tAtk.atkPower=atkPower //EX MODE
    sprite_index=sWarmasterA_SwordRoll; image_index=0
    var tAtk;
    tAtk=instance_create(x,y,oWMA_SwordRoll); tAtk.atkPower=atkPower; tAtk.warTarget=id
    bGravity=1
    var xRollDist;
    xRollDist=point_distance(x,0,oPlayer1.x,0)/18
    if xRollDist>14 {xRollDist=14}
    else if xRollDist<0.75 {xRollDist=0.75}
    if x<oPlayer1.x {xVel=xRollDist; image_xscale=1.25; scaleForFacing=1}
    else {xVel=-xRollDist; image_xscale=-1.25; scaleForFacing=-1}
    yVel=4.5
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
else if currentAttack=6 //==================== ATK F: BIG LEAP TOWARD WALL + LEAP OFF WALL (Needs charge) ==================== EX
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
    if FASTER_CHANGE=3 {actTime=2}
  }
  else if actTime=8 //Jump toward wall
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
    tShotDir-=12
    for(i=0;i<5;i+=1) //EX MODE
    {
      tNewAttack=instance_create(x-(28*image_xscale),y-20,oPassBullet)
      tNewAttack.sprite_index=sWarmasterA_ShotA; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=11
      tNewAttack.image_speed=0.33; tNewAttack.decayTime=-100; tNewAttack.direction=tShotDir; tNewAttack.image_angle=tShotDir
      tShotDir+=6
    }
    if FASTER_CHANGE=3 {actTime=109}
  }
  else if actTime=113 //Jump off wall
  {
    bGravity=1
    if x<xCenter {x+=2; xVel=fastDashJumpAcc}
    else {x-=2; xVel=-fastDashJumpAcc}
    yVel=-4
    sprite_index=sWarmasterA_JumpUp
    if FASTER_CHANGE=3 {actTime=116}
  }
  else if actTime=129 //Stop midair
  {
    bGravity=0
    xVel=0; yVel=0
    if x<oPlayer1.x {image_xscale=1.25; scaleForFacing=1}
    else {image_xscale=-1.25; scaleForFacing=-1}
    sprite_index=sWarmasterA_MidairCall
    var tEffect;
    tEffect=instance_create(x+(17*image_xscale),y-(27*image_yscale),oEffect)
    tEffect.sprite_index=sCWM_Ef_AtkPulse; tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    var tAtk;
    tAtk=instance_create(x,y-24,oWMA_EX_FrontBomb) //EX MODE
    tAtk.atkPower=atkPower
  }
  else if actTime=132 //Spear shots down
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
      sprite_index=sWarmasterA_ShotB; atkPower=oCHAOS_Warmaster_EX.atkPower; bulletSpeed=12
      decayTime=-100; image_speed=0.33; direction=270; tNewAttack.image_angle=270
      move_snap(8,1)
    }
  }
  else if actTime=135
  {
    sprite_index=sWarmasterA_JumpDown
    yVel=4
    bGravity=1
  }
  else if actTime>=142
  {
    event_user(0)
  }
}
else if currentAttack=7 //==================== ATK G: GUN WALL (Super only) ==================== EX
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
  }
  else if actTime=8 //Jump toward wall A
  {
    playSound(global.snd_ChargeStrike,0,0.92,32000)
    if x<xCenter {image_xscale=-1.25; scaleForFacing=-1}
    else {image_xscale=1.25; scaleForFacing=1}
    sprite_index=sWarmasterA_JumpUp
    xVel=fastDashJumpAcc*scaleForFacing
    y-=2; yVel=-14
  }
  else if actTime=104 //Spawn guns A
  {
    var tAtk,tXSpawn,tYSpawn;
    if x<xCenter {tXSpawn=xCenter-roomSpan+12}
    else {tXSpawn=xCenter+roomSpan-12}
    tYSpawn=yGround-192
    for(i=0;i<8;i+=1)
    {
      tAtk=instance_create(tXSpawn,tYSpawn+(i*20),oWMA_EX_Gun); tAtk.type=1; tAtk.shotDelay=2+(i*3)
    }
  }
  else if actTime=108 //Fire shot A
  {
    playSound(global.snd_SpearShot,0,0.98,28000)
    var tNewAttack,tShotDir;
    tShotDir=point_direction(x-(28*image_xscale),y-20,oPlayer1.x,returnPlayerYCenter())
    tShotDir-=12
    for(i=0;i<5;i+=1)
    {
      tNewAttack=instance_create(x-(28*image_xscale),y-20,oPassBullet)
      tNewAttack.sprite_index=sWarmasterA_ShotA; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=11
      tNewAttack.image_speed=0.33; tNewAttack.decayTime=-100; tNewAttack.direction=tShotDir; tNewAttack.image_angle=tShotDir
      tShotDir+=6
    }
  }
  else if actTime=111 //Jump off wall A
  {
    bGravity=1
    if x<xCenter {x+=2; xVel=fastDashJumpAcc}
    else {x-=2; xVel=-fastDashJumpAcc}
    yVel=-10
    sprite_index=sWarmasterA_JumpUp
  }
  else if actTime=204 //Spawn guns B
  {
    var tAtk,tXSpawn,tYSpawn;
    if x<xCenter {tXSpawn=xCenter-roomSpan+12}
    else {tXSpawn=xCenter+roomSpan-12}
    tYSpawn=yGround-192
    for(i=0;i<8;i+=1)
    {
      tAtk=instance_create(tXSpawn,tYSpawn+(i*20),oWMA_EX_Gun); tAtk.type=1; tAtk.shotDelay=2+(i*3)
    }
  }
  else if actTime=208 //Fire shot B
  {
    playSound(global.snd_SpearShot,0,0.98,28000)
    var tNewAttack,tShotDir;
    tShotDir=point_direction(x-(28*image_xscale),y-20,oPlayer1.x,returnPlayerYCenter())
    tShotDir-=12
    for(i=0;i<5;i+=1)
    {
      tNewAttack=instance_create(x-(28*image_xscale),y-20,oPassBullet)
      tNewAttack.sprite_index=sWarmasterA_ShotA; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=11
      tNewAttack.image_speed=0.33; tNewAttack.decayTime=-100; tNewAttack.direction=tShotDir; tNewAttack.image_angle=tShotDir
      tShotDir+=6
    }
  }
  else if actTime=211 //Jump off wall B
  {
    bGravity=1
    if x<xCenter {x+=2; xVel=fastDashJumpAcc}
    else {x-=2; xVel=-fastDashJumpAcc}
    yVel=-6
    sprite_index=sWarmasterA_JumpUp
  }
  else if actTime=220 //Stop midair
  {
    bGravity=0
    xVel=0; yVel=0
    if x<oPlayer1.x {image_xscale=1.25; scaleForFacing=1}
    else {image_xscale=-1.25; scaleForFacing=-1}
    sprite_index=sWarmasterA_MidairCall
    var tEffect;
    tEffect=instance_create(x+(17*image_xscale),y-(27*image_yscale),oEffect)
    tEffect.sprite_index=sCWM_Ef_AtkPulse; tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    var tAtk;
    tAtk=instance_create(x,y-24,oWMA_EX_FrontBomb)
    tAtk.atkPower=atkPower
  }
  else if actTime>=225
  {
    actTime=0
    currentAttack=5
  }
}
else if currentAttack=8 //==================== ATK H: TOP BOMBS (Super only) ==================== EX
{
  if actTime=1
  {
    sprite_index=sWarmasterA_DashReady; image_index=0
  }
  else if actTime=7 //Dash
  {
    playSound(global.snd_ChargeStrike,0,0.92,32000)
    sprite_index=sWarmasterA_Dashing
    xVel=superFireDashAcc*scaleForFacing
  }
  else if actTime=101 //Jump back
  {
    sprite_index=sWarmasterA_JumpDown
    if x<xCenter {x+=4; xVel=2}
    else {x-=4; xVel=-2}
    y-=2; yVel=-4
  }
  else if actTime=106
  {
    sprite_index=sWarmasterA_DashReady; image_index=0
    if x<xCenter {image_xscale=1.25; scaleForFacing=1}
    else {image_xscale=-1.25; scaleForFacing=-1}
  }
  else if actTime=111 //Dash
  {
    playSound(global.snd_ChargeStrike,0,0.92,32000)
    sprite_index=sWarmasterA_Dashing
    xVel=superFireDashAcc*scaleForFacing
  }

  if actTime>=112 and actTime<=199
  {
    if actTime mod 2=0
    {
      var tAtk;
      tAtk=instance_create(x,y-24,oWMA_EX_FrontBomb)
      tAtk.atkPower=atkPower
    }

    if (scaleForFacing=1 and x>=xCenter+roomSpan-32) or (scaleForFacing=-1 and x<=xCenter-roomSpan+32)
    {
      var tAtk;
      tAtk=instance_create(xCenter-roomSpan+24,yGround-192,oWMA_EX_Gun); tAtk.type=0
      tAtk=instance_create(xCenter+roomSpan-24,yGround-192,oWMA_EX_Gun); tAtk.type=0
      xVel=0
      event_user(0)
    }
  }
}
#define Other_12
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///FIRE FORM
if currentAttack=1 //==================== ATK A: HIT GROUND AND CAUSE FLAME PILLARS ==================== EX
{
  if EX_GROUNDHIT=0
  {
    if actTime=1
    {
      sprite_index=sWarmasterB_HitGroundA; image_index=0
      actTime=2
    }
    else if actTime=5
    {
      image_index=1
      if FASTER_CHANGE>=2 {actTime=7}
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
    else if actTime=21 {actTime=22}
    else if actTime=24 {sprite_index=sWarmasterB_HitGroundC; image_index=0}
    else if actTime=26 {image_index=1}
    else if actTime>=29
    {
      EX_GROUNDHIT=!EX_GROUNDHIT
      event_user(0)
    }
  }
  else //EX MODE
  {
    if actTime=1
    {
      sprite_index=sWarmasterB_HitGroundA; image_index=0
      var tEffect,tScaling;
      tEffect=instance_create(x,y-24,oEffect)
      tEffect.sprite_index=sCWM_Ef_ChargeUp; tEffect.image_speed=0.45; tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
      tEffect.newBlend=-1; tEffect.followID=id; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.xFollow=0; tEffect.yFollow=-26
      for(i=0;i<20;i+=1)
      {
        tScaling=0.3+random(0.2)
        tEffect=instance_create(x-7+random(14),y,oEffect)
        tEffect.sprite_index=sMMSmokeCloud; tEffect.image_alpha=0.7+random(0.2); tEffect.image_speed=0.35
        tEffect.image_xscale=tScaling; tEffect.image_yscale=tScaling
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=-1-random(2.5)
      }
      if FASTER_CHANGE>=2 {actTime=5}
    }
    else if actTime=10 {image_index=1}
    else if actTime=17 {sprite_index=sWarmasterB_HitGroundB; image_index=0}
    else if actTime=19 //Strike
    {
      playSound(global.snd_HardHit1,0,0.98,27000)
      playSound(global.snd_Flame1,0,0.99,29000)
      image_index=1
      var tAtk;
      tAtk=instance_create(x+44,y,oWMB_FirePillar); tAtk.atkPower=atkPower; tAtk.image_xscale=1.5; tAtk.image_yscale=1.5
      tAtk=instance_create(x-44,y,oWMB_FirePillar); tAtk.atkPower=atkPower; tAtk.image_xscale=1.5; tAtk.image_yscale=1.5
      tAtk=instance_create(x+88,y,oWMB_FirePillar); tAtk.atkPower=atkPower
      tAtk=instance_create(x-88,y,oWMB_FirePillar); tAtk.atkPower=atkPower
      tAtk=instance_create(x+16,y,oWMB_FireWave); tAtk.atkPower=atkPower; tAtk.damageType="EXPLOSION"; tAtk.image_xscale=1.6; tAtk.image_yscale=1.6
      tAtk=instance_create(x-16,y,oWMB_FireWave); tAtk.atkPower=atkPower; tAtk.damageType="EXPLOSION"; tAtk.image_xscale=-1.6; tAtk.image_yscale=1.6
      tAtk=instance_create(x+16,y,oWMB_FireWave); tAtk.atkPower=atkPower; tAtk.damageType="EXPLOSION"; tAtk.image_xscale=-1.3; tAtk.image_yscale=1.3
      tAtk=instance_create(x-16,y,oWMB_FireWave); tAtk.atkPower=atkPower; tAtk.damageType="EXPLOSION"; tAtk.image_xscale=1.3; tAtk.image_yscale=1.3
      tAtk=instance_create(x+16,y,oWMB_FireWave); tAtk.atkPower=atkPower; tAtk.damageType="EXPLOSION"; tAtk.image_xscale=1.1; tAtk.image_yscale=1.1
      tAtk=instance_create(x-16,y,oWMB_FireWave); tAtk.atkPower=atkPower; tAtk.damageType="EXPLOSION"; tAtk.image_xscale=-1.1; tAtk.image_yscale=1.1
    }
    else if actTime=21 {image_index=2}
    else if actTime=23 {image_index=3}
    else if actTime=25 {sprite_index=sWarmasterB_HitGroundC; image_index=0}
    else if actTime=28 {image_index=1}
    else if actTime>=29
    {
      EX_GROUNDHIT=!EX_GROUNDHIT
      event_user(0)
    }
  }
}
else if currentAttack=2 //==================== ATK B: FIRE SPAM (Needs charge) ==================== EX
{
  if actTime>=fireDuration-12 {fireFreq=3} //EX MODE

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
    actTime=3
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
    actTime=102
  }
  else if actTime=105
  {
    instance_create(x-24,yGround,oWarmasterB_MoltenRock)
    instance_create(x+24,yGround,oWarmasterB_MoltenRock)
    image_index=1
    actTime=107
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
    fireFreq=4
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
  if EX_FIREBALL=0
  {
    if actTime=1
    {
      sprite_index=sWarmasterB_ArmUpFireA; image_index=3
      if FASTER_CHANGE>=2 {actTime=3}
    }
    else if actTime=10 //Shoot fireball
    {
      playSound(global.snd_Fireball,0,0.98,24000)
      image_index=0
      var tAtk,tFireDir;
      if scaleForFacing=1 {tFireDir=0}
      else {tFireDir=180}
      tAtk=instance_create(x+(30*scaleForFacing),y-32,oPassBullet)
      tAtk.sprite_index=sWarmasterB_AtkFireballA; tAtk.atkPower=atkPower; tAtk.bulletSpeed=9
      tAtk.decayTime=-100; tAtk.damageType="EXPLOSION"; tAtk.image_speed=0.33; tAtk.direction=tFireDir; tAtk.image_angle=tFireDir

      tAtk=instance_create(x+(30*scaleForFacing),y-32,oPassBullet)
      tAtk.sprite_index=sWarmasterB_AtkFireballA; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3
      tAtk.decayTime=-100; tAtk.damageType="EXPLOSION"; tAtk.image_speed=0.33; tAtk.direction=tFireDir; tAtk.image_angle=tFireDir
      if FASTER_CHANGE>=2 {actTime=11}
    }
    else if actTime=12 {image_index=1}
    else if actTime=14 {image_index=2}
    else if actTime>=16
    {
      EX_FIREBALL=!EX_FIREBALL
      event_user(0)
    }
  }
  else //EX MODE
  {
    if actTime=1
    {
      var tEffect;
      tEffect=instance_create(x,y-24,oEffect)
      tEffect.sprite_index=sCWM_Ef_ChargeUp; tEffect.image_speed=0.45; tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
      tEffect.newBlend=-1; tEffect.followID=id; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.xFollow=0; tEffect.yFollow=-26
      sprite_index=sWarmasterB_ArmUpFireA; image_index=3
      if FASTER_CHANGE>=2 {actTime=5}
    }
    else if actTime=13 //Shoot fireball
    {
      playSound(global.snd_Fireball,0,0.98,24000)
      image_index=0
      var tAtk,tFireDir;
      if scaleForFacing=1 {tFireDir=0}
      else {tFireDir=180}
      tAtk=instance_create(x+(30*scaleForFacing),y-32,oPassBullet)
      tAtk.sprite_index=sWarmasterB_AtkFireballA; tAtk.atkPower=atkPower; tAtk.bulletSpeed=9
      tAtk.decayTime=-100; tAtk.damageType="EXPLOSION"; tAtk.image_speed=0.33; tAtk.direction=tFireDir; tAtk.image_angle=tFireDir

      tAtk=instance_create(x+(30*scaleForFacing),y-32,oPassBullet)
      tAtk.sprite_index=sWarmasterB_AtkFireballA; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3
      tAtk.decayTime=-100; tAtk.damageType="EXPLOSION"; tAtk.image_speed=0.33; tAtk.direction=tFireDir; tAtk.image_angle=tFireDir
    }
    else if actTime=15 {image_index=1}
    else if actTime=17 {image_index=2}
    else if actTime=19
    {
      image_index=3
      EX_FIREBALL+=1
      if EX_FIREBALL>=5
      {
        EX_FIREBALL=0
        event_user(0)
      }
      else {actTime=7}
    }
  }
}
else if currentAttack=4 //==================== ATK D: ZIP UP + HANG + DIVE ==================== EX
{
  if actTime=1
  {
    sprite_index=sWarmasterB_Kneel; image_index=0
    if FASTER_CHANGE>=2 {actTime=5}
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
  else if actTime=208 {sprite_index=sWarmasterB_HitGroundC; image_index=0}
  else if actTime=210 {image_index=1}
  else if actTime>=211
  {
    event_user(0)
  }
}
else if currentAttack=5 //==================== ATK E: DASH ACROSS MAP (Fire Pillars) + JUMP OFF WALL ==================== EX
{
  if actTime=1
  {
    if x<oPlayer1.x {image_xscale=1.25; scaleForFacing=1}
    else {image_xscale=-1.25; scaleForFacing=-1}
    sprite_index=sWarmasterB_DashReady; image_index=0
    if FASTER_CHANGE>=2 {actTime=3}
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
    actTime=104
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
else if currentAttack=6 //==================== ATK F: SHORT HOP + AIMED FIREBALL ==================== EX
{
  if actTime=1
  {
    sprite_index=sWarmasterB_JumpReady; image_index=0
    if FASTER_CHANGE>=2 {actTime=3}
  }
  else if actTime=8 //Jump up
  {
    var tAtk;
    for(i=0;i<25;i+=1) //EX MODE
    {
      tAtk=instance_create(176+(i*16),yGround,oWMB_EX_LowJumpFire)
      tAtk.atkPower=atkPower
    }
    sprite_index=sWarmasterB_JumpUp
    y-=2; yVel=-7
  }
  else if actTime=16 //Shoot fireball
  {
    playSound(global.snd_Fireball,0,0.98,24000)
    sprite_index=sWarmasterB_JumpFire
    var tAtk,tFireDir;
    tFireDir=point_direction(x+(21*image_xscale),y-(24*image_yscale),oPlayer1.x,returnPlayerYCenter())
    tAtk=instance_create(x+(21*image_xscale),y-(24*image_yscale),oPassBullet)
    tAtk.sprite_index=sWarmasterB_AtkFireballA; tAtk.atkPower=atkPower; tAtk.bulletSpeed=10
    tAtk.decayTime=-100; tAtk.damageType="EXPLOSION"; tAtk.image_speed=0.33; tAtk.direction=tFireDir; tAtk.image_angle=tFireDir

    tAtk=instance_create(x+(21*image_xscale),y-(24*image_yscale),oPassBullet)
    tAtk.sprite_index=sWarmasterB_AtkFireballA; tAtk.atkPower=atkPower; tAtk.bulletSpeed=2
    tAtk.decayTime=-100; tAtk.damageType="EXPLOSION"; tAtk.image_speed=0.33; tAtk.direction=tFireDir; tAtk.image_angle=tFireDir
    yVel=1
  }
  else if actTime=18 {image_index=1}
  else if actTime=20
  {
    image_index=2
    actTime=21
  }
  else if actTime>=24
  {
    event_user(0)
  }
}
else if currentAttack=7 //==================== ATK G: ZIP AND STRIKE ==================== EX
{
  if actTime=1
  {
    sprite_index=sWarmasterB_Kneel; image_index=0
  }
  else if actTime=8 //Jump up
  {
    sprite_index=sWarmasterB_ZipUpward
    y-=2; yVel=-18
  }
  else if actTime>=9 and actTime<=99 //Move toward center
  {
    if x<xCenter-8 {xVel=8}
    else if x>xCenter+8 {xVel=-8}
    else {xVel=0}
  }
  else if actTime=104
  {
    fireAng=210
    fireInc=0
  }
  else if actTime>=105 and actTime<=153 //Spray fire
  {
    if actTime mod 2=0
    {
      playSound(global.snd_Fireball,0,0.98,24000)
      tAtk=instance_create(xCenter-roomSpan+12,2,oPassBullet)
      tAtk.sprite_index=sWarmasterB_AtkFireballA; tAtk.atkPower=atkPower; tAtk.bulletSpeed=16; tAtk.image_blend=c_orange
      tAtk.decayTime=-100; tAtk.damageType="EXPLOSION"; tAtk.image_speed=0.33; tAtk.direction=270; tAtk.image_angle=270
      tAtk=instance_create(xCenter+roomSpan-12,2,oPassBullet)
      tAtk.sprite_index=sWarmasterB_AtkFireballA; tAtk.atkPower=atkPower; tAtk.bulletSpeed=16; tAtk.image_blend=c_orange
      tAtk.decayTime=-100; tAtk.damageType="EXPLOSION"; tAtk.image_speed=0.33; tAtk.direction=270; tAtk.image_angle=270
    }

    if image_index=0 {image_index=1}
    else {image_index=0}

    var tAtk;
    tAtk=instance_create(x+(8*scaleForFacing),y+3,oPassBullet)
    tAtk.sprite_index=sWarmasterB_AtkFireballA; tAtk.atkPower=atkPower; tAtk.bulletSpeed=8
    tAtk.decayTime=-100; tAtk.damageType="EXPLOSION"; tAtk.image_speed=0.33; tAtk.direction=fireAng; tAtk.image_angle=fireAng

    if fireInc=0
    {
      fireAng+=5
      if fireAng>=330 {fireInc=1}
    }
    else
    {
      fireAng-=5
      if fireAng<=210 {fireInc=0}
    }
  }
  else if actTime=155
  {
    sprite_index=sWarmasterB_HitGroundB; image_index=0
    var xRollDist;
    xRollDist=point_distance(x,0,oPlayer1.x,0)/20
    if xRollDist>14 {xRollDist=14}
    else if xRollDist<0.75 {xRollDist=0.75}
    if x<oPlayer1.x {xVel=xRollDist; image_xscale=1.25; scaleForFacing=1}
    else {xVel=-xRollDist; image_xscale=-1.25; scaleForFacing=-1}
    y+=2; yVel=7
    bGravity=1
  }
  else if actTime=161
  {
    var tAtk;
    for(i=0;i<5;i+=1)
    {
      tAtk=instance_create(xCenter-160+(i*80),y-24,oWMA_EX_FrontBomb); tAtk.atkPower=atkPower
    }
  }
  else if actTime=202
  {
    var tAtk;
    tAtk=instance_create(x,y-24,oWMA_EX_FrontBomb); tAtk.atkPower=atkPower
    image_index=2
  }
  else if actTime=204 {image_index=3}
  else if actTime=206 {image_index=4}
  else if actTime=208 {sprite_index=sWarmasterB_HitGroundC; image_index=0}
  else if actTime=210 {image_index=1}
  else if actTime=212
  {
    sprite_index=sWarmasterB_ArmUpFireA; image_index=3
    if x<oPlayer1.x {image_xscale=1.25}
    else {image_xscale=-1.25}
    if image_xscale>0 {scaleForFacing=1}
    else {scaleForFacing=-1}
  }
  else if actTime=218 //Shoot fireball
  {
    playSound(global.snd_Fireball,0,0.98,24000)
    image_index=0
    var tAtk,tFireDir;
    if scaleForFacing=1 {tFireDir=0}
    else {tFireDir=180}
    tAtk=instance_create(x+(30*scaleForFacing),y-32,oPassBullet)
    tAtk.sprite_index=sWarmasterB_AtkFireballA; tAtk.atkPower=atkPower; tAtk.bulletSpeed=9
    tAtk.decayTime=-100; tAtk.damageType="EXPLOSION"; tAtk.image_speed=0.33; tAtk.direction=tFireDir; tAtk.image_angle=tFireDir

    tAtk=instance_create(x+(30*scaleForFacing),y-32,oPassBullet)
    tAtk.sprite_index=sWarmasterB_AtkFireballA; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3
    tAtk.decayTime=-100; tAtk.damageType="EXPLOSION"; tAtk.image_speed=0.33; tAtk.direction=tFireDir; tAtk.image_angle=tFireDir
  }
  else if actTime=220 {image_index=1}
  else if actTime=222 {image_index=2}
  else if actTime=228
  {
    sprite_index=sWarmasterB_CallGun; image_index=0
    var tAtk;
    tAtk=instance_create(x,y-24,oWMA_EX_FrontBomb); tAtk.atkPower=atkPower
  }
  else if actTime=231
  {
    var tAtk,tXSpawn,tYSpawn;
    tXSpawn=xCenter-roomSpan+36
    tYSpawn=yGround-160
    for(i=0;i<8;i+=1)
    {
      tAtk=instance_create(tXSpawn+(i*48),tYSpawn,oWMA_EX_Gun); tAtk.type=1; tAtk.shotDelay=2+(i*3)
    }
  }
  else if actTime>=233
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
if currentAttack=1 //==================== ATK A: SUMMON ORBITING ICE (Needs charge) ==================== EX
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
    if FASTER_CHANGE=3 {actTime=3}
  }
  else if actTime=14 //Summon ice
  {
    sprite_index=sWarmasterC_HoverA
    var tAtk,tAngDiff;
    tAngDiff=360/orbitNum
    for(i=0;i<orbitNum;i+=1)
    {
      tAtk=instance_create(x,y-26,oWMC_IceHoverA)
      tAtk.atkPower=atkPower; tAtk.warTarget=id; tAtk.myDist=2; tAtk.myDir=i*tAngDiff; tAtk.fireDelay=30+(i*15)
    }
    if FASTER_CHANGE=3 {actTime=15}
  }
  else if actTime>=22
  {
    event_user(0)
  }
}
else if currentAttack=2 //==================== ATK B: DASH ACROSS ROOM AND SHOOT ICE SHOTS DOWN (Hover mode only) ==================== EX
{
  if actTime=1
  {
    sprite_index=sWarmasterC_JetA; image_index=0
    if FASTER_CHANGE>=2 {actTime=4}
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
    if actTime mod 6=0
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
else if currentAttack=3 //==================== ATK C: JUMP (Ground mode only) (Leads into Atk D (Dive)) ==================== EX
{
  if actTime=1 //Jump
  {
    sprite_index=sWarmasterC_SpearJump
    xVel=dashJumpAcc*scaleForFacing
    y-=2
    yVel=-14
    if FASTER_CHANGE>=2 {actTime=3}
  }
  else if actTime=13 //Lead into Dive
  {
    actTime=0
    currentAttack=4
  }
}
else if currentAttack=4 //==================== ATK D: DIVE (Ends hover mode) ==================== EX
{
  if actTime=1
  {
    sprite_index=sWarmasterC_SpearDown
    bGravity=0; hoverMode=0; numOfAtks=0
    xVel=0; yVel=0
    if FASTER_CHANGE>=2 {actTime=4}
  }
  else if actTime=10 //Dive down fast
  {
    if x<oPlayer1.x {image_xscale=1.25; scaleForFacing=1}
    else {image_xscale=-1.25; scaleForFacing=-1}
    xVel=3.3*scaleForFacing
    yVel=9
    bGravity=1
  }
  else if actTime>=106
  {
    event_user(0)
  }
}
else if currentAttack=5 //==================== ATK E: SPEAR SWIRL ==================== EX
{
  if actTime=1
  {
    sprite_index=sWarmasterC_SpearHover
    var tEffect;
    tEffect=instance_create(x,y-(27*image_yscale),oEffect)
    tEffect.sprite_index=sCWM_Ef_AtkPulse; tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    if FASTER_CHANGE>=2 {actTime=3}
  }
  else if actTime=13 //Summon spear
  {
    playSound(global.snd_LightballSpread,0,0.96,18000)
    playSound(global.snd_SpearShot,0,0.9,1)
    sprite_index=sWarmasterC_SpearSwirl
    var tAtk;
    tAtk=instance_create(x,y-27,oWMC_SpearSwirl)
    tAtk.atkPower=atkPower; tAtk.warTarget=id
    if FASTER_CHANGE>=2 {actTime=15}
  }
  else if actTime=22 //Summon spiral projectiles
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
  else if actTime=27 //Send spear toward player
  {
    oWMC_SpearSwirl.atkProg=1
    if FASTER_CHANGE>=2 {actTime=28}
  }
  else if actTime>=31
  {
    if superAtkType=3 {actTime=0; currentAttack=4}
    else {event_user(0)}
  }
}
else if currentAttack=6 //==================== ATK F: ICE SHOT TO PLAYER ==================== EX
{
  if actTime=1
  {
    if EX_ICESHOT=1
    {
      var tEffect;
      tEffect=instance_create(x,y-24,oEffect)
      tEffect.sprite_index=sCWM_Ef_ChargeUp; tEffect.image_speed=0.45; tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
      tEffect.newBlend=-1; tEffect.followID=id; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.xFollow=0; tEffect.yFollow=-26
    }

    if hoverMode=0 {sprite_index=sWarmasterC_ShootIceStand}
    else if hoverMode=1 {sprite_index=sWarmasterC_ShootIceHover}
    if EX_ICESHOT=0 {actTime=3}
  }
  else if actTime=14
  {
    if EX_ICESHOT=0
    {
      playSound(global.snd_SpearShot,0,1,27000)
      var tAtk,tIceDir;
      tIceDir=point_direction(x+(17*image_xscale),y-(28*image_yscale),oPlayer1.x,returnPlayerYCenter())
      tIceDir-=3
      for(i=0;i<3;i+=1)
      {
        tAtk=instance_create(x+(17*image_xscale),y-(28*image_yscale),oPassBullet)
        tAtk.sprite_index=sWarmasterC_IceShard; tAtk.atkPower=atkPower; tAtk.bulletSpeed=9
        tAtk.decayTime=-100; tAtk.damageType="ELEMENTAL"; tAtk.direction=tIceDir; tAtk.image_angle=tIceDir
        tIceDir+=3
      }
    }
    else //EX MODE
    {
      playSound(global.snd_SpearShot,0,1,23000)
      var tAtk,tIceDir,tIcePosX,tIcePosY,tIceSpreadStart;
      tIcePosY=yGround-8
      if x>xCenter {tIcePosX=xCenter-roomSpan+8; tIceSpreadStart=90}
      else {tIcePosX=xCenter+roomSpan-8; tIceSpreadStart=180}
      tIceDir=point_direction(x+(17*image_xscale),y-(28*image_yscale),tIcePosX,tIcePosY)
      tAtk=instance_create(x+(17*image_xscale),y-(28*image_yscale),oWMC_EX_SpreadShot)
      tAtk.atkPower=atkPower; tAtk.bulletSpeed=7 tAtk.posX=tIcePosX; tAtk.posY=tIcePosY; tAtk.spreadDir=tIceSpreadStart; tAtk.direction=tIceDir
    }
  }
  else if actTime>=20
  {
    EX_ICESHOT=!EX_ICESHOT
    event_user(0)
  }
}
else if currentAttack=7 //==================== ATK G: ICE BLOCKS ==================== EX
{
  if actTime=1
  {
    playSound(global.snd_OrbThrow,0,0.97,29000)
    if hoverMode=0 {sprite_index=sWarmasterC_ShootIceStand}
    else if hoverMode=1 {sprite_index=sWarmasterC_ShootIceHover}

    var tAtk,tMyXPlace;
    if x<xCenter
    {
      tMyXPlace=176
      tAtk=instance_create(560,96,oWMC_IceBlock)
      tAtk.atkPower=atkPower; tAtk.xPlace=560; tAtk.yPlace=96; tAtk.warTarget=id
    }
    else
    {
      tMyXPlace=336
      tAtk=instance_create(176,96,oWMC_IceBlock)
      tAtk.atkPower=atkPower; tAtk.xPlace=176; tAtk.yPlace=96; tAtk.warTarget=id
    }
    for(i=0;i<8;i+=1)
    {
      tAtk=instance_create(tMyXPlace+(i*32),96,oWMC_IceBlock)
      tAtk.atkPower=atkPower; tAtk.xPlace=tMyXPlace+(i*32); tAtk.yPlace=96; tAtk.warTarget=id
    }
    if FASTER_CHANGE>=2 {actTime=3}
  }
  else if actTime>=16
  {
    event_user(0)
  }
}
else if currentAttack=8 //==================== ATK H: JUMP UP + SPREAD ATTACK (Ground mode only) (Starts hover mode) ==================== EX
{
  if actTime=1
  {
    sprite_index=sWarmasterC_JumpReady
    if FASTER_CHANGE>=2 {actTime=4}
  }
  else if actTime=15
  {
    playSound(global.snd_LightballSpread,0,0.95,28000)
    playSound(global.snd_CShotA,0,0.93,44100)
    sprite_index=sWarmasterC_JumpUp
    y-=2; yVel=-11
    tAtk=instance_create(x+16,y,oWMB_FireWave); tAtk.atkPower=atkPower; tAtk.damageType="ELEMENTAL"; tAtk.image_blend=c_blue
    tAtk=instance_create(x-16,y,oWMB_FireWave); tAtk.atkPower=atkPower; tAtk.damageType="ELEMENTAL"; tAtk.image_blend=c_blue; tAtk.image_xscale=-1
  }
  else if actTime=24
  {
    if superAtkType=0 or superAtkType=3 {hoverMode=1; numOfAtks=0}
    var tAtk,tIceDir;
    tIceDir=0
    for(i=0;i<16;i+=1)
    {
      tAtk=instance_create(x,y-29,oPassBullet)
      tAtk.sprite_index=sWarmasterC_IceShard; tAtk.atkPower=atkPower; tAtk.bulletSpeed=7
      tAtk.decayTime=-100; tAtk.damageType="ELEMENTAL"; tAtk.direction=tIceDir; tAtk.image_angle=tIceDir
      tIceDir+=360/16
    }
    if FASTER_CHANGE>=2 {actTime=25}
  }
  else if actTime>=28
  {
    if superAtkType=1
    {
      actTime=0
      ATTACK_FORM=1
      event_user(5)
      currentAttack=5
    }
    else if superAtkType=3
    {
      actTime=0
      currentAttack=10
    }
    else {event_user(0)}
  }
}
else if currentAttack=9 //==================== ATK I: ICE SHOT TO CEILING AND BREAK ==================== EX
{
  if actTime=1
  {
    if hoverMode=0 {sprite_index=sWarmasterC_ShootIceStand}
    else if hoverMode=1 {sprite_index=sWarmasterC_ShootIceHover}
    if FASTER_CHANGE>=2 {actTime=6}
  }
  else if actTime=17
  {
    playSound(global.snd_IceShot,0,1,20000)
    var tAtk;
    tAtk=instance_create(x+(17*image_xscale),y-(27*image_yscale),oWMC_IceShotB)
    tAtk.atkPower=atkPower; tAtk.bulletSpeed=11; tAtk.warTarget=id
    tAtk.type=1; tAtk.direction=90
    actTime=18
  }
  else if actTime>=24
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
else if currentAttack=10 //==================== ATK I: ICE SHOT TO CEILING AND BREAK ==================== EX
{
  if actTime=1
  {
    var tEffect;
    tEffect=instance_create(x,y-24,oEffect)
    tEffect.sprite_index=sCWM_Ef_ChargeUp; tEffect.image_speed=0.45; tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
    tEffect.newBlend=-1; tEffect.followID=id; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.xFollow=0; tEffect.yFollow=-26
    sprite_index=sWarmasterC_ShootIceHover
  }
  else if actTime=15
  {
    playSound(global.snd_SpearShot,0,1,23000)
    var tAtk,tIceDir,tIcePosX,tIcePosY,tIceSpreadStart;
    tIcePosY=yGround-8
    tIcePosX=xCenter-roomSpan+8; tIceSpreadStart=90
    tIceDir=point_direction(x+(17*image_xscale),y-(28*image_yscale),tIcePosX,tIcePosY)
    tAtk=instance_create(x+(17*image_xscale),y-(28*image_yscale),oWMC_EX_SpreadShot)
    tAtk.atkPower=atkPower; tAtk.bulletSpeed=7 tAtk.posX=tIcePosX; tAtk.posY=tIcePosY; tAtk.spreadDir=tIceSpreadStart; tAtk.direction=tIceDir
  }
  else if actTime=16
  {
    playSound(global.snd_SpearShot,0,1,23000)
    var tAtk,tIceDir,tIcePosX,tIcePosY,tIceSpreadStart;
    tIcePosY=yGround-8
    tIcePosX=xCenter+roomSpan-8; tIceSpreadStart=180
    tIceDir=point_direction(x+(17*image_xscale),y-(28*image_yscale),tIcePosX,tIcePosY)
    tAtk=instance_create(x+(17*image_xscale),y-(28*image_yscale),oWMC_EX_SpreadShot)
    tAtk.atkPower=atkPower; tAtk.bulletSpeed=7 tAtk.posX=tIcePosX; tAtk.posY=tIcePosY; tAtk.spreadDir=tIceSpreadStart; tAtk.direction=tIceDir
  }
  else if actTime=18
  {
    playSound(global.snd_SpearShot,0,1,23000)
    var tAtk,tIceDir,tIcePosX,tIcePosY,tIceSpreadStart;
    tIcePosY=yGround-8
    tIcePosX=xCenter-roomSpan+8; tIceSpreadStart=90
    tIceDir=point_direction(x+(17*image_xscale),y-(28*image_yscale),tIcePosX,tIcePosY)
    tAtk=instance_create(x+(17*image_xscale),y-(28*image_yscale),oWMC_EX_SpreadShot)
    tAtk.atkPower=atkPower; tAtk.bulletSpeed=7 tAtk.posX=tIcePosX; tAtk.posY=tIcePosY; tAtk.spreadDir=tIceSpreadStart; tAtk.direction=tIceDir
  }
  else if actTime=19
  {
    playSound(global.snd_SpearShot,0,1,23000)
    var tAtk,tIceDir,tIcePosX,tIcePosY,tIceSpreadStart;
    tIcePosY=yGround-8
    tIcePosX=xCenter+roomSpan-8; tIceSpreadStart=180
    tIceDir=point_direction(x+(17*image_xscale),y-(28*image_yscale),tIcePosX,tIcePosY)
    tAtk=instance_create(x+(17*image_xscale),y-(28*image_yscale),oWMC_EX_SpreadShot)
    tAtk.atkPower=atkPower; tAtk.bulletSpeed=7 tAtk.posX=tIcePosX; tAtk.posY=tIcePosY; tAtk.spreadDir=tIceSpreadStart; tAtk.direction=tIceDir
  }
  else if actTime>=24
  {
    actTime=0
    currentAttack=5
  }
}
#define Other_14
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///WIND FORM
if currentAttack=1 //==================== ATK A: DASH FORWARD ==================== EX
{
  if EX_TOPGUNS<=1
  {
    if actTime=1
    {
      sprite_index=sWarmasterD_DashReady; image_index=0
      if FASTER_CHANGE>=2 {actTime=2}
    }
    else if actTime=9 //Dash
    {
      playSound(global.snd_ChargeStrike,0,0.92,35000)
      sprite_index=sWarmasterD_Dashing
      dashEfFrm=0; dashEfType=1
      xVel=(fastDashJumpAcc+1)*scaleForFacing
      var tAtk;
      tAtk=instance_create(x,yGround,oWMD_TornadoB); tAtk.atkPower=atkPower
    }
    else if actTime>=11 and actTime<=22 //Check if passed up player
    {
      if scaleForFacing>0 //Right
      {
        if x+4>oPlayer1.x
        {
          xVel=0
          altUppercut=1
          actTime=0
          EX_TOPGUNS+=1
          if EX_TOPGUNS>=2 and instance_number(oWMD_EX_Top)>=3 {EX_TOPGUNS=1}
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
          EX_TOPGUNS+=1
          if EX_TOPGUNS>=2 and instance_number(oWMD_EX_Top)>=3 {EX_TOPGUNS=1}
          currentAttack=2
        }
      }
    }
    else if actTime>=24
    {
      xVel=0
      EX_TOPGUNS+=1
      if EX_TOPGUNS>=2 and instance_number(oWMD_EX_Top)>=3 {EX_TOPGUNS=1}
      event_user(0)
    }
  }
  else //EX MODE
  {
    if actTime=1
    {
      sprite_index=sWarmasterD_SummonOrb; image_index=0
      var tEffect;
      tEffect=instance_create(x+(17*image_xscale),y-(27*image_yscale),oEffect)
      tEffect.sprite_index=sCWM_Ef_ShotPulse; tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      if FASTER_CHANGE>=2 {actTime=3}
    }
    else if actTime=18
    {
      sprite_index=sWarmasterD_Idle
      with oWMD_EX_Top
      {
        var tEffect;
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sRobotExplosion; tEffect.image_xscale=0.7; tEffect.image_yscale=0.7
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        instance_destroy()
      }
      for(i=0;i<4;i+=1)
      {
        var tAtk;
        tAtk=instance_create(224+(i*96),-4,oWMD_EX_Top)
        tAtk.atkPower=atkPower
      }
    }
    else if actTime>=22
    {
      EX_TOPGUNS=0
      event_user(0)
    }
  }
}
else if currentAttack=2 //==================== ATK B: UPPERCUT ==================== EX
{
  if actTime=1
  {
    sprite_index=sWarmasterD_DashUpReady; image_index=0
    if x<oPlayer1.x {image_xscale=1.25; scaleForFacing=1}
    else {image_xscale=-1.25; scaleForFacing=-1}
    if FASTER_CHANGE>=2 {actTime=2}
  }
  else if actTime=5 //Jump
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
      actTime=27
    }
    else
    {
      actTime=23
    }
  }
  else if actTime=28
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
    actTime=3
    if altUppercut=2
    {
      actTime=10
    }
  }
  else if actTime=21
  {
    playSound(global.snd_WindBlow,0,1,1)
    sprite_index=sWarmasterD_TornSummonB
    var tAtk,tTornadoSpd;
    if altUppercut=2 {tTornadoSpd=5.5}
    else {tTornadoSpd=7.5}
    tAtk=instance_create(x+28,yGround,oWMD_TornadoA)
    tAtk.atkPower=atkPower; tAtk.moveSpd=tTornadoSpd; tAtk.fadeSpd=0.01
    tAtk=instance_create(x-28,yGround,oWMD_TornadoA)
    tAtk.atkPower=atkPower; tAtk.moveSpd=-tTornadoSpd; tAtk.fadeSpd=0.01
    actTime=25
  }
  else if actTime=33
  {
    bGravity=1; yVel=2
    if altUppercut=2
    {
      actTime=0
      currentAttack=4
      if EX_WINDSHOT=0 {altUppercut=0}
      else
      {
        bGravity=0; yVel=0
      }
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
      altUppercut=0
    }
  }
}
else if currentAttack=4 //==================== ATK D: SHOOT WIND SHOT ==================== EX
{
  if EX_WINDSHOT=1 and altUppercut=2 //EX MODE
  {
    if actTime=1
    {
      sprite_index=sWarmasterD_WindShotAir; image_index=0
      var tEffect;
      tEffect=instance_create(x+(17*image_xscale),y-(27*image_yscale),oEffect)
      tEffect.sprite_index=sCWM_Ef_ShotPulse; tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      tEffect=instance_create(x,y-24,oEffect)
      tEffect.sprite_index=sCWM_Ef_ChargeUp; tEffect.image_speed=0.45; tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
      tEffect.newBlend=-1; tEffect.followID=id; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.xFollow=0; tEffect.yFollow=-26
    }
    else if actTime=14
    {
      playSound(global.snd_Wave,0,0.97,13000)
      var tAtk,tWindDir,tAltSpd;
      tWindDir=point_direction(x+(17*image_xscale),y-(28*image_yscale),oPlayer1.x,returnPlayerYCenter())
      tAltSpd=0
      for(i=0;i<20;i+=1)
      {
        if i mod 2=0 {tAltSpd=1}
        else {tAltSpd=0}
        tAtk=instance_create(x+(17*image_xscale),y-(27*image_yscale),oPassBullet)
        tAtk.sprite_index=sWarmasterD_AtkWindA; tAtk.atkPower=atkPower; tAtk.bulletSpeed=6+tAltSpd
        tAtk.decayTime=-100; tAtk.damageType="ELEMENTAL"; tAtk.direction=tWindDir; tAtk.image_angle=tWindDir
        tWindDir+=18
      }
    }
    else if actTime>=16
    {
      bGravity=1; yVel=2
      EX_WINDSHOT=0
      altUppercut=0
      event_user(0)
    }
  }
  else
  {
    if actTime=1
    {
      sprite_index=sWarmasterD_WindShotAir; image_index=0
      var tEffect;
      tEffect=instance_create(x+(17*image_xscale),y-(27*image_yscale),oEffect)
      tEffect.sprite_index=sCWM_Ef_ShotPulse; tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      if FASTER_CHANGE>=2 {actTime=3}
    }
    else if actTime=11
    {
      playSound(global.snd_Wave,0,0.97,16000)
      var tAtk,tWindDir;
      tWindDir=point_direction(x+(17*image_xscale),y-(28*image_yscale),oPlayer1.x,returnPlayerYCenter())
      tWindDir-=4
      for(i=0;i<3;i+=1)
      {
        tAtk=instance_create(x+(17*image_xscale),y-(27*image_yscale),oPassBullet)
        tAtk.sprite_index=sWarmasterD_AtkWindA; tAtk.atkPower=atkPower; tAtk.bulletSpeed=6
        tAtk.decayTime=-100; tAtk.damageType="ELEMENTAL"; tAtk.direction=tWindDir; tAtk.image_angle=tWindDir
        tWindDir+=4
      }
      actTime=12
    }
    else if actTime=14
    {
      if y>yGround-3 {sprite_index=sWarmasterD_Idle}
      else {sprite_index=sWarmasterD_Hover}
      actTime=15
    }
    else if actTime>=17
    {
      EX_WINDSHOT=1
      event_user(0)
    }
  }
}
else if currentAttack=5 //==================== ATK E: SUPER DIVE ==================== EX
{
  if actTime=1
  {
    sprite_index=sWarmasterD_FastDash; image_index=0
    if FASTER_CHANGE>=2 {actTime=3}
  }
  else if actTime=7
  {
    playSound(global.snd_ChargeStrike,0,0.92,44100)
    playSound(global.snd_LightballSpread,0,0.8,44100)
    bGravity=1
    dashEfFrm=0; dashEfType=1
    var yDiveSpd;
    yDiveSpd=point_distance(x,0,oPlayer1.x,0)/20
    if yDiveSpd>10 {yDiveSpd=11}
    else if yDiveSpd<5 {yDiveSpd=6}
    if x<oPlayer1.x {yVel=yDiveSpd; image_xscale=1.25; scaleForFacing=1}
    else {yVel=-yDiveSpd; image_xscale=-1.25; scaleForFacing=-1}
    xVel=(fastDashJumpAcc+1)*scaleForFacing
  }
  else if actTime>=105
  {
    event_user(0)
  }
}
else if currentAttack=6 //==================== ATK F: SWORD SWING 1 - (Leads into Atk G) ==================== EX
{
  if EX_SWIRLGUN=0
  {
    if actTime=1
    {
      sprite_index=sWarmasterD_SwingAReady; image_index=0
      if FASTER_CHANGE>=2 {actTime=4}
    }
    else if actTime=10 //Strike
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
      if FASTER_CHANGE>=2 {actTime=11}
    }
    else if actTime=14
    {
      image_index=1
      with oWMD_SwordSlash {instance_destroy()}
      if FASTER_CHANGE>=2 {actTime=15}
    }
    else if actTime>=18
    {
      EX_SWIRLGUN=1
      actTime=0
      currentAttack=7
    }
  }
  else //EX MODE
  {
    if actTime=1
    {
      sprite_index=sWarmasterD_DashUpReady; image_index=0
      if x<oPlayer1.x {image_xscale=1.25; scaleForFacing=1}
      else {image_xscale=-1.25; scaleForFacing=-1}
      if FASTER_CHANGE>=2 {actTime=2}
    }
    else if actTime=4 //Jump
    {
      playSound(global.snd_LightballSpread,0,0.93,32000)
      playSound(global.snd_WindBlow,0,0.93,44100)
      sprite_index=sWarmasterD_DashingUp
      dashEfFrm=0; dashEfType=2
      xVel=(runAcc-1)*scaleForFacing
      y-=2
      yVel=-14
    }
    else if actTime=10 //Hover
    {
      var tEffect;
      tEffect=instance_create(x+(17*image_xscale),y-(27*image_yscale),oEffect)
      tEffect.sprite_index=sCWM_Ef_ShotPulse; tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      xVel=0; yVel=0
      bGravity=0
      sprite_index=sWarmasterD_Hover
      var tAtk,tDir;
      tDir=0
      for(i=0;i<24;i+=1)
      {
        tAtk=instance_create(x,y,oWMD_EX_SpinTop)
        tAtk.atkPower=atkPower; tAtk.myDir=tDir; tAtk.atkTime=i
        tDir+=15
      }
    }
    else if actTime=42 {bGravity=1}
    else if actTime>=44
    {
      EX_SWIRLGUN=0
      event_user(0)
    }
  }
}
else if currentAttack=7 //==================== ATK G: SWORD SWING 2 - (Leads into Atk H) ==================== EX
{
  if actTime=1
  {
    if x<oPlayer1.x {image_xscale=1.25; scaleForFacing=1}
    else {image_xscale=-1.25; scaleForFacing=-1}
    sprite_index=sWarmasterD_SwingBReady; image_index=0
    if FASTER_CHANGE>=2 {actTime=3}
  }
  else if actTime=8 //Strike
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
    if FASTER_CHANGE>=2 {actTime=10}
  }
  else if actTime=12
  {
    image_index=1
    with oWMD_SwordSlash {instance_destroy()}
    if FASTER_CHANGE>=2 {actTime=13}
  }
  else if actTime>=16
  {
    actTime=0
    currentAttack=8
  }
}
else if currentAttack=8 //==================== ATK H: SWORD SWING 3 ==================== EX
{
  if actTime=1
  {
    if x<oPlayer1.x {image_xscale=1.25; scaleForFacing=1}
    else {image_xscale=-1.25; scaleForFacing=-1}
    sprite_index=sWarmasterD_SwingCReady; image_index=0
    if FASTER_CHANGE>=2 {actTime=3}
  }
  else if actTime=8 //Strike
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
    if FASTER_CHANGE>=2 {actTime=9}
  }
  else if actTime=11
  {
    image_index=1
    with oWMD_SwordSlash {instance_destroy()}
    if FASTER_CHANGE>=2 {actTime=13}
  }
  else if actTime>=16
  {
    event_user(0)
  }
}
else if currentAttack=9 //==================== ATK I: SUMMON SEEKER ORB (Needs charge) ==================== EX
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
    if FASTER_CHANGE=3 {actTime=3}
  }
  else if actTime=11
  {
    playSound(global.snd_OrbThrow,0,0.9,16000)
    playSound(global.snd_WindBlow,0,0.8,17000)
    with oWMD_SeekerOrb {instance_destroy()}
    var tAtk;
    tAtk=instance_create(x,y-68,oWMD_SeekerOrb)
    tAtk.atkPower=atkPower
    if FASTER_CHANGE=3 {actTime=12}
  }
  else if actTime=17
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
    EX_MODE=1
    bOrbit=0
    moveProg=2
    moveTime=fireDelay-5
  }
}

if superChangeAtk=0 //If Warmaster was about to attack, set back attack timer
{
  if waitTime>=waitDelay-15 {waitTime=waitDelay-15}
}

bGravity=1; hoverMode=0
currHspd=0; currVspd=0
tornadoNum=0

var tEffect;
tEffect=instance_create(x,y-(27*image_yscale),oEffect)
tEffect.sprite_index=sCWM_Ef_AtkPulse; tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
shiftTime=0; shiftDamage=0
if ATTACK_FORM=1
{
  sprite_index=sWarmasterA_Idle
  jeremyText="This variation of the Warmaster has him in his turbo mode for the entire duration of the fight. Other alterations are dealing slightly more damage and HP, and having more attacks. You have a modification too, your dash recovery is faster for this fight."
  chaoText="Can you imagine the reaction people would have had if this was the original version of the fight? Oh right, helpful tips. Uh, his weaknesses are the same as the original encounter, but after half of his HP is depleted, his weaknesses change to the original fight's final phase variant."
  for(i=0;i<6;i+=1)
  {
    resType[i]=3
  }
  if weaknessChange=0 {resType[1]=2; resType[2]=1; resType[3]=1; resType[4]=2; resType[5]=1}
  else {resType[1]=1; resType[2]=1; resType[3]=1; resType[4]=2; resType[5]=1}
  if shiftType=0 {shiftDmgMax=42; shiftMaxTime=750}
  else {shiftDmgMax=30; shiftMaxTime=660}
}
else if ATTACK_FORM=2
{
  sprite_index=sWarmasterB_Idle
  jeremyText="I think the two most notable changes are his short hop fireball attack will now cause the entire floor to get a mini fire pillar attack, so be ready for that. The other would be his standing ground pound. Every other time he performs that, it'll have much larger range."
  for(i=0;i<6;i+=1)
  {
    resType[i]=3
  }
  if weaknessChange=0 {resType[0]=2; resType[3]=1; resType[4]=1; resType[5]=2}
  else {resType[0]=1; resType[1]=1; resType[3]=1; resType[4]=1; resType[5]=1}
  if shiftType=0 {shiftDmgMax=81; shiftMaxTime=750}
  else {shiftDmgMax=60; shiftMaxTime=660}
}
else if ATTACK_FORM=3
{
  bGoombaStomp=1; goombaStompTime=15
  numOfAtks=0
  sprite_index=sWarmasterC_Idle
  jeremyText="He's even more spammy this time. Biggest change that you should be aware of would be his twirling spear now stops projectiles. Another big change is the super attack lingering after a form change. Each ice shot no longer targets you, but they now target directly from Warmaster himself, which will cause a much larger circle of ice shots aiming."
  for(i=0;i<6;i+=1)
  {
    resType[i]=3
  }
  if weaknessChange=0 {resType[0]=1; resType[1]=1; resType[2]=1; resType[5]=2}
  else {resType[0]=1; resType[1]=1; resType[2]=1; resType[4]=1; resType[5]=1}
  if shiftType=0 {shiftDmgMax=132; shiftMaxTime=750}
  else {shiftDmgMax=90; shiftMaxTime=660}
}
else if ATTACK_FORM=4
{
  sprite_index=sWarmasterD_Idle
  jeremyText="He's mostly the same here, but again there are two major things to note. His attacks linger just a bit longer and he's much much faster. Wind form really earns its name."
  for(i=0;i<6;i+=1)
  {
    resType[i]=3
  }
  if weaknessChange=0 {resType[0]=1; resType[1]=1; resType[2]=2; resType[4]=2}
  else {resType[0]=1; resType[1]=1; resType[2]=1; resType[3]=1; resType[4]=1}
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
      if atkInSequence=0 or atkInSequence=1
      {
        tornadoNum=0
        currentAttack=6
      }
      else
      {
        tornadoNum+=1
        currentAttack=2
      }
    }
    else //-- Player is far --
    {
      if atkInSequence=0 or atkInSequence=1
      {
        tornadoNum=0
        currentAttack=1
      }
      else
      {
        tornadoNum=0
        currentAttack=4
      }
    }
  }
  else if atkNum=1 //----- Second attack -----
  {
    if superCharge<superMax
    {
      if point_distance(x,y-29,oPlayer1.x,returnPlayerYCenter())<128 //-- Player is close --
      {
        if atkInSequence=0 or atkInSequence=1
        {
          tornadoNum+=1
          if tornadoNum<=2 {currentAttack=3}
          else {tornadoNum=0; currentAttack=6}
        }
        else {tornadoNum=0; currentAttack=4}
      }
      else //-- Player is far --
      {
        if atkInSequence=0 or atkInSequence=1
        {
          tornadoNum+=1
          if tornadoNum<=2 {currentAttack=1}
          else {tornadoNum=0; currentAttack=4}
        }
        else {tornadoNum=0; currentAttack=6}
      }
    }
    else {currentAttack=9; superCharge=0}
  }
  else if atkNum>=2 //----- Third attack -----
  {
    if point_distance(x,y-29,oPlayer1.x,returnPlayerYCenter())<128 //-- Player is close --
    {
      if atkInSequence=0 or atkInSequence=1 {tornadoNum=0; currentAttack=1}
      else
      {
        tornadoNum+=1
        if tornadoNum<=1 {currentAttack=3}
        else {tornadoNum=0; currentAttack=6}
      }
    }
    else //-- Player is far --
    {
      if atkInSequence=0 or atkInSequence=1
      {
        if oPlayer1.attackState=0 {tornadoNum=0; currentAttack=4}
        else
        {
          tornadoNum+=1
          if tornadoNum<=1 {currentAttack=3}
          else {tornadoNum=0; currentAttack=6}
        }
      }
      else
      {
        tornadoNum+=1
        if tornadoNum<=2 {currentAttack=2}
        else {tornadoNum=0; currentAttack=4}
      }
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
if ATTACK_FORM=1 //======================================== MAIN FORM ========================================
{
  if other.damageType="NORMAL"
  {
    if timeTillLastHit<=25 {shiftDamage+=5; shiftTime+=5}
    else {shiftDamage+=3; shiftTime+=3}
  }
  else
  {
    if timeTillLastHit<=25 {shiftDamage+=3; shiftTime+=3}
    else {shiftDamage+=2; shiftTime+=2}
  }

  if image_xscale>0
  {

  }
  else
  {

  }
}
else if ATTACK_FORM=2 //======================================== FIRE FORM ========================================
{
  if other.damageType="PIERCE" or other.damageType="ELEMENTAL"
  {
    if timeTillLastHit<=25 {shiftDamage+=5; shiftTime+=5}
    else {shiftDamage+=3; shiftTime+=3}
    if other.weaponTag=32 {shiftDamage+=2; shiftTime+=2}
  }
  else
  {
    if timeTillLastHit<=25 {shiftDamage+=3; shiftTime+=3}
    else {shiftDamage+=2; shiftTime+=2}
  }
}
else if ATTACK_FORM=3 //======================================== ICE FORM ========================================
{
  if other.damageType="SHOT" or other.damageType="EXPLOSION"
  {
    if timeTillLastHit<=25 {shiftDamage+=3; shiftTime+=3}
    else {shiftDamage+=5; shiftTime+=5}
  }
  else
  {
    if timeTillLastHit<=25 {shiftDamage+=3; shiftTime+=3}
    else {shiftDamage+=2; shiftTime+=2}
  }
}
else if ATTACK_FORM=4 //======================================== WIND FORM ========================================
{
  if other.damageType="SPECIAL"
  {
    if timeTillLastHit<=25 {shiftDamage+=5; shiftTime+=5}
    else {shiftDamage+=3; shiftTime+=3}
  }
  else
  {
    if timeTillLastHit<=25 {shiftDamage+=3; shiftTime+=3}
    else {shiftDamage+=2; shiftTime+=2}
  }
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

//DELETE
/*
draw_set_color(c_red)
draw_set_alpha(1)
draw_set_font(fnt_EnemyName)
draw_set_halign(fa_center)
draw_text(x,y-72,tornadoNum)
