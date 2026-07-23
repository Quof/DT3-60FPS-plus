#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-16,-70,16,-1)
image_speed=0
image_xscale=-1
global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]

//Enemy base statistics
eName="Sephiroth"
eLevel=30
maxLife=24500
life=maxLife
atkPower=10
stunResist=50
affiliation=9
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
bCanBeBlocked=1
bParryOpp=0
blockCost=100

//-- Movement Data --
moveSpd=2.5

//-- Attack Data --
atkNum=0 //current attack in string
atkMax=2 //max attacks in a string
waitTime=5
waitDelay=30 //idle time between attack strings
actTime=0 //progress in an action
bSwing=0 //if swing in progress
currentAtk=-1
actCheck=0 //choosing an action
bFaster=0 //speed up attacks slightly
bFastAtk=0 //if forcing a faster attack
altAtk=0
meteor=0
metStormFreq=3
meteorTime=70
meteorFreq=8
xSpot=0

//-- Misc Data --
xCenter=384
yGround=288
roomSpan=208

lightRays=0
rayAlpha=1
deathAnim=0

jeremyText="This guy is fast and strings attacks together fast. You can parry him, Claire, but don't attempt to block direct contact with him, he'll nearly break your shield. Unfortunately, I'm already seeing that he's going to eventually become immune to your attack, Jerry. You can parry his meteors though."
chaoText="His teleporting can be bothersome. Note that if you're near the sides when he teleports, that he'll usually attempt to teleport right on you. When he teleports to summon the meteors, remember where he teleported from, since that's where he'll return to."
devText="Why? Because I can. Anyway, I set out to create another duel within the DT mechanics. One of the big reasons why the dash is regained late in Gate 6 is for this fight."
extraInfo="Attacks very fast."
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
    showBossHP=instance_create(0,0,oBossLifeDisplay)
    showBossHP.bossID=id
    showBossHP.type=0
    activateBoss=2
  }

  if bActive=true and life>0
  {
    //---------- MOVEMENT ----------
    if sprite_index=sSeph_Idle
    {
      if x>oPlayer1.x {image_xscale=-1}
      else {image_xscale=1}
      image_index+=0.2
    }

    if meteor<metStormFreq
    {
      waitTime+=1
      if waitTime>=waitDelay
      {
        if actCheck=0 //---------- Choose an action ----------
        {
          if atkNum=0 //----- First attack -----
          {
            if point_distance(x,0,oPlayer1.x,0)<80 //-- Player is close --
            {
              if oPlayer1.attackState=0 //Player is not attacking
              {
                actCheck=10
                currentAtk=0
              }
              else //Player is attacking
              {
                actCheck=2
              }
            }
            else //-- Player is far --
            {
              if oPlayer1.attackState=0 //Player is not attacking
              {
                actCheck=10
                currentAtk=2
              }
              else //Player is attacking
              {
                actCheck=3
              }
            }
          }
          else if atkNum=1 //----- Second attack -----
          {
            if point_distance(x,0,oPlayer1.x,0)<80 //-- Player is close --
            {
              if oPlayer1.attackState=0 //Player is not attacking
              {
                actCheck=10
                currentAtk=1
              }
              else //Player is attacking
              {
                actCheck=1
              }
            }
            else //-- Player is far --
            {
              if oPlayer1.attackState=0 //Player is not attacking
              {
                actCheck=3
              }
              else //Player is attacking
              {
                actCheck=1
              }
            }
          }
          else if atkNum>=1 //----- 3rd and 4th attack -----
          {
            if point_distance(x,0,oPlayer1.x,0)<80 //-- Player is close --
            {
              if oPlayer1.attackState=0 //Player is not attacking
              {
                bFastAtk=1
                actCheck=1
              }
              else //Player is attacking
              {
                actCheck=10
                currentAtk=1
              }
            }
            else //-- Player is far --
            {
              if oPlayer1.attackState=0 //Player is not attacking
              {
                altAtk=2
                actCheck=1
              }
              else //Player is attacking
              {
                altAtk=1
                actCheck=3
              }
            }
          }
        }
        else if actCheck=1 //---------- Jump ----------
        {
          actTime+=1
          if actTime=1
          {
            xVel=3*image_xscale
            y-=2
            yVel=-9
            sprite_index=sSeph_Jump
          }
          else if actTime>=10
          {
            actTime=0
            actCheck=10
            if altAtk=0 {currentAtk=3}
            else {actCheck=3}
          }
        }
        else if actCheck=2 //---------- Dash back ----------
        {
          actTime+=1
          if actTime=1
          {
            xVel=4*-image_xscale
            sprite_index=sSeph_DashBack
            if bFastAtk=1 {actTime=4}
          }
          else if actTime>=10
          {
            xVel=0
            actTime=0
            actCheck=10
            currentAtk=1
          }
        }
        else if actCheck=3 //---------- Teleport ----------
        {
          actTime+=1
          if actTime=1
          {
            sprite_index=sSeph_Teleport
            bCanTakeDamage=false
            image_alpha-=0.25
          }
          else if actTime>=2 and actTime<=4 {image_alpha-=0.25}
          else if actTime=8
          {
            if altAtk<=1 {x=oPlayer1.x+(48*-oPlayer1.image_xscale)}
            else {x=oPlayer1.x+(48*oPlayer1.image_xscale)}
            if x>oPlayer1.x {image_xscale=-1}
            else {image_xscale=1}
            if x>xCenter+roomSpan-24 {x=xCenter+roomSpan-24}
            if x<xCenter-roomSpan+24 {x=xCenter-roomSpan+24}
          }
          else if actTime>=9 and actTime<=11 {image_alpha+=0.25}
          else if actTime=12
          {
            image_alpha+=0.25
            sprite_index=sSeph_Idle
            bCanTakeDamage=true
            if bFaster=1 {actTime=13}
          }
          else if actTime>=15
          {
            actTime=0
            bFastAtk=1
            actCheck=10
            if altAtk=0 {currentAtk=0}
            else if altAtk=1 {currentAtk=1}
            else if altAtk=2 {currentAtk=3}
          }
        }
        else if actCheck=10 //---------- Execute action ----------
        {
          event_user(currentAtk)
        }
      }
    }
    else //---------- Meteor attack ----------
    {
      actTime+=1
      if actTime=1
      {
        sprite_index=sSeph_Summon
        image_index=0
        yVel=0
        bCanTakeDamage=false
        image_alpha-=0.25
      }
      else if actTime>=2 and actTime<=4 {image_alpha-=0.25}
      else if actTime=6
      {
        xSpot=x
        x=xCenter
        y=yGround-160
      }
      else if actTime>=7 and actTime<=10 {image_alpha+=0.25}
      else if actTime=12 {bCanTakeDamage=true; image_index=1}
      else if actTime=14 {image_index=2}
      else if actTime=16 {image_index=3}
      else if actTime=18 {image_index=4}
      else if actTime=20 {image_index=5}
      else if actTime=28 {image_index=2}
      else if actTime=30
      {
        var newMeteor;
        newMeteor=instance_create(0,0,oSephMetControl)
        newMeteor.meteorFreq=meteorFreq; newMeteor.meteorTime=meteorTime
      }
      else if actTime>=67 and actTime<=70 {bCanTakeDamage=false; image_index=0; image_alpha-=0.25}
      else if actTime=74
      {
        x=xSpot
        y=yGround
      }
      else if actTime>=75 and actTime<=77 {image_alpha+=0.25}
      else if actTime=78
      {
        bCanTakeDamage=true
        image_alpha+=0.25
      }
      else if actTime>=82
      {
        actTime=0
        sprite_index=sSeph_Idle
        meteor=0
      }
    }

    if meteor<metStormFreq {yVel+=0.4}
    if isCollisionBottom(1)
    {
      if currentAtk=3 and yVel>6 {xVel=0; actTime=100}
      yVel=0
    }
    if isCollisionLeft(1)
    {
      xVel=1
    }
    if isCollisionRight(1)
    {
      xVel=-1
    }
    if isCollisionSolid()
      y-=2

    moveTo(xVel,yVel)

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.83 and lifePercent>=0.66 and bossProgress=0
    {
      waitDelay-=4
      atkMax+=1
      meteorTime+=5
      meteorFreq-=1
      if meteor>=metStormFreq {meteor+=1}
      metStormFreq+=1
      resType[1]=2
      resType[5]=2
      bossProgress+=1
    }
    else if lifePercent<=0.65 and lifePercent>=0.51 and bossProgress=1
    {
      waitDelay-=4
      meteorTime+=5
      meteorFreq-=1
      if meteor>=metStormFreq {meteor+=1}
      metStormFreq+=1
      resType[1]=1
      resType[3]=2
      resType[5]=1
      bossProgress+=1
    }
    else if lifePercent<=0.5 and lifePercent>=0.31 and bossProgress=2
    {
      waitDelay-=4
      atkMax+=1
      meteorTime+=5
      meteorFreq-=1
      if meteor>=metStormFreq {meteor+=1}
      metStormFreq+=1
      resType[3]=1
      bossProgress+=1
    }
    else if lifePercent<=0.3 and lifePercent>=0 and bossProgress=3
    {
      waitDelay-=4
      meteorTime+=5
      meteorFreq-=1
      if meteor>=metStormFreq {meteor+=1}
      metStormFreq+=1
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      with oSephAtk {instance_destroy()}
      with oEProjectileBase {instance_destroy()}
      bCanDealDamage=false
      if global.levelTimeSecond<=35 and oPlayer1.tookHitAmount=0
      {
        var tCheckAchieve;
        tCheckAchieve=string_char_at(global.tokenRecognitions,9)
        if tCheckAchieve="0"
        {
          var tAchievement;
          tAchievement=instance_create(0,0,oAchievementNotice)
          tAchievement.myAchievement="Swordswoman"; tAchievement.checkNum=9
        }
      }
    }
    else if deathAnim>=2 and deathAnim<=75
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
    else if deathAnim>=80
    {
      if global.bBossGallery=1
      {
        bossRoomTally(46)
        global.newMapX=1736; global.newMapY=464; room_goto(rBossGallery)
      }
      else
      {
        oEvExGates.sceneProgress=1
        instance_destroy()
      }
    }
  }
  enemyStepEvent()
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//-- ATK A: FORWARD VERTICAL SLASH --
//Attack is faster after a back dash or teleport
actTime+=1
if actTime=1
{
  xVel=0
  instance_create(x-(36*image_xscale),y-122,oG6_CounterSpark)
  sprite_index=sSeph_AtkA
  image_index=0
  if bFaster=1 {actTime=5}
  if bFastAtk=1 {actTime=11}
}
else if actTime=15
{
  playSound(global.snd_DeathSlash,0,1,20000)
  bSwing=1
  image_index=1
  instance_create(x,y,oSephAtk)
  oSephAtk.atkPower=atkPower
  oSephAtk.image_xscale=image_xscale
}
else if actTime=18 {image_index=2; oSephAtk.image_index=1}
else if actTime=21 {image_index=3; oSephAtk.image_index=2}
else if actTime=24 {image_index=4}
else if actTime=25
{
  bSwing=0
  with oSephAtk {instance_destroy()}
  if bFaster=1 {actTime=28}
}
else if actTime>=32
{
  event_user(4)
}
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//-- ATK B: FORWARD HORIZONTAL SLASH (Charge Forward) --

