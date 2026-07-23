#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-8,-40,8,-1)
image_speed=0.1
image_xscale=-1
baseColor=c_black
image_blend=baseColor

//Enemy base statistics
eName="Shadow Form"
eLevel=22
maxLife=4000
life=maxLife
atkPower=6
resType[1]=2
resType[2]=1
resType[3]=2
resType[4]=1
resType[5]=1
stunResist=50
affiliation=9
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0

//-- Movement Data --
moveSpd=1.25
turnTime=0
turnDelay=40
onOtherSide=0

//-- Neutral Data --
charForm=0
changeTime=0
changeDelay=260

currentAction=0
lastAction=0
attackDelay=0
waitTime=45

//-- Attack Data --
atkSpdA=8
dashDir=0
bDive=0
spdChange=0
checkChange=0
bombFormation=0
holyWaterMax=3

//-- Misc Data --
xCenter=328
yGround=304
roomSpan=160

deathAnim=0

jeremyText="Damaging this can be tricky. I don't know much yet, scan him later and I should have more information."
chaoText="It has routines to adapt its attack and defensive options to what you're doing. There are no hopeless situations, know that it will change the rules from time to time."
devText="Originally this fight was meant to be a duel on par with Death, but other ideas I had overtook that. I never wanted to take away the dueling aspect of the fight though, there's just an added layer to it. The result is fairly predictable, but it's kinda nifty."
extraInfo="Copies your attacks."
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
    if currentAction=0 //---------- No action: Ready ----------
    {
      //---------- MOVEMENT ----------
      //Check if player is on other side of facing direction
      if x>oPlayer1.x and image_xscale=1
      {
        onOtherSide=1
        turnTime+=1
      }
      else if x<oPlayer1.x and image_xscale=-1
      {
        onOtherSide=1
        turnTime+=1
      }
      else
      {
        onOtherSide=0
        turnTime=0
      }

      if turnTime>=turnDelay
      {
        image_xscale*=-1
        turnTime=0
      }

      //Change form
      if charForm=global.activeCharacter {changeTime+=1}
      else {changeTime+=2}
      if changeTime>=changeDelay
      {
        if charForm=0 {charForm=1; sprite_index=sClaireIdle}
        else {charForm=0; sprite_index=sJerryIdle}
        changeTime=0
      }

      //Check distance
      chkMove=point_distance(x,0,oPlayer1.x,0)
      if charForm=0 {distMax=48}
      else {distMax=80}

      if chkMove<distMax-(distMax/6)
      {
        if image_xscale=1 {xVel=-moveSpd}
        else {xVel=moveSpd}
        if onOtherSide=1 {xVel=0}
      }
      else if chkMove>distMax-(distMax/6) and chkMove<distMax
      {
        xVel=0
      }
      else if chkMove>distMax
      {
        if image_xscale=1 {xVel=moveSpd}
        else {xVel=-moveSpd}
      }

      if xVel!=0 //Move effect
      {
        var tFFScl;
        for(i=0;i<4;i+=1)
        {
          tFFScl=random(0.1)
          tEffect=instance_create(x+random_range(-14,14),y+random_range(-6,2),oEffectB)
          tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=-1; tEffect.image_blend=c_black
          tEffect.image_xscale=0.1+tFFScl; tEffect.image_yscale=0.1+tFFScl
          tEffect.direction=random(360); tEffect.speed=random(0.25)+0.25; tEffect.friction=random(0.01)+0.01
          tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0; tEffect.fadeSpd=0.03
        }
      }
      image_speed=xVel/6
      if image_speed<0.1 {image_speed=0.1}

      //---------- ACTION DECISION MAKING ----------
      attackDelay+=1
      if attackDelay>=waitTime
      {
        var tDistToPlayer;
        tDistToPlayer=point_distance(x,0,oPlayer1.x,0)
        if tDistToPlayer<=distMax*1.25 //Close
        {
          if lastAction=10 {currentAction=20}
          else {currentAction=10}
        }
        else if tDistToPlayer>=distMax*1.26 and tDistToPlayer<=distMax*2 //Mid
        {
          if lastAction=20 {currentAction=40}
          else {currentAction=20}
        }
        else
        {
          if lastAction=20 {currentAction=30}
          else if lastAction=30 {currentAction=40}
          else {currentAction=20}
        }
        lastAction=currentAction

        if checkChange=1
        {
          spdChange=1
          checkChange=2
        }
        image_speed=0; image_index=0
        xVel=0
        attackDelay=0
      }
    }
    else if currentAction>=10 and currentAction<=19 //---------- Attack: Standard Melee ----------
    {
      attackDelay+=1
      if attackDelay=1 {if charForm=0 {sprite_index=sJerrySword} else {sprite_index=sClaireHairWhip}}
      else if attackDelay=8-spdChange //Attack
      {
        image_speed=0.05*atkSpdA
        newAtk=instance_create(x,y,oShadowF_Melee)
        if sprite_index=sClaireHairWhip {newAtk.sprite_index=sBelmontWhip}
        newAtk.atkPower=atkPower; newAtk.atkSpd=0.05*atkSpdA
      }
      else if attackDelay>=10-spdChange //Wait till attack end
      {
        if sprite_index=sJerryIdle or sprite_index=sClaireIdle {attackDelay=0; currentAction=0}
      }
    }
    else if currentAction>=20 and currentAction<=29 //---------- Attack: Roll Jump and Dive ----------
    {
      attackDelay+=1
      if attackDelay=1 //Dash check
      {
        if charForm=0 {sprite_index=sJerryKneel} else {sprite_index=sClaireDuck}
        if x>oPlayer1.x {image_xscale=-1} else {image_xscale=1}
        if image_xscale=1 and x>xCenter-(roomSpan/2) {dashDir=1}
        else if image_xscale=-1 and x<xCenter+(roomSpan/2) {dashDir=2}
        if dashDir>0 {if charForm=0 {sprite_index=sJerryJumpBack} else {sprite_index=sClaireJumpBack}}
        else {attackDelay=3}
      }
      else if attackDelay=2 {if dashDir=1 {xVel=-5} else if dashDir=2 {xVel=5}} //Dash back
      else if attackDelay=9-spdChange //Jump
      {
        image_speed=0.25
        if charForm=0 {sprite_index=sJerryJumpForward} else {sprite_index=sClaireAirRoll}
        y-=2
        yVel=-8
        xVel=5*image_xscale
      }
      else if attackDelay>=18-spdChange and attackDelay<=999 //Dive check
      {
        if bDive=0
        {
          if ((image_xscale=1 and x>oPlayer1.x) or (image_xscale=-1 and x<oPlayer1.x)) and y<yGround-48
          {
            if point_distance(x,0,oPlayer1.x,0)<=48
            {
              if charForm=0 {sprite_index=sJerryKneel} else {sprite_index=sClaireDuck}
              xVel=0
              yVel=11
              bDive=1
            }
          }
        }
        if y>=yGround-3 {y=yGround; xVel=0; dashDir=0; attackDelay=1000} //Contact with ground
      }

      if attackDelay=1000 //Ground hit attack
      {
        var tFire;
        tFire=instance_create(x,y,oDamageExplosion)
        tFire.sprite_index=sBTFirePillar; tFire.image_xscale=1.5; tFire.image_yscale=1.5; tFire.image_blend=c_black
        tFire.atkPower=atkPower; tFire.damageType="EXPLOSION"; tFire.bulletSpeed=0; tFire.decayTime=15
      }
      else if attackDelay=1005-(spdChange*2) //Attack end
      {
        if charForm=0 {sprite_index=sJerryIdle} else {sprite_index=sClaireIdle}
        if x>oPlayer1.x {image_xscale=-1} else {image_xscale=1}
        bDive=0; attackDelay=0; currentAction=0
      }
    }
    else if currentAction>=30 and currentAction<=39 //---------- Attack: Projectile ----------
    {
      attackDelay+=1
      if attackDelay=1 {if charForm=0 {sprite_index=sJerryFire1} else {sprite_index=sClaireThrow}}
      else if attackDelay=8-spdChange //Attack
      {
        image_index=2
        var tNewAttack;
        tNewAttack=instance_create(x+(20*image_xscale),y-33,oPassBullet)
        if charForm=0 {tNewAttack.sprite_index=sLinkArrow} else {tNewAttack.sprite_index=sBelmontDagger}
        tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=12; tNewAttack.decayTime=-100; tNewAttack.image_blend=c_black
        if image_xscale=-1 {tNewAttack.direction=180}
      }
      else if attackDelay=10-spdChange //Attack end
      {
        if charForm=0 {sprite_index=sJerryIdle} else {sprite_index=sClaireIdle}
        if x>oPlayer1.x {image_xscale=-1} else {image_xscale=1}
        attackDelay=0; currentAction=0
      }
    }
    else if currentAction>=40 and currentAction<=49 //---------- Attack: Special (Bomb/Holy Water) ----------
    {
      attackDelay+=1
      if attackDelay=1 {if charForm=0 {sprite_index=sJerryCasting} else {sprite_index=sClaireCasting}}
      else if attackDelay=10-spdChange //Use attack
      {
        if charForm=0
        {
          var tNewAttack;
          tNewAttack=instance_create(x,y-26,oShadowF_Bomb); tNewAttack.xVel=1; tNewAttack.yVel=-4
          tNewAttack=instance_create(x,y-26,oShadowF_Bomb); tNewAttack.xVel=-1; tNewAttack.yVel=-4
          tNewAttack=instance_create(x,y-26,oShadowF_Bomb); tNewAttack.xVel=4; tNewAttack.yVel=-6
          tNewAttack=instance_create(x,y-26,oShadowF_Bomb); tNewAttack.xVel=-4; tNewAttack.yVel=-6
          if bombFormation=1
          {
            tNewAttack=instance_create(x,y-26,oShadowF_Bomb); tNewAttack.xVel=5; tNewAttack.yVel=-7
            tNewAttack=instance_create(x,y-26,oShadowF_Bomb); tNewAttack.xVel=-5; tNewAttack.yVel=-7
          }
        }
        else if charForm=1
        {
          var tNewAttack;
          for(i=0;i<holyWaterMax;i+=1)
          {
            tNewAttack=instance_create(x,y-26,oGravityBullet)
            tNewAttack.sprite_index=sBelmontHolyWater; tNewAttack.atkPower=atkPower
            if image_xscale=1 {tNewAttack.image_angle=330} else {tNewAttack.image_angle=30}
            tNewAttack.xVel=(2+i)*image_xscale; tNewAttack.yVel=-3-i; tNewAttack.image_blend=c_black
          }
        }
      }
      else if attackDelay=15-spdChange //Attack end
      {
        if charForm=0 {sprite_index=sJerryIdle} else {sprite_index=sClaireIdle}
        if x>oPlayer1.x {image_xscale=-1} else {image_xscale=1}
        attackDelay=0; currentAction=0
      }
    }

    yVel+=0.4

    if isCollisionBottom(1)
    {
      yVel=0
    }
    if isCollisionLeft(1)
    {
      if sprite_index=sJerryJumpForward or sprite_index=sClaireAirRoll {xVel=5; image_xscale=1}
    }
    if isCollisionRight(1)
    {
      if sprite_index=sJerryJumpForward or sprite_index=sClaireAirRoll {xVel=-5; image_xscale=-1}
    }
    if isCollisionSolid()
      y-=2
    moveTo(xVel,yVel)

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.88 and lifePercent>=0.77 and bossProgress=0 //[0]
    {
      waitTime-=3
      turnDelay-=3
      changeDelay-=4
      event_user(1)
      jeremyText="Looks like its changed its defenses. You'll only be able to hit it from behind."
      bossProgress+=1
    }
    else if lifePercent<=0.76 and lifePercent>=0.65 and bossProgress=1 //[1]
    {
      waitTime-=3
      turnDelay-=2
      changeDelay-=4
      bossProgress+=1
    }
    else if lifePercent<=0.64 and lifePercent>=0.53 and bossProgress=2 //[1]
    {
      waitTime-=3
      turnDelay-=3
      changeDelay-=4
      event_user(1)
      jeremyText="On top of only being able to hit it from behind, it has added another rule to damaging it. The problem is... I don't know what it is. I've noted that it changes its character fairly often."
      bossProgress+=1
    }
    else if lifePercent<=0.52 and lifePercent>=0.41 and bossProgress=3 //[2]
    {
      waitTime-=3
      turnDelay-=2
      changeDelay-=4
      holyWaterMax+=1
      bossProgress+=1
    }
    else if lifePercent<=0.4 and lifePercent>=0.29 and bossProgress=4 //[2]
    {
      waitTime-=5
      turnDelay-=3
      changeDelay-=4
      bombFormation+=1
      atkSpdA+=1
      event_user(1)
      jeremyText="Okay, so you had to have the opposite character hitting him from behind. But now a new rule was added and you're not gonna like this much. Both previous rules still apply, but you can't hit him till he's in an attacking pose. Eh... good luck with that."
      bossProgress+=1
    }
    else if lifePercent<=0.28 and lifePercent>=0.17 and bossProgress=5 //[3]
    {
      waitTime-=3
      turnDelay-=2
      changeDelay-=4
      holyWaterMax+=1
      checkChange=1
      bossProgress+=1
    }
    else if lifePercent<=0.16 and lifePercent>=0 and bossProgress=6 //[3]
    {
      waitTime-=3
      turnDelay-=2
      changeDelay-=4
      event_user(1)
      jeremyText="I'm not sure what rule was added this time, I just know that all previous rules are still around. It probably has to do with limiting damage types. Looks like only NORMAL type works now."
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      sprite_index=sJerryDamaged
      bCanDealDamage=false
    }
    else if deathAnim>=2 and deathAnim<=90
    {
      if deathAnim mod 9=0 {playSound(global.snd_EnemyDieMM,0,1,1)}
      if oGame.time mod 3=0
      {
        var tEffect;
        tEffect=instance_create(bbox_left+random(abs(sprite_width)),bbox_top+random(abs(sprite_height)),oEffect)
        tEffect.sprite_index=sMMExplosion; tEffect.image_speed=0.5; tEffect.image_blend=c_black
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim>=91
    {
      if global.bBossGallery=1
      {
        bossRoomTally(28)
        global.newMapX=504; global.newMapY=848; room_goto(rBossGallery)
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
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bossProgress=0 {event_inherited()} //[0] No rules
  else if bossProgress>=1 and bossProgress<=2 //[1] Hit from behind
  {
    if checkFacing()=1 {event_user(0)}
    else {event_inherited()}
  }
  else if bossProgress>=3 and bossProgress<=4 //[2] Hit from behind, only with opposite character
  {
    if checkFacing()=1 {event_user(0)}
    else
    {
      if charForm!=global.activeCharacter {event_inherited()}
      else {event_user(0)}
    }
  }
  else if bossProgress>=5 and bossProgress<=6 //[3] Hit from behind, only with opposite character, only when taking an action
  {
    if currentAction=0
    {
      event_user(0)
      if other.damageType!="NORMAL" {with other {instance_destroy()}}
    }
    else
    {
      if checkFacing()=1 {event_user(0)}
      else
      {
        if charForm!=global.activeCharacter {event_inherited()}
        else {event_user(0)}
      }
    }
  }
  else if bossProgress>=7 //[4] Hit from behind, only when taking an action, only with opposite character, only NORMAL type
  {
    if currentAction=0
    {
      event_user(0)
      if damageType!="NORMAL" {with other {instance_destroy()}}
    }
    else
    {
      if checkFacing()=1 {event_user(0)}
      else
      {
        if charForm!=global.activeCharacter
        {
          if other.damageType="NORMAL" {event_inherited()}
          else {event_user(0)}
        }
        else {event_user(0)}
      }
    }
  }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playSound(global.snd_MMBulletDeflect,0,0.92,1)
var tEffect;
tEffect=instance_create(x+random_range(-6,6),y-4-random(44),oEffect)
tEffect.sprite_index=sMMchargeComplete
tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<48;i+=1)
{
  tEffect=instance_create(x+random_range(-10,10),y-random(52),oEffectB)
  tEffect.type=3; tEffect.image_speed=0; tEffect.image_index=choose(0,1); tEffect.sprite_index=sPauseM_SkillLv
  tEffect.direction=random(360); tEffect.speed=random(2)+1; tEffect.fadeSpd=0.03;
  tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
}
