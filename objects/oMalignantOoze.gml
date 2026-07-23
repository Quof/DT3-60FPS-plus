#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-18,-72,18,-1)
bCanTakeDamage=false
image_speed=0

//Enemy base statistics
eName="Malignant Ooze"
eLevel=33
maxLife=2800
life=maxLife
pointWorth=90
atkPower=9
resType[0]=5
resType[2]=4
resType[4]=2
stunResist=8
baseItemChance=85
baseDropIndex=90
moneyWorth=20
affiliation=8
dieSound=0
dieEffect=0
imageEffect=0
enemyProg=0
inactiveDist*=2

//-- Attack Data --
waitTime=35
waitDelay=65 //idle time between attack strings
actTime=0 //progress in an action
actCheck=0 //choosing an action
atkCur=1
cleaveNum=0
bJumpReady=1
soundMod=29
bCanScream=1
scream=0
bCanDefend=1
defend=0
jeremyNotice=0

jeremyText="Hex has it out for us now, but anyway, this has 3 attacks it loops through. The only one that I feel I need to note is the big block it summons. That block will continue to bounce around for quite some time. Other behaviors are using its arm to shield from projectiles, and it has a scream attack to blow you away. Which is unfortunate because it takes massive damage from NORMAL type attacks."
chaoText="Eww..."
devText="This sprite was a contender to use for a later fight with Hex, at least back when I was thinking about exactly how I would design that encounter."
extraInfo="Only the head can be damaged."

deathAnim=0

