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

//Enemy base statistics
eName="Antipathy Alpha"
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
waitTime=30
waitDelay=80 //idle time between attack strings
actTime=0 //progress in an action
actCheck=0 //choosing an action

runAcc=2
jumpNum=0
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
    jeremyText="They each have 3 attacks. This one has a breath attack with decent range. It'll cause a large portion of the field to be covered in this. The second is a standard charge, just be sure you're watching its telegraph of it. For its other attack, it simply hops 3 times. Note that it cannot change its direction after it has started the first hop."
    chaoText="These sprites are the Terror Twins from an Arcade game called 'Midnight Wanderers'."
    devText="It was around the time of making these guys that I changed the way arrow and missile ammo worked. Beforehand, arrows and missiles had a much higher capacity but did not have an auto recharge. In order to make sure the player can be completely self sufficient with all their weapons, it was changed to what you have now."
    instance_create(0,0,oAntipathyHealth)
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

    if sprite_index=sAntiAlpha_Charge //After-image
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
      else if actCheck=1 //---------- ATTACK: ROBOT BREATH ----------
      {
        actTime+=1
        if actTime=1 {sprite_index=sAntiAlpha_Breath}
        else if actTime=20
        {
          playSound(global.snd_Beam,0,0.94,14000)
          image_index=1
        }
        else if actTime>=21 and actTime<=65
        {
          if actTime mod 2=0
          {
            var tPoison;
            tPoison=instance_create(x+(14*image_xscale),y-22,oM_PoisonBreath)
            tPoison.atkPower=atkPower; tPoison.bulletSpeed=5+random(2); tPoison.animSpeed=0.25
            tPoison.image_xscale=0.8; tPoison.image_yscale=0.8; tPoison.depth=24
            if image_xscale=1 {tPoison.direction=random_range(-5,5)}
            else tPoison.direction=random_range(175,185)
          }
        }
        else if actTime>=70
        {
          event_user(0)
        }
      }
      else if actCheck=2 //---------- ATTACK: CHARGE ----------
      {
        actTime+=1
        if actTime=1 {sprite_index=sAntiAlpha_Charge}
        else if actTime=15 {playSound(global.snd_ChargeStrike,0,0.95,14000)}
        else if actTime>=16 and actTime<=45
        {
          xVel=(runAcc*5)*image_xscale
          if image_xscale=1 and x>=xCenter+roomSpan-48 {actTime=45}
          else if image_xscale=-1 and x<=xCenter-roomSpan+48 {actTime=45}
        }
        else if actTime=46
        {
          xVel=0
          sprite_index=sAntiAlpha_Idle
        }
        else if actTime>=50
        {
          event_user(0)
        }
      }
      else if actCheck=3 //---------- ATTACK: HOP ACROSS PART OF ROOM ----------
      {
        actTime+=1
        if actTime=5
        {
          playSound(global.snd_ComicHit1,0,0.94,16000)
          y-=2; yVel=-8
          xVel=(runAcc*1.5)*image_xscale
          sprite_index=sAntiAlpha_Jump
        }
      }
    }

    yVel+=0.4
    if isCollisionBottom(1)
    {
      if actCheck=3 and yVel>1
      {
        xVel=0
        sprite_index=sAntiAlpha_Idle
        jumpNum+=1
        if jumpNum>=3 //End Hop attack
        {
          event_user(0)
        }
        actTime=0
      }
      yVel=0
    }
    if isCollisionLeft(1)
    {
      if actCheck=3 {xVel=(runAcc*1.5)*image_xscale}
      else {xVel=runAcc}
      image_xscale=1
    }
    if isCollisionRight(1)
    {
      if actCheck=3 {xVel=(-runAcc*1.5)*image_xscale}
      else {xVel=-runAcc}
      image_xscale=-1
    }
    if isCollisionSolid()
      y-=2

    moveTo(xVel,yVel)
  }
  enemyStepEvent()
}

if life<=0 //Defeat animation
{
  deathAnim+=1
  if deathAnim=1
  {
    with oEProjectileBase {instance_destroy()}
    with oAttackBase {instance_destroy()}
    with oAntipathyHealth {instance_destroy()}
    x=xCenter+20; y=yGround-96; image_xscale=1; sprite_index=sAntiAlpha_Idle; image_blend=baseColor
    oAntiBeta.x=xCenter-20; oAntiBeta.y=yGround-96; oAntiBeta.image_xscale=-1; oAntiBeta.sprite_index=sAntiBeta_Idle; oAntiBeta.image_blend=baseColor

    global.gamePaused=true
    var tFlash;
    tFlash=instance_create(0,0,oScreenFlash)
    tFlash.fadeSpeed=0.2
    oPlayer1.visible=0; oPlayer1.x=xCenter; oPlayer1.y=yGround

    mashingButtons=instance_create(0,0,oMashButtons)
    mashingButtons.xCenter=xCenter; mashingButtons.yCenter=yGround-128
    mashingButtons.startJerryX=xCenter+128; mashingButtons.startJerryY=yGround-96
    mashingButtons.startClaireX=xCenter-128; mashingButtons.startClaireY=yGround-96
  }
  else if deathAnim=15
  {
    msgCreate(0,0,"Jerry","Time to... ah forget it, let's just trash them!",0,1,oMessagePerson,0)
    newMessage.fadingTime=50
  }
  else if deathAnim=70
  {
    mashingButtons.bCanHit=1
  }
  else if deathAnim>=80 and deathAnim<=90
  {
    if deathAnim=85 {deathAnim=80}

    if mashingButtons.timeToStop<=0
    {
      global.gamePaused=false
      mashingButtons.bCanHit=2
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
      oPlayer1.visible=1
      deathAnim=150
    }
  }
  else if deathAnim>=151 and deathAnim<=210
  {
    if deathAnim mod 3=0 {playSound(global.snd_BombExplode,0,0.92,1)}
    if oGame.time mod 2=0
    {
      var tEffect;
      tEffect=instance_create(x+random_range(-20,20),y-random(40),oEffect)
      tEffect.sprite_index=sSamusSMissileHit; tEffect.image_speed=0.5; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      var tEffect;
      tEffect=instance_create(oAntiBeta.x+random_range(-20,20),oAntiBeta.y-random(40),oEffect)
      tEffect.sprite_index=sSamusSMissileHit; tEffect.image_speed=0.5; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
  }
  else if deathAnim>=211
  {
    oEvCh17MainA.sceneProgress=1
    with oAntiBeta {instance_destroy()}
    instance_destroy()
  }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//End attack
sprite_index=sAntiAlpha_Idle
jumpNum=0
actTime=0
actCheck=0

atkNum+=1
if atkNum=1 {waitTime=round(waitDelay/2)+10}
else if atkNum=2 {waitTime=round(waitDelay/2)+25}

if atkNum>=atkMax {waitTime=0; atkNum=0}
