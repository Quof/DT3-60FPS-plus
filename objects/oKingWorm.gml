#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0

//Enemy base statistics
eName="King Worm"
eLevel=23
maxLife=4000
life=maxLife
atkPower=8
resType[0]=2
resType[1]=2
resType[5]=4
stunResist=50
bIsBoss=true
bNoBonus=true
affiliation=5
hitSound=global.snd_MetEnemyHitA
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
xEye=0; yEye=0 //Offset eye position without offsetting collision
eyelidFrame=2 //0: Open, 1: top lid begin closing, 2: both lids closed
playerDist=0
xSpd=0

behavior=0
progTime=0
bSpraySpikes=0
sprayDelay=320
diveAmt=0
bFromGround=0
currWaterLevel=240

fangAnimate=0
eyeAnimate=0 //0: Do nothing, 10: open, 20: close

//Misc Data
deathAnim=0

leftFang=instance_create(x,y,oKingWormParts)
leftFang.sprite_index=sKingWormTeeth; leftFang.type=1; leftFang.image_speed=0; leftFang.image_xscale=-1; leftFang.mySeg=0
rightFang=instance_create(x,y,oKingWormParts)
rightFang.sprite_index=sKingWormTeeth; rightFang.type=1; rightFang.image_speed=0; rightFang.mySeg=0

for(i=0;i<8;i+=1)
{
  segBody[i]=instance_create(x,y-32-(27*i),oKingWormParts)
  segBody[i].type=0; segBody[i].mySeg=i
  segBody[i].image_index=0.2*i; segBody[i].image_speed=0.1
}

for(i=0;i<9;i+=1)
{
  leftSide[i]=instance_create(80,270-(27*i),oKingWormParts)
  leftSide[i].type=10; leftSide[i].image_index=0.25*i; leftSide[i].image_speed=0.1; leftSide[i].mySeg=i
  rightSide[i]=instance_create(400,44+(27*i),oKingWormParts)
  rightSide[i].type=20; rightSide[i].image_yscale=-1; rightSide[i].image_index=0.25*i; rightSide[i].mySeg=i; rightSide[i].image_speed=0.1
}

