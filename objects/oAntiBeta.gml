#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-20,-40,20,-1)
bCanDealDamage=false; bCanTakeDamage=false
baseColor=make_color_rgb(200,255,200)
image_blend=baseColor
image_speed=0
image_xscale=-1

//Enemy base statistics
eName="Antipathy Beta"
eLevel=31
maxLife=20000
life=maxLife
atkPower=9
stunResist=50
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
//-- Attack Data --
atkNum=0 //current attack in string
atkMax=2 //max attacks in a string
waitTime=50
waitDelay=74 //idle time between attack strings
actTime=0 //progress in an action
actCheck=0 //choosing an action
shockTime=-1
shockNum=0
shockMax=5
shockX=0
shockDir=0
shockScl=1
runAcc=4
imageEffect=0
//--------------------

//Misc Data
xCenter=480
roomSpan=160
yGround=272

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
    bCanDealDamage=true; bCanTakeDamage=true
    jeremyText="The first of this one's 3 attacks is a projectile sword wave. The center one is aimed at your location and 2 others are about 15 degrees offset from the center. Its second attack is a shockwave of sorts. The range is limited, but it reaches a decent height, so watch out there. The third is a charge like its buddy, but it always jumps. If you're under it when it's descending, it'll dive down."
    chaoText="I feel bad for these bots, they didn't do anything wrong. It doesn't look like there's any way to save them either. Once the Virus infects a bot, it seems we don't have a way to remove it."
    devText="Originally these were going to appear about half way through this facility, but I felt it would be better to show that the Virus was down here through these guys first."
    activateBoss=2
  }

  if bActive=true and life>0
  {
    //Movement
    if waitTime<waitDelay
    {
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}
      xVel=0
    }

    if sprite_index=sAntiBeta_Charge or sprite_index=sAntiBeta_Dive //After-image
    {
      imageEffect+=1
      if imageEffect mod 2=0
      {
        var tAfterI;
        tAfterI=instance_create(x,y,oEnemyAfterImage)
        tAfterI.sprite_index=sprite_index; tAfterI.image_index=image_index; tAfterI.depth=26; tAfterI.image_blend=c_teal
        tAfterI.image_alpha=0.5; tAfterI.image_xscale=image_xscale; tAfterI.xShift=0; tAfterI.yShift=0
        tAfterI.imageFade=0.02; ; tAfterI.xScaling=0; tAfterI.yScaling=0; tAfterI.bFollow=0
      }
    }

    waitTime+=1
    if waitTime>=waitDelay
    {
      if actCheck=0 //---------- Choose an action ----------
      {
        if atkNum=0 //----- First attack -----
        {
          if point_distance(x,0,oPlayer1.x,0)<80 //-- Player is close --
          {
            if oPlayer1.attackState=0 or oPlayer1.busterLastShotTime<10 //Player is not attacking
            {
              actCheck=1
            }
            else //Player is attacking
            {
              actCheck=1
            }
          }
          else //-- Player is far --
          {
            if oPlayer1.attackState=0 or oPlayer1.busterLastShotTime<10 //Player is not attacking
            {
              actCheck=2
            }
            else //Player is attacking
            {
              actCheck=3
            }
          }
        }
        else if atkNum>=1 //----- Second attack -----
        {
          if point_distance(x,0,oPlayer1.x,0)<80 //-- Player is close --
          {
            if oPlayer1.attackState=0 or oPlayer1.busterLastShotTime<10 //Player is not attacking
            {
              actCheck=3
            }
            else //Player is attacking
            {
              actCheck=2
            }
          }
          else //-- Player is far --
          {
            if oPlayer1.attackState=0 or oPlayer1.busterLastShotTime<10 //Player is not attacking
            {
              actCheck=1
            }
            else //Player is attacking
            {
              actCheck=2
            }
          }
        }
      }
      else if actCheck=1 //---------- ATTACK: SWORD SWING ----------
      {
        actTime+=1
        if actTime=1 {sprite_index=sAntiBeta_SReady}
        else if actTime=12 {sprite_index=sAntiBeta_Swing; image_index=0}
        else if actTime=16
        {
          playSound(global.snd_HardHit3,0,0.96,26000)
          image_index=1
          var tNewAttack,tDir;
          tDir=point_direction(x+(23*image_xscale),y-26,oPlayer1.x,returnPlayerYCenter())
          tDir-=15
          for(i=0;i<3;i+=1)
          {
            tNewAttack=instance_create(x+(23*image_xscale),y-26,oPassBullet)
            tNewAttack.sprite_index=sAntiSwordWave; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5
            tNewAttack.decayTime=-100; tNewAttack.direction=tDir
            tDir+=15
          }
        }
        else if actTime>=30
        {
          event_user(0)
        }
      }
      else if actCheck=2 //---------- ATTACK: SHOCKWAVE ----------
      {
        actTime+=1
        if actTime=1 {sprite_index=sAntiBeta_ShockHit; image_index=0}
        else if actTime=14
        {
          playSound(global.snd_Shock,0,0.84,19000)
          image_index=1
          xVel=5*image_xscale
          shockX=x+(56*image_xscale)
          shockDir=image_xscale
          if oAntipathyHealth.bossProgress<=1 {shockScl=1}
          else if oAntipathyHealth.bossProgress=2 {shockScl=1.1}
          else if oAntipathyHealth.bossProgress>=3 {shockScl=1.2}
          shockTime=6
        }
        else if actTime>=20 and actTime<=199
        {
          if xVel=0 {sprite_index=sAntiBeta_Idle; actTime=200}
        }
        else if actTime>=215
        {
          event_user(0)
        }
      }
      else if actCheck=3 //---------- ATTACK: JUMP CHARGE ----------
      {
        actTime+=1
        if actTime=1 {sprite_index=sAntiBeta_CReady}
        else if actTime=15
        {
          y-=2; yVel=-10
          xVel=(runAcc*2.5)*image_xscale
          sprite_index=sAntiBeta_Charge
        }
        else if actTime>=20 and actTime<=199
        {
          if yVel>=1.2 //Dive down if player is under
          {
            if y<oPlayer1.y and point_distance(x,0,oPlayer1.x,0)<=18
            {
              playSound(global.snd_HardHit1,0,0.96,16000)
              actTime=200
              sprite_index=sAntiBeta_Dive
              xVel=0; yVel=10
            }
          }
        }
      }
    }

    if shockTime>=1 //Shockwave attack
    {
      shockTime+=1
      if shockTime mod 7=0
      {
        var tNewAttack;
        tNewAttack=instance_create(shockX,yGround,oDamageExplosion)
        tNewAttack.sprite_index=sBTFirePillar; tNewAttack.atkPower=atkPower; tNewAttack.decayTime=-100
        tNewAttack.image_yscale=shockScl
        shockScl+=0.03*oAntipathyHealth.bossProgress
        shockX+=16*shockDir
        shockNum+=1
        if shockNum>=shockMax
        {
          shockNum=0; shockTime=-1
        }
      }
    }

    if sprite_index=sAntiBeta_ShockHit //Slow down slide
    {
      if xVel>0
      {
        xVel-=0.5
        if xVel<=0.51 {xVel=0}
      }
      else if xVel<0
      {
        xVel+=0.5
        if xVel>=-0.51 {xVel=0}
      }
    }

    yVel+=0.4
    if isCollisionBottom(1)
    {
      if actCheck=3 and yVel>1
      {
        xVel=0
        if sprite_index=sAntiBeta_Dive
        {
          var tNewAttack;
          tNewAttack=instance_create(x,y-8,oGravityBullet)
          tNewAttack.sprite_index=sSparkysSpark; tNewAttack.atkPower=atkPower
          tNewAttack.xVel=2.5; tNewAttack.yVel=-5; tNewAttack.image_xscale=0.5; tNewAttack.image_yscale=0.5
          tNewAttack=instance_create(x,y-8,oGravityBullet)
          tNewAttack.sprite_index=sSparkysSpark; tNewAttack.atkPower=atkPower
          tNewAttack.xVel=-2.5; tNewAttack.yVel=-5; tNewAttack.image_xscale=0.5; tNewAttack.image_yscale=0.5
        }
        sprite_index=sAntiBeta_Idle
        event_user(0)
        actTime=0
      }
      yVel=0
    }
    if isCollisionLeft(1)
    {
      if actCheck=3 {xVel=runAcc*2.5}
      else {xVel=runAcc}
      image_xscale=1
    }
    if isCollisionRight(1)
    {
      if actCheck=3 {xVel=-runAcc*2.5}
      else {xVel=-runAcc}
      image_xscale=-1
    }
    if isCollisionSolid()
      y-=2

    moveTo(xVel,yVel)
  }
  enemyStepEvent()
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//End attack
sprite_index=sAntiBeta_Idle
actTime=0
actCheck=0

atkNum+=1
if atkNum=1 {waitTime=round(waitDelay/2)+10}
else if atkNum=2 {waitTime=round(waitDelay/2)+25}

if atkNum>=atkMax {waitTime=0; atkNum=0}
