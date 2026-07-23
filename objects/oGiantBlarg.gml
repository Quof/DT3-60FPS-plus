#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanTakeDamage=false
image_speed=0
image_xscale=-1

//Enemy base statistics
eName="Giant Blargg"
maxLife=3
life=maxLife
atkPower=14
damageType="ELEMENTAL"
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
stunResist=50
affiliation=1
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0

bPodWave=1
eyeOffsetAX=0; eyeOffsetAY=0
eyeOffsetBX=0; eyeOffsetBY=0
eyeAngleA=0; eyeAngleB=0

bodyLife=1400
hitState=0
atkTime=0
moveType=0
fireMouthDuration=90
fireMouthFreq=8
xThrow=5
yThrow=-6
yGrav=0.3
frozenTime=0

leftSide=232
rightSide=664

xCenter=448
yGround=256
roomSpan=288

jeremyText="Oh hey, a Mario related boss fight. Its been awhile. I'm sure you know that you can't just jump on his head, you know, cause he's made of lava. It looks like you can damage him through other means though, but that will only work so much. I'm sure you know what you need to do when your weapons stop working though. Remember this, when all else fails, your Mario abilities will always be around."
chaoText="Jeremy didn't even talk about its attack patterns! Anyway, they're pretty easy to figure out, but can be hard to dodge. All of his attacks have to do with fire. Oh yeah Jerry, I think you might be able to exploit and kinda cheat one of the attacks."
devText="This lava cave turned out really good I think. I had been looking forward to making it for awhile. Visually it actually turned out a bit better than I originally thought."