actTime+=1
if actTime=1
{
  xVel=0
  instance_create(x-(73*image_xscale),y-19,oG6_CounterSpark)
  sprite_index=sSeph_AtkB
  image_index=0
  if bFaster=1 {actTime=6}
}
else if actTime=15
{
  image_index=1
}
else if actTime=17
{
  playSound(global.snd_DeathSlash,0,1,18000)
  image_index=2
  bSwing=1
  instance_create(x,y-16,oSephAtk)
  oSephAtk.sprite_index=sSephA_B
  oSephAtk.atkPower=atkPower
  oSephAtk.image_xscale=image_xscale
}
else if actTime=19 {image_index=3; oSephAtk.image_index=1}
else if actTime=22
{
  bSwing=0
  with oSephAtk {instance_destroy()}
  if bFaster=1 {actTime=24}
}
else if actTime>=25
{
  event_user(4)
}
#define Other_12
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//-- ATK C: LOW JUMP FORWARD TO GROUND SLASH --

actTime+=1
if actTime=1
{
  xVel=0
  instance_create(x-(20*image_xscale),y+7,oG6_CounterSpark)
  sprite_index=sSeph_AtkC
  image_index=0
  if bFaster=1 {actTime=3}
}
else if actTime=10
{
  image_index=1
  y-=2
  yVel=-6
  xVel=1.5*image_xscale
}
else if actTime=15 {image_index=2}
else if actTime=20
{
  playSound(global.snd_DeathSlash,0,1,26000)
  bSwing=1
  image_index=3
  yVel=3
  xVel=3*image_xscale
  instance_create(x,y,oSephAtk)
  oSephAtk.sprite_index=sSephA_C
  oSephAtk.atkPower=atkPower
  oSephAtk.image_xscale=image_xscale
}
else if actTime=24 {image_index=4; oSephAtk.image_index=1}
else if actTime=27
{
  xVel=0
  bSwing=0
  with oSephAtk {instance_destroy()}
}
else if actTime>=30
{
  event_user(4)
}