myHead=instance_create(x,y,oMO_Head)
myHead.myOwner=id
myShield=-1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0 and life>0 and instance_exists(myHead)
  {
    life=myHead.life
    image_blend=myHead.image_blend

    imageEffect+=1
    if imageEffect mod 8=0
    {
      var tAfterI;
      tAfterI=instance_create(x,y,oEnemyAfterImage)
      tAfterI.sprite_index=sprite_index; tAfterI.image_index=image_index; tAfterI.image_blend=c_red
      tAfterI.image_alpha=0.35; tAfterI.image_xscale=image_xscale; tAfterI.depth=26; tAfterI.imageFade=0.01
      tAfterI.xScaling=0.03; tAfterI.yScaling=0.03; tAfterI.xShift=0; tAfterI.yShift=0
      tAfterI.bFollow=1; tAfterI.idFollow=id; tAfterI.xFollow=0; tAfterI.yFollow=0
    }

    //---------- Movement ----------
    if waitTime<waitDelay and yVel=0 and scream=0 and defend=0
    {
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}

      if sprite_index=sMO_Idle {image_index+=0.2}

      if waitTime>5 and waitTime<waitDelay-5
      {
        if point_distance(x,y-32,oPlayer1.x,oPlayer1.y-26)<=96 and bCanScream=1
        {
          bCanScream=0
          scream=1
        }
        if point_distance(x,y-32,oPlayer1.x,oPlayer1.y-26)>=128 and bCanDefend=1
        {
          if instance_exists(oAttackBase)
          {
            var tAtkNear;
            tAtkNear=instance_nearest(x,y-32,oAttackBase)
            if point_distance(x,y-32,tAtkNear.x,tAtkNear.y)<=96 and tAtkNear.damageType!="NORMAL"
            {
              bCanDefend=0
              defend=1
            }
          }
        }
      }
    }

    if defend>=1 //Defend
    {
      defend+=1
      if defend=2 {sprite_index=sMO_Defend; image_index=0}
      else if defend=4 {image_index=1}
      else if defend=6 {image_index=2}
      else if defend=8 {image_index=3}
      else if defend=10
      {
        image_index=4
        myShield=instance_create(x,y,oMO_ArmShield)
        myShield.ownerID=id; myShield.image_xscale=image_xscale
      }
      else if defend>=50
      {
        with myShield {instance_destroy()}
        sprite_index=sMO_Idle
        myShield=-1
        defend=0
      }
    }

    if scream>=1 //Scream
    {
      scream+=1
      if scream=2 {sprite_index=sMO_Scream}
      else if scream>=5 and scream<=30
      {
        if scream mod 4=0
        {
          playSound(global.snd_RidleyScreamA,0,0.96,60000)
          tEfCir=instance_create(x+(14*image_xscale),y-38,oEfCircleSoftFade)
          tEfCir.image_alpha=0.75; tEfCir.myRad=32; tEfCir.radScl=8; tEfCir.fadeSpeed=0.1

          if global.activeCharacter=2 //Jeremy's mech cannot be pushed back
          {
            if jeremyNotice=0
            {
              showEmote(oPlayer1,0,-54,sEmQuestion)
              jeremyNotice=1
              var tCheckAchieve;
              tCheckAchieve=string_char_at(global.tokenRecognitions,43)
              if tCheckAchieve="0"
              {
                var tAchievement;
                tAchievement=instance_create(0,0,oAchievementNotice)
                tAchievement.myAchievement="Not This Time"; tAchievement.checkNum=43
              }
            }
          }
          else //Push player back
          {
            if point_distance(x+(14*image_xscale),y-38,oPlayer1.x,oPlayer1.y-26)<=128
            {
              if x<oPlayer1.x {oPlayer1.extForceX=8.5}
              else {oPlayer1.extForceX=-8.5}
            }
          }
        }
        if scream=12 or scream=20 or scream=28
        {
          var mDir;
          if scream=12 {if image_xscale=1 {mDir=10} else {mDir=170}}
          else if scream=20 {if image_xscale=1 {mDir=0} else {mDir=180}}
          else if scream=28 {if image_xscale=1 {mDir=-10} else {mDir=190}}
          var tNewAttack;
          tNewAttack=instance_create(x+(14*image_xscale),y-38,oPassBullet)
          tNewAttack.sprite_index=sMOFire; tNewAttack.atkPower=atkPower; tNewAttack.image_speed=0.25
          tNewAttack.bulletSpeed=7; tNewAttack.decayTime=-100; tNewAttack.direction=mDir
        }
      }
      else if scream>=31
      {
        sprite_index=sMO_Idle
        jeremyNotice=0
        scream=0
      }
    }
    
    if point_distance(x,y-32,oPlayer1.x,oPlayer1.y-26)>=144 and scream=0 and defend=0 {waitTime+=0.25} //Speed up attacks if player is too far
    
    if scream=0 and defend=0 {waitTime+=1}
    else {waitTime+=0.25}
    
    if waitTime>=waitDelay and scream=0 and defend=0
    {
      if actCheck=0 //---------- Choose an action ----------
      {
        actCheck=atkCur
        atkCur+=1
        if atkCur=4 {atkCur=1}
      }
      else if actCheck=1 //---------- ATTACK: Throw Bounce Weight ----------
      {
        actTime+=1
        if actTime=1
        {
          sprite_index=sMO_Throw; image_index=0
        }
        else if actTime=3 {image_index=1}
        else if actTime=5 {image_index=2}
        else if actTime=7 {image_index=3}
        else if actTime=9 {image_index=4}
        else if actTime=11
        {
          tNewAttack=instance_create(x+(36*image_xscale),y-58,oMO_BounceWeight)
          tNewAttack.atkPower=atkPower; tNewAttack.yVel=-4
          if enemyProg=0 {tNewAttack.xVel=8*image_xscale; tNewAttack.xFalloff=0.02}
          else if enemyProg=1 {tNewAttack.xVel=9*image_xscale; tNewAttack.xFalloff=0.0125}
        }
        else if actTime=13 {image_index=3}
        else if actTime=15 {image_index=2}
        else if actTime=17 {image_index=1}
        else if actTime=19 {image_index=0}
        else if actTime>=22
        {
          event_user(0)
        }
      }
      else if actCheck=2 //---------- ATTACK: Jump and Dive ----------
      {
        actTime+=1
        if actTime=1
        {
          sprite_index=sMO_Jump; image_index=0
          y-=2
          yVel=-8
          xVel=6*image_xscale
          bJumpReady=0
        }
        else if actTime=4 {image_index=1}
        else if actTime=7 {image_index=2}
        else if actTime>=10 and actTime<=299 //Check distance to player
        {
          if point_distance(x,0,oPlayer1.x,0)<8
          {
            sprite_index=sMO_SpikeDive
            if oPlayer1.xVel>2 {xVel=4; image_xscale=1}
            else if oPlayer1.xVel<-2 {xVel=-4; image_xscale=-1}
            else {xVel=0}
            yVel=12
            actTime=300
          }
        }
        else if actTime>=500 //Hit ground
        {
          var tNewAtk;
          tNewAtk=instance_create(x,y,oDamageExplosion)
          tNewAtk.atkPower=atkPower; tNewAtk.sprite_index=sGroundBlast
          tNewAtk.image_xscale=0.65; tNewAtk.image_yscale=1.5; tNewAtk.decayTime=-100
          sprite_index=sMO_Idle
          xVel=0
          event_user(0)
        }
      }
      else if actCheck=3 //---------- ATTACK: Cleaver ----------
      {
        actTime+=1
        if actTime=1 {sprite_index=sMO_CleaveReady}
        if actTime=10
        {
          sprite_index=sMO_Cleaver
          if x<oPlayer1.x {image_xscale=1}
          else {image_xscale=-1}
          xVel=12*image_xscale
        }
        else if actTime>=20 and actTime<=199
        {
          if cleaveNum=1
          {
            if actTime mod 5=0
            {
              var tNewAttack;
              tNewAttack=instance_create(x,y,oGravPassBullet)
              tNewAttack.sprite_index=sDraculaMeteor; tNewAttack.atkPower=atkPower; tNewAttack.yVel=-8
              tNewAttack.image_xscale=0.75; tNewAttack.image_yscale=0.75
            }
          }
          
          if image_xscale=1 and x>oPlayer1.x {actTime=200}
          else if image_xscale=-1 and x<oPlayer1.x {actTime=200}
        }
        else if actTime>=200 and actTime<=499
        {
          if xVel>0.1 {xVel-=0.3}
          else if xVel<-0.1 {xVel+=0.3}
          
          if xVel>-1 and xVel<1
          {
            SS_StopSound(global.snd_Spark)
            xVel=0
            cleaveNum+=1
            if cleaveNum=2
            {
              event_user(0)
            }
            else
            {
              soundMod=29
              actTime=0
            }
          }
        }
        
        //Spark effect
        if xVel<-1.5 or xVel>1.5
        {
          soundMod+=1
          if soundMod mod 30=0
          {
            playSound(global.snd_Spark,0,0.96,33000)
          }
          var tEfSpark,tEfSDir;
          for(i=0;i<2;i+=1)
          {
            tEfSDir=random_range(78,102)
            tEfSpark=instance_create(x+random_range(-3,3),y,oEffectB)
            tEfSpark.type=4; tEfSpark.sprite_index=sScaledCollision; tEfSpark.newBlend=-1; tEfSpark.rotation=0
            tEfSpark.AccelX=0; tEfSpark.AccelY=0; tEfSpark.followID=-1; tEfSpark.friction=0.5; tEfSpark.image_xscale=2+irandom(3)
            tEfSpark.direction=tEfSDir; tEfSpark.image_angle=tEfSDir; tEfSpark.speed=5+random(2)
            tEfSpark.image_blend=choose(c_white,c_yellow,c_orange)
          }
        }
      }
    }
    
    yVel+=0.3
    if isCollisionBottom(1)
    {
      if bJumpReady=0
      {
        actTime=500
        bJumpReady=1
      }
      yVel=0
    }
    if isCollisionLeft(1)
    {
      var tBufX;
      tBufX=abs(xVel)
      xVel=tBufX
      image_xscale=1
    }
    if isCollisionRight(1)
    {
      var tBufX;
      tBufX=abs(xVel)
      xVel=-tBufX
      image_xscale=-1
    }
    if isCollisionSolid()
      y-=2
    
    moveTo(xVel,yVel)
    
    if y>room_height+24
    {
      with myHead {instance_destroy()}
      instance_destroy()
    }
  }
  else if life<=0 or !instance_exists(myHead)
  {
    deathAnim+=1
    if deathAnim=1
    {
      if myShield!=-1
      {
        with myShield {instance_destroy()}
      }
      myHead.bCanDealDamage=false
      myHead.bCanTakeDamage=false
      playSound(global.snd_HardHit1,0,1,1)
      tEfCir=instance_create(x,y-40,oEfCircleBlast)
      tEfCir.image_alpha=0.8; tEfCir.myRad=4; tEfCir.radScl=5; tEfCir.fadeSpeed=0.08
    }
    
    if deathAnim mod 4=0
    {
      if deathAnim mod 8=0 {playSound(global.snd_BombExplode,0,0.8,1)}
      tEffect=instance_create(x+random_range(-16,16),y-1-random(74),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.04
    if image_alpha<0
    {
      with myHead {instance_destroy()}
      instance_destroy()
    }
  }
  
  if lifePercent<=0.5 and enemyProg=0
  {
    waitDelay-=20
    var tAtkShield;
    tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
    tAtkShield.xOffset=0; tAtkShield.yOffset=-40; tAtkShield.atkType=0; tAtkShield.atkUp=1
    resType[0]-=1
    resType[2]-=1
    enemyProg=1
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
waitTime=0
sprite_index=sMO_Idle
actCheck=0
actTime=0
cleaveNum=0
bCanScream=1
bCanDefend=1
soundMod=29