myBody=instance_create(x,y,oGB_BodyHit)
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
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=0
    activateBoss=2
  }

  if bActive=true and life>0
  {
    if hitState=0 //Standard behavior
    {
      if image_index>=2 {resType[2]=3} //Can take damage from ELEMENTAL if mouth is open
      else {resType[2]=1}
      atkTime+=1
      if moveType=0 //---------- Rise ----------
      {
        y-=2
        if y<=room_height+112 and bPodWave=1 //Spawn Podobo wave
        {
          var tPodSpawn;
          tPodSpawn=instance_create(x,room_height-32,oGB_PodWaveCon)
          tPodSpawn.image_xscale=image_xscale; tPodSpawn.yGrav=0.5
          if bossProgress>=2
          {
            var tXPod,tPodSpawn;
            if image_xscale=1 {tXPod=rightSide}
            else {tXPod=leftSide}
            tPodSpawn=instance_create(tXPod,room_height-32,oGB_PodWaveCon)
            tPodSpawn.image_xscale=-image_xscale; tPodSpawn.yGrav=0.5
          }
          bPodWave=0
        }
        if y<=room_height-32 {bPodWave=1; atkTime=0; moveType+=1}
      }
      else if moveType=1 //---------- Open mouth ----------
      {
        if atkTime=30 {image_index=1}
        else if atkTime=35 {image_index=2}
        else if atkTime=40 {image_index=3}
        else if atkTime=45 {image_index=4; atkTime=0; moveType+=1}
      }
      else if moveType=2 //---------- Fireball mouth attack ----------
      {
        if atkTime=1
        {
          xThrow=5
          yThrow=-6
          yGrav=0.3
        }
        else if atkTime>=20
        {
          if atkTime mod fireMouthFreq=0
          {
            var tNewAttack;
            tNewAttack=instance_create(x-(22*image_xscale),y-86,oGB_MouthFire)
            tNewAttack.atkPower=atkPower; tNewAttack.damageType="ELEMENTAL"; tNewAttack.bExplode=0
            tNewAttack.xVel=xThrow*image_xscale; tNewAttack.yVel=yThrow
            tNewAttack.xGrav=0; tNewAttack.yGrav=yGrav
            xThrow+=1
            if xThrow>=10 {xThrow=5}
            yThrow-=0.4
            if yThrow<=-9 {yThrow=-6}
            yGrav+=0.009
            if yGrav>=0.4 {yGrav=0.3}
          }
        }
        if atkTime>=fireMouthDuration+20 {atkTime=0; moveType+=1}
      }
      else if moveType=3 //---------- Close mouth ----------
      {
        if atkTime=20 {image_index=3}
        else if atkTime=25 {image_index=2}
        else if atkTime=30 {image_index=1}
        else if atkTime=35 {image_index=0}
        else if atkTime>=40
        {
          if bossProgress>=1
          {
            var tPodSpawn;
            tPodSpawn=instance_create(x,room_height-32,oGB_PodWaveCon)
            tPodSpawn.image_xscale=image_xscale; tPodSpawn.yGrav=0.3
          }
          atkTime=0; moveType+=1
        }
      }
      else if moveType=4 //---------- Move across map ----------
      {
        if image_xscale=1 //Right
        {
          x+=4
          if x>=rightSide {atkTime=0; moveType+=1}
        }
        else //Left
        {
          x-=4
          if x<=leftSide {atkTime=0; moveType+=1}
        }
        if y<room_height+160 {y+=2}
      }
      else if moveType=5 //---------- Check side ----------
      {
        if x<xCenter {image_xscale=1}
        else {image_xscale=-1}
        atkTime=0; moveType=0
      }
    }
    else if hitState=1 //Can take a hit
    {
      resType[2]=1
      frozenTime+=1
      if frozenTime>=150
      {
        frozenTime=0
        myBody.baseColor=c_white
        myBody.image_blend=baseColor
        bCanTakeDamage=false
        moveType=0
        atkTime=0
        hitState=0
      }
    }
    else if hitState=2 //Hit state recovery
    {
      resType[2]=1
      frozenTime+=1
      if frozenTime>=50
      {
        frozenTime=0
        moveType=0
        atkTime=0
        hitState=0
      }
    }

    //---------- Boss Difficulty Curve ----------
    if bossProgress=0 and life=2
    {
      bodyLife+=600
      fireMouthDuration+=10
      bossProgress+=1
    }
    else if bossProgress=1 and life=1
    {
      bodyLife+=500
      fireMouthFreq-=1
      fireMouthDuration+=10
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    atkTime+=1
    if atkTime=1
    {
      with oEProjectileBase {instance_destroy()}
      with oLavaGuy {instance_destroy()}
    }
    if atkTime mod 5=0
    {
      var tEffect;
      for(i=0;i<6;i+=1)
      {
        tEffect=instance_create(x-12+random(24),bbox_bottom-4-random(sprite_height-8),oKillEffect)
        tEffect.speed=5; tEffect.direction=random(360); tEffect.friction=0.1+random(0.3)
        tEffect.fadeAlpha=0.04+random(0.02); tEffect.imageRot=random_range(-5,5)
      }
    }

    image_alpha-=0.01
    if image_alpha<=0
    {
      if global.bBossGallery=1
      {
        bossRoomTally(52)
        global.newMapX=712; global.newMapY=560; room_goto(rBossGallery)
      }
      else
      {
        with myBody {instance_destroy()}
        oEvCh18MainA.sceneProgress=1
        instance_destroy()
      }
    }
  }
  enemyStepEvent()
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if hitState=1
{
  yAdjust=0
  with oPlayer1
  {
    if platformCharacterIs(ON_GROUND)
      other.yAdjust=-14
    if platformCharacterIs(IN_AIR)
      other.yAdjust=0
  }
  veloAssist=0
  if oPlayer1.yVel>0
    veloAssist=round(oPlayer1.yVel/2)

  if bbox_bottom+yAdjust+veloAssist<oPlayer1.bbox_bottom
  {
    if bCanDealDamage=true
    {
      with other
        hitPlayer(other)
    }
  }
  else
  {
    if global.hasAbilToken[0]>=2 and oPlayer1.starmanTime<=0
    {
      var tDmgCheck;
      tDmgCheck=0
      if oPlayer1.sprite_index!=sJerryDamaged and oPlayer1.sprite_index!=sClaireDamaged
      {
        if oPlayer1.bCanTakeHit=true
        {
          if oPlayer1.dashInvulnerabilityTime=0
            tDmgCheck=1
        }
        else
        {
          if oPlayer1.dashInvulnerabilityTime=0 and oPlayer1.yVel>0
            tDmgCheck=1
        }
      }

      if tDmgCheck=1
      {
        with oPlayer1
        {
          if platformCharacterIs(ON_GROUND)
            yVel=-2
          if platformCharacterIs(IN_AIR)
          {
            if oPlayer1.jumpTime<oPlayer1.jumpTimeTotal-5
              oPlayer1.jumpTime=oPlayer1.jumpTimeTotal-5
            if kJump or kUp
              yVel=-13.5
            else
              yVel=-6.5
          }
          scrSlowFall(5,0.4,0)
        }

        //Damage effect
        var tFlash,tEffect;
        tFlash=instance_create(0,0,oScreenFlash)
        tFlash.image_alpha=0.5
        tFlash.fadeSpeed=0.1
        playSound(global.snd_MarioStomp,0,0.98,1)
        for(i=0;i<9;i+=1)
        {
          tEffect=instance_create(x-12+random(24),bbox_top+8,oKillEffect)
          tEffect.speed=5; tEffect.direction=55+(i*8)+random(4)
          tEffect.friction=0.1+random(0.3); tEffect.fadeAlpha=0.04+random(0.02); tEffect.imageRot=random_range(-5,5)
        }
        oPlayer1.canAirDash=1
        oPlayer1.doubleJumpCheck=1
        life-=1 //Damage Boss
        hitState=2
        frozenTime=0
        image_index=0
        myBody.baseColor=c_white
        myBody.image_blend=baseColor
        if life=0 //Boss defeat
        {
          bCanDealDamage=false
          atkSequence=0
          atkTime=0
        }
      }
    }
    else
    {
      if bCanDealDamage=true
      {
        with other
          hitPlayer(other)
      }
    }
  }
}
else
{
  if bCanDealDamage=true
  {
    with other
      hitPlayer(other)
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,myBody.image_blend,image_alpha)
if image_index=0
{
  eyeOffsetAX=-1; eyeOffsetAY=-125
  eyeOffsetBX=24; eyeOffsetBY=-125
}
else if image_index=1
{
  eyeOffsetAX=-2; eyeOffsetAY=-125
  eyeOffsetBX=23; eyeOffsetBY=-125
}
else if image_index=2
{
  eyeOffsetAX=22; eyeOffsetAY=-134
  eyeOffsetBX=-3; eyeOffsetBY=-134
}
else if image_index=3
{
  eyeOffsetAX=20; eyeOffsetAY=-138
  eyeOffsetBX=-5; eyeOffsetBY=-138
}
else if image_index=4
{
  eyeOffsetAX=18; eyeOffsetAY=-142
  eyeOffsetBX=-7; eyeOffsetBY=-142
}
if hitState<2
{
  eyeAngleA=point_direction(x+(eyeOffsetAX*image_xscale),y+eyeOffsetAY,oPlayer1.x,returnPlayerYCenter())
  eyeAngleB=point_direction(x+(eyeOffsetBX*image_xscale),y+eyeOffsetBY,oPlayer1.x,returnPlayerYCenter())
}
else
{
  eyeAngleA-=20
  eyeAngleB+=20
}

draw_sprite_ext(sGB_Eye,0,x+(eyeOffsetAX*image_xscale),y+eyeOffsetAY,1,1,eyeAngleA,image_blend,image_alpha)
draw_sprite_ext(sGB_Eye,0,x+(eyeOffsetBX*image_xscale),y+eyeOffsetBY,1,1,eyeAngleB,image_blend,image_alpha)