if actTime>=21 and actTime<=26 //Keep sword slash following Sephiroth
{
  oSephAtk.x=x
  oSephAtk.y=y
}
#define Other_13
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//-- ATK D: GROUND POUND SLASH (Used after jump animation) --

actTime+=1
if actTime=1
{
  playSound(global.snd_DeathSlash,0,1,13000)
  sprite_index=sSeph_AtkD
  image_index=0
  yVel=6
  xVel=1.5*image_xscale
  instance_create(x,y+2,oSephAtk)
  oSephAtk.sprite_index=sSephA_D
  oSephAtk.atkPower=atkPower
  oSephAtk.image_xscale=image_xscale
}
else if actTime=103
{
  bSwing=0
  with oSephAtk {instance_destroy()}
  event_user(4)
}

if actTime>=2 and actTime<=100 //Keep sword slash following Sephiroth
{
  oSephAtk.x=x
  oSephAtk.y=y+2
}
#define Other_14
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//End attack
sprite_index=sSeph_Idle
bFastAtk=0
actTime=0
actCheck=0
altAtk=0
if bossProgress>=3 {bFaster=1}

atkNum+=1
if atkNum>=atkMax
{
  atkNum=0
  waitTime=0
  meteor+=1
}
else
{
  waitTime=waitDelay-2
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

if lightRays>0
{
  draw_set_alpha(rayAlpha)
  draw_set_color(c_white)
  draw_circle(x,y-34,4+lightRays,0)
  for(i=0;i<lightRays;i+=1)
  {
    draw_line_width(x,y-34,x+lengthdir_x(512,myDir[i]),y-34+lengthdir_y(512,myDir[i]),2)
  }
}