xCenter=240
yGround=272
roomSpan=192
neutralY=128
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
    jeremyText="It cycles through 3 attack phases, one where it dives and homes in on you. Another where it will periodically dive down, and the last it will raise the water level. You can only hit it while its eye is open. I am seeing a weak part on the side of the head, where a missile may be able to slip through."
    chaoText="This is the first boss encounter in Metroid: Zero Mission, but it doesn't have to be beaten at that point. If the fight goes on too long, it will just go away. Defeating it in that game awarded you with the Charge Beam."
    devText="This boss was originally going to be available once the player had all the items in the Gate 5 sequence, but that was later changed to have the Norfair boss be at the end, which overall, fit better."
    with oKingWormParts
    {
      jeremyText=oKingWorm.jeremyText
      chaoText=oKingWorm.chaoText
      devText=oKingWorm.devText
    }
    oKraidMouthHit.bActive=true
    oKraidMouthHit.bCanTakeDamage=true
    activateBoss=2
  }

  if bActive=true and life>0
  {
    //Check eyelid and set damagable state
    if eyelidFrame=0 {bCanTakeDamage=true}
    else {bCanTakeDamage=false}
    //Check player position based on worm position and change eye direction based on that
    playerDist=point_distance(x,0,oPlayer1.x,0)
    if playerDist<=32 {xEye=0}
    else if playerDist>=33 and playerDist<=76
    {
      if oPlayer1.x<x {xEye=-1} else {xEye=1}
    }
    else if playerDist>=77
    {
      if oPlayer1.x<x {xEye=-2} else {xEye=2}
    }

    progTime+=1
    if behavior=0 //---------- Dive down ----------
    {
      if progTime=15 {fangAnimate=1}
      else if progTime=35 {eyeAnimate=10}
      else if progTime=50 {leftFang.image_index=1; rightFang.image_index=1}
      else if progTime>=51 and progTime<=999 //track player and dive (player must be in morph ball to dodge)
      {
        if x<oPlayer1.x-5 {x+=8} else if x>oPlayer1.x+5 {x-=8}
        y+=4
        if y>=yGround-40 {y=yGround-40; progTime=1000}
      }
      else if progTime=1001 {leftFang.image_index=0; rightFang.image_index=0}
      else if progTime>=1035
      {
        y-=4
        if y<=neutralY //end behavior
        {
          y=neutralY
          eyeAnimate=20
          progTime=0; behavior+=1
        }
      }
    }
    else if behavior=1 //---------- Spray spikes, dive straight down periodically ----------
    {
      if progTime=1 {bSpraySpikes=1}
      else if progTime>=11 and progTime<=175
      {
        x+=xSpd
        if x<oPlayer1.x
        {
          if xSpd<5 {xSpd+=0.25}
        }
        else if x>oPlayer1.x
        {
          if xSpd>-5 {xSpd-=0.25}
        }
        if progTime=155 {fangAnimate=1}
        else if progTime=167 {eyeAnimate=10}
        else if progTime=180 {leftFang.image_index=1; rightFang.image_index=1}
      }
      else if progTime>=192 and progTime<=999
      {
        y+=4
        if y>=yGround-36 {y=yGround-36; progTime=1000}
      }
      else if progTime=1001 {leftFang.image_index=0; rightFang.image_index=0}
      else if progTime>=1035
      {
        y-=4
        if y<=neutralY
        {
          y=neutralY
          eyeAnimate=20
          progTime=0
          diveAmt+=1
          if diveAmt>=3 {bSpraySpikes=0; diveAmt=0; behavior+=1} //end behavior
        }
      }
    }
    else if behavior=2 //---------- Raise water and burst through ground ----------
    {
      if progTime=10
      {
        if bossProgress>=3 {currWaterLevel=144}
        else {currWaterLevel=176}
      }
      else if progTime>=11 and progTime<=99 //rise up
      {
        for(i=0;i<4;i+=1)
        {
          tEffect=instance_create(x+random_range(-24,24),40+random(16),oEffect)
          tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.25+random(0.25); tEffect.image_alpha=0.6
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.depth=8
        }
        y-=8
        if y<=8 {progTime=100}
      }
      else if progTime=101 {bSpraySpikes=1; leftFang.image_index=1; rightFang.image_index=1}
      else if progTime=149 //set to player x and open eye
      {
        playSound(global.snd_Earthquake,0,1,44100)
        x=oPlayer1.x; eyeAnimate=10
      }
      else if progTime>=150 and progTime<=399
      {
        for(i=0;i<4;i+=1)
        {
          tEffect=instance_create(x+random_range(-24,24),yGround-8+random(16),oEffect)
          tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.25+random(0.25); tEffect.image_alpha=0.6
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.depth=8
        }
        if progTime=190 {y=room_height; bFromGround=1} //set position to bottom of map
        else if progTime>=191 and progTime<=299 //push up
        {
          y-=8
          if y<=176 {progTime=300}
        }
        else if progTime>=345 //go back down
        {
          y+=8
          if y>=room_height {progTime=400}
        }
      }
      else if progTime=450
      {
        diveAmt+=1
        if diveAmt>=3
        {
          y=0; bFromGround=0; eyeAnimate=20
          if bossProgress>=3 {currWaterLevel=208}
          else {currWaterLevel=240}
          leftFang.image_index=0; rightFang.image_index=0
          diveAmt=0; bSpraySpikes=0
        }
        else
        {
          progTime=148
        }
      }
      else if progTime>=451 //come back to neutral position from ceiling
      {
        y+=8
        if y>=neutralY //end behavior
        {
          y=neutralY
          progTime=0; behavior=0
        }
      }
    }

    //Animate fangs
    if fangAnimate>0
    {
      fangAnimate+=1
      if fangAnimate=3 {leftFang.image_index=1; rightFang.image_index=1}
      else if fangAnimate=6 {leftFang.image_index=2; rightFang.image_index=2}
      else if fangAnimate=9 {leftFang.image_index=1; rightFang.image_index=1}
      else if fangAnimate=12 {leftFang.image_index=0; rightFang.image_index=0}
      else if fangAnimate=15 {leftFang.image_index=1; rightFang.image_index=1}
      else if fangAnimate=18 {leftFang.image_index=2; rightFang.image_index=2}
      else if fangAnimate=21 {leftFang.image_index=1; rightFang.image_index=1}
      else if fangAnimate=24 {leftFang.image_index=0; rightFang.image_index=0; fangAnimate=0}
    }
    //Animate eye
    if eyeAnimate>0
    {
      eyeAnimate+=1
      if eyeAnimate=14 or eyeAnimate=24 {eyelidFrame=1}

      if eyeAnimate=18 {eyelidFrame=0; eyeAnimate=0}
      else if eyeAnimate=28 {eyelidFrame=2; eyeAnimate=0}
    }
    //Change water level
    if oWaterVolume.y<currWaterLevel {oWaterVolume.y+=1}
    else if oWaterVolume.y>currWaterLevel {oWaterVolume.y-=1}

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.8 and lifePercent>=0.61 and bossProgress=0
    {
      sprayDelay-=20
      with oKingWormParts
      {
        if type=10 or type=20 {sprayTime=mySeg*28}
      }
      bossProgress+=1
    }
    else if lifePercent<=0.6 and lifePercent>=0.41 and bossProgress=1
    {
      sprayDelay-=20
      with oKingWormParts
      {
        if type=10 or type=20 {sprayTime=mySeg*26}
      }
      bossProgress+=1
    }
    else if lifePercent<=0.4 and lifePercent>=0.31 and bossProgress=2
    {
      if currWaterLevel=240 {currWaterLevel=208}
      else if currWaterLevel=176 {currWaterLevel=144}
      sprayDelay-=20
      with oKingWormParts
      {
        if type=10 or type=20 {sprayTime=mySeg*24}
      }
      bossProgress+=1
    }
    else if lifePercent<=0.3 and lifePercent>=21 and bossProgress=3
    {
      var tAtkShield;
      tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
      tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=5; tAtkShield.atkUp=1
      with oEnemyBase {resType[5]=3}
      bossProgress+=1
    }
    else if lifePercent<=0.2 and lifePercent>=0 and bossProgress=4
    {
      sprayDelay-=20
      with oKingWormParts
      {
        if type=10 or type=20 {sprayTime=mySeg*22}
      }
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      with oEnemyBase {bCanDealDamage=false}
      with oEProjectileBase {instance_destroy()}
      with oAttackBase {instance_destroy()}
    }
    else if deathAnim>=2 and deathAnim<=90
    {
      if deathAnim mod 6=0 {playSound(global.snd_EnemyDieMM,0,1,1)}
      if oGame.time mod 2=0
      {
        var tEffect;
        tEffect=instance_create(x-32+random(160),y-64+random(288),oEffect)
        tEffect.sprite_index=sSamusMissileHit; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim>=91
    {
      if global.bBossGallery=1
      {
        bossRoomTally(31)
        global.newMapX=1016; global.newMapY=784; room_goto(rBossGallery)
      }
      else
      {
        oEvCh13MainA.sceneProgress=1
        with oKingWormParts {instance_destroy()}
        instance_destroy()
      }
    }
  }

  for(i=0;i<8;i+=1)
  {
    segBody[i].x=x
    segBody[i].image_blend=image_blend
    if bFromGround=0
    {
      leftFang.x=x-18; leftFang.y=y+6; leftFang.image_blend=image_blend; leftFang.image_yscale=1
      rightFang.x=x+18; rightFang.y=y+6; rightFang.image_blend=image_blend; rightFang.image_yscale=1
      segBody[i].y=y-32-(27*i); segBody[i].image_yscale=1
    }
    else if bFromGround=1
    {
      leftFang.x=x-18; leftFang.y=y-6; leftFang.image_blend=image_blend; leftFang.image_yscale=-1
      rightFang.x=x+18; rightFang.y=y-6; rightFang.image_blend=image_blend; rightFang.image_yscale=-1
      segBody[i].y=y+32+(27*i); segBody[i].image_yscale=-1
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
if life>0 {redDmgHit(0)}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bFromGround=0
{
  draw_sprite_ext(sKingWormEye,0,x+xEye,y+yEye,image_xscale,1,image_angle,image_blend,image_alpha)

  if eyelidFrame=1
  {
    draw_sprite_ext(sKingWormEyelid,1,x,y+4,image_xscale,-1,image_angle,image_blend,image_alpha)
  }
  else if eyelidFrame=2 //Eye closed
  {
    draw_sprite_ext(sKingWormEyelid,1,x,y+8,image_xscale,1,image_angle,image_blend,image_alpha)
    draw_sprite_ext(sKingWormEyelid,0,x,y+3,image_xscale,1,image_angle,image_blend,image_alpha)
  }

  draw_sprite_ext(sKingWormHead,0,x,y+6,image_xscale,1,image_angle,image_blend,image_alpha)
}
else if bFromGround=1
{
  draw_sprite_ext(sKingWormEye,0,x+xEye,y-yEye,image_xscale,-1,image_angle,image_blend,image_alpha)

  if eyelidFrame=1
  {
    draw_sprite_ext(sKingWormEyelid,1,x,y-4,image_xscale,1,image_angle,image_blend,image_alpha)
  }
  else if eyelidFrame=2 //Eye closed
  {
    draw_sprite_ext(sKingWormEyelid,1,x,y-8,image_xscale,-1,image_angle,image_blend,image_alpha)
    draw_sprite_ext(sKingWormEyelid,0,x,y-3,image_xscale,-1,image_angle,image_blend,image_alpha)
  }

  draw_sprite_ext(sKingWormHead,0,x,y-6,image_xscale,-1,image_angle,image_blend,image_alpha)
}
