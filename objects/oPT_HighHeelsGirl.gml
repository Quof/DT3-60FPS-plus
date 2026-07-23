#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-11,-48,11,-1)
image_speed=0
image_xscale=-1
global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]

//Enemy base statistics
eName="High Heels Girl"
eLevel=29
maxLife=8000
life=maxLife
atkPower=10
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
resType[0]=3
stunResist=50
affiliation=6
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
bCanBeBlocked=1
bParryOpp=0
blockCost=50

//-- Movement Data --
moveSpd=2.5

//-- Attack Data --
atkNum=0 //current attack in string
atkMax=2 //max attacks in a string
waitTime=5
waitDelay=30 //idle time between attack strings
actTime=0 //progress in an action
currentAtk=-1
actCheck=0 //choosing an action
atkSpd=0   //changes attack speed
altAtk=0
slowVel=0
xSpot=0

//-- Misc Data --
xCenter=320
yGround=288
roomSpan=160

deathAnim=0

jeremyText="She only has two attacks, but her actions before performing them are a bit more varied. Luckily her actions are very predictable if you know what to look for. One thing to note is her chosen action is mostly based on how close you are to her and whether or not you are attacking."
chaoText="Oh hey, she's from the same game you guys are using your looks from."
devText="This fight was not part of the original pass on the Gate. Neither was the joke encounter with the Flame Elemental. In the version before this, there wasn't a melee fight like this one in the Gate."
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
    if sprite_index=sHHG_Idle
    {
      if x>oPlayer1.x {image_xscale=-1}
      else {image_xscale=1}
      image_index+=0.2
    }

    waitTime+=1
    if waitTime>=waitDelay
    {
      if actCheck=0 //---------- Choose an action ----------
      {
        if atkNum=0 //----- First attack -----
        {
          if point_distance(x,0,oPlayer1.x,0)<64 //-- Player is close --
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
              actCheck=1
            }
            else //Player is attacking
            {
              actCheck=3
            }
          }
        }
        else if atkNum>=1 //----- Second attack -----
        {
          if point_distance(x,0,oPlayer1.x,0)<64 //-- Player is close --
          {
            if oPlayer1.attackState=0 //Player is not attacking
            {
              actCheck=10
              currentAtk=1
            }
            else //Player is attacking
            {
              actCheck=2
              altAtk=1
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
      }
      else if actCheck=1 //---------- Jump ----------
      {
        actTime+=1
        if actTime=1
        {
          xVel=3*image_xscale
          y-=2
          yVel=-5
          sprite_index=sHHG_Jump
        }
        else if actTime>=10
        {
          actTime=0
          actCheck=10
          if altAtk=0 {currentAtk=0}
          else {actCheck=3}
        }
      }
      else if actCheck=2 //---------- Dash back ----------
      {
        actTime+=1
        if actTime=1
        {
          xVel=3.5*-image_xscale
          sprite_index=sHHG_DashBack
          if atkSpd>=1 {actTime=4}
        }
        else if actTime=8
        {
          if altAtk=1 {actTime=0; actCheck=3}
        }
        else if actTime>=10
        {
          xVel=0
          actTime=0
          actCheck=10
          currentAtk=1
        }
      }
      else if actCheck=3 //---------- Dash forward ----------
      {
        actTime+=1
        if actTime=1
        {
          xVel=6*image_xscale
          sprite_index=sHHG_DashForward
          if atkSpd>=1 {actTime=4}
        }
        else if actTime>=10
        {
          slowVel=1
          altAtk=2
          actTime=0
          actCheck=10
          currentAtk=1
        }
      }
      else if actCheck=10 //---------- Execute action ----------
      {
        event_user(currentAtk)
      }
    }

    if slowVel=1 //Slow down a dash
    {
      if xVel>1 {xVel-=0.33}
      else if xVel<-1 {xVel+=0.33}
      else {xVel=0; slowVel=0}
    }

    yVel+=0.4
    if isCollisionBottom(1)
    {
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
      bossProgress+=1
    }
    else if lifePercent<=0.65 and lifePercent>=0.51 and bossProgress=1
    {
      waitDelay-=4
      bossProgress+=1
    }
    else if lifePercent<=0.5 and lifePercent>=0.31 and bossProgress=2
    {
      waitDelay-=4
      atkMax=3
      bossProgress+=1
    }
    else if lifePercent<=0.3 and lifePercent>=0 and bossProgress=3
    {
      waitDelay-=4
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      with oEProjectileBase {instance_destroy()}
      bCanDealDamage=false
      sprite_index=sHHG_Hit
    }
    else if deathAnim>=2 and deathAnim<=49
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
    else if deathAnim>=50
    {
      if global.bBossGallery=1
      {
        bossRoomTally(43)
        global.newMapX=2392; global.newMapY=464; room_goto(rBossGallery)
      }
      else
      {
        oEvCh15MainA.sceneProgress=1
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
//-- ATK A: FORWARD HORIZONTAL SLASH --

actTime+=1
if actTime=1
{
  slowVel=1
  instance_create(x-(20*image_xscale),y-9,oG6_CounterSpark)
  sprite_index=sHHG_AtkA
  image_index=0
  if atkSpd=1 {actTime=4}
  if atkSpd=2 {actTime=10}
}
else if actTime=15
{
  playSound(global.snd_DeathSlash,0,0.96,20000)
  bParryOpp=1
  image_index=1
}
else if actTime=19 {image_index=2}
else if actTime=23
{
  image_index=0
  bParryOpp=0
  if atkSpd>=1 {actTime=26}
}
else if actTime>=28
{
  event_user(4)
}
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//-- ATK B: FORWARD SPIN SLASH --

if actTime>=15 and actTime<=28 and actTime mod 3=0
{
  playSound(global.snd_DeathSlash,0,0.96,41000)
}

actTime+=1
if actTime=1
{
  slowVel=1
  instance_create(x-(17*image_xscale),y-44,oG6_CounterSpark)
  sprite_index=sHHG_AtkB
  image_index=0
  if atkSpd=1 {actTime=4}
  if altAtk=2 {actTime=14}
}
else if actTime=15
{
  bParryOpp=1
  image_index=1
}
else if actTime=17 {image_index=2}
else if actTime=19 {image_index=3}
else if actTime=21 {image_index=4}
else if actTime=23 {image_index=2}
else if actTime=25 {image_index=3}
else if actTime=27 {image_index=4}
else if actTime=29
{
  bParryOpp=0
  image_index=0
  if atkSpd>=1 {actTime=33}
}
else if actTime>=35
{
  event_user(4)
}
#define Other_14
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//End attack
sprite_index=sHHG_Idle
actTime=0
actCheck=0
altAtk=0
if bossProgress>=3 {atkSpd=1}

atkNum+=1
if atkNum>=atkMax
{
  atkNum=0
  waitTime=0
}
else
{
  waitTime=waitDelay-2
}
