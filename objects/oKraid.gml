#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
image_xscale=3.7
image_yscale=3.7
bCanTakeDamage=false

//Enemy base statistics
eName="Kraid"
eLevel=23
maxLife=4100
life=maxLife
atkPower=10
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
mouthProg=0
mouthOpenTime=40

myPosition=0 //0-Left, 1-Mid, 2-Right
moveChoice=0 //0-Move left, 1-Move right
moveTime=0
moveDelay=150

backFadeInTime=0

moveUpProg=0
moveUpTime=0

nailTime=120
nailDelay=160
spikeTime=0
spikeDelay=140
spikeProg=0
rockTime=0
rockDelay=200
rockX=0

//Misc Data
deathAnim=0

segBody=instance_create(x,y,oKraidParts)
segHead=instance_create(x,y,oKraidParts); segHead.sprite_index=sKraidHead
segArm=instance_create(x,y,oKraidParts); segArm.sprite_index=sKraidArm; segArm.animSpeed=0.2
segFoot=instance_create(x,y,oKraidParts); segFoot.sprite_index=sKraidFoot; segFoot.image_index=3
mouthHit=instance_create(x,y,oKraidMouthHit)

redBack=instance_create(0,0,oKraidBackRed)
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
    jeremyText="I don't think you'll have too much trouble with this, at least at first. Kraid uses all his normal tricks, with the flying nails and stomach spikes. Watch the ceiling for signs of falling rocks, those are new."
    chaoText="In a Metroid manga, it's mentioned that Kraid is Ridley's comrade. Its been said that he's a high ranking officer among the Space Pirates."
    devText="Kraid had been changed sometime during Gate 5 development to compensate for players possibly not having the Super High Jump Boots, but all of the changes made Kraid worse. He was reverted back to his original conception and closed off to the player till they had the approapriate item."
    with oKraidParts
    {
      jeremyText=oKraid.jeremyText
      chaoText=oKraid.chaoText
      devText=oKraid.devText
    }
    oKraidMouthHit.bActive=true
    oKraidMouthHit.bCanTakeDamage=true
    activateBoss=2
  }

  if bActive=true and life>0
  {
    //------ Mouth control -----
    if mouthProg=0 //Wait for face to be hit
    {
      if oKraidMouthHit.life<oKraidMouthHit.maxLife
      {
        oKraidMouthHit.life=oKraidMouthHit.maxLife
        oKraidMouthHit.bCanTakeDamage=false
        image_blend=c_yellow
        segHead.image_index=1
        mouthProg=1
      }
    }
    else if mouthProg>=1
    {
      mouthProg+=1
      if mouthProg=2 {image_blend=baseColor}
      else if mouthProg=31
      {
        playSound(global.snd_KraidRoarA,0,1,1)
        bCanTakeDamage=true
        segHead.image_index=2
      }
      else if mouthProg=35 {segHead.image_index=3}
      else if mouthProg>=35+mouthOpenTime and mouthProg<100 {segHead.image_index=2; mouthProg=101}
      else if mouthProg=105
      {
        bCanTakeDamage=false
        segHead.image_index=1
      }
      else if mouthProg=109
      {
        oKraidMouthHit.bCanTakeDamage=true
        segHead.image_index=0
        mouthProg=0
      }
    }

    //----- Movement -----
    if moveUpTime=0
    {
      moveTime+=1
      if moveTime>=moveDelay and moveTime<=999
      {
        if myPosition=0 {moveChoice=1}
        else if myPosition=1
        {
          if bossProgress=5 {moveChoice=1}
          else {moveChoice=choose(0,1)}
        }
        else if myPosition=2 {moveChoice=0}

        if bossProgress=5 and myPosition=2 {moveTime=-1000000}
        else {moveTime=1000}
      }
      else if moveTime>=1000
      {
        if moveChoice=0 //Left
        {
          segBody.x-=4
          if moveTime=1001 {segFoot.image_index=0}
          else if moveTime=1005 {segFoot.image_index=1}
          else if moveTime=1009 {segFoot.image_index=2}
          else if moveTime=1013 {segFoot.image_index=3}
        }
        else if moveChoice=1 //Right
        {
          segBody.x+=4
          if moveTime=1001 {segFoot.image_index=2}
          else if moveTime=1005 {segFoot.image_index=1}
          else if moveTime=1009 {segFoot.image_index=0}
          else if moveTime=1013 {segFoot.image_index=3}
        }

        if moveTime>=1014
        {
          if moveChoice=0 {myPosition-=1}
          else if moveChoice=1 {myPosition+=1}
          moveTime=0
        }
      }
    }

    //----- Normal Attack: Flying Nail -----
    nailTime+=1
    if nailTime>=nailDelay
    {
      var tAtk,tXPos,tYPos;
      tXPos=64
      tYPos=random_range(80,192)
      tAtk=instance_create(tXPos,tYPos,oKraidNail)
      tAtk.direction=point_direction(tXPos,tYPos,oPlayer1.x,oPlayer1.y-26)
      tAtk.atkPower=atkPower; tAtk.bulletSpeed=1.5

      tXPos=144
      tYPos=random_range(256,368)
      tAtk=instance_create(tXPos,tYPos,oKraidNail)
      tAtk.direction=point_direction(tXPos,tYPos,oPlayer1.x,oPlayer1.y-26)
      tAtk.atkPower=atkPower; tAtk.bulletSpeed=1.5
      nailTime=0
    }

    //----- Normal Attack: Stomach Spike -----
    spikeTime+=1
    if spikeTime>=spikeDelay
    {
      var tAtk,tXPos,tYPos;
      spikeProg+=1
      if spikeProg=1 {tXPos=40; tYPos=55}
      else if spikeProg=2 {tXPos=67; tYPos=110}
      else if spikeProg=3 {tXPos=64; tYPos=173; spikeProg=0}
      tAtk=instance_create(segBody.x+tXPos,segBody.y+tYPos,oPassBullet)
      tAtk.sprite_index=sKraidSpike; tAtk.direction=0; tAtk.depth=26
      tAtk.atkPower=atkPower; tAtk.bulletSpeed=2.5; tAtk.decayTime=-100
      spikeTime=0
    }
    //----- Normal Attack: Ceiling Rock -----
    rockTime+=1
    if rockTime>=rockDelay and rockTime<10000
    {
      rockX=oPlayer1.x
      rockTime=10000
    }
    else if rockTime>=10001 and rockTime<=10045
    {
      if rockTime mod 3=0
      {
        var tEffect;
        tEffect=instance_create(rockX+random_range(-16,16),32,oEffectGrav)
        tEffect.sprite_index=sKraidRock; tEffect.type=2; tEffect.fadeSpd=0.03; tEffect.rotation=choose(-10,10); tEffect.grav=0.33
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=random_range(-0.25,0.25); tEffect.ySpd=1
      }
    }
    else if rockTime>=10046
    {
      var tAtk;
      tAtk=instance_create(rockX,32,oGravPassBullet)
      tAtk.sprite_index=sKraidRock; tAtk.depth=20; tAtk.image_xscale=2; tAtk.image_yscale=2; tAtk.atkPower=atkPower
      rockTime=0
    }

    //----- Scripted movement -----
    if moveUpProg=1 or moveUpProg=3
    {
      if moveTime<moveDelay-20
      {
        moveUpTime+=1
        segBody.x+=1.5
        if moveUpTime=1 {segFoot.image_index=2}
        else if moveUpTime=5 {segFoot.image_index=1}
        else if moveUpTime=9 {segFoot.image_index=0}
        else if moveUpTime=13 {segFoot.image_index=3}
        else if moveUpTime=14 {moveUpTime=0; moveUpProg+=1}
      }
    }

    if backFadeInTime>0 //Fade in red tint
    {
      redBack.image_alpha+=0.01
      backFadeInTime-=1
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.87 and lifePercent>=0.75 and bossProgress=0
    {
      mouthOpenTime-=2
      moveDelay-=3
      nailDelay-=8
      spikeDelay-=9
      rockDelay-=10
      backFadeInTime=7
      bossProgress+=1
    }
    else if lifePercent<=0.74 and lifePercent>=0.61 and bossProgress=1
    {
      mouthOpenTime-=2
      moveDelay-=3
      nailDelay-=8
      spikeDelay-=9
      rockDelay-=10
      moveUpProg=1
      backFadeInTime=7
      bossProgress+=1
    }
    else if lifePercent<=0.6 and lifePercent>=0.41 and bossProgress=2
    {
      mouthOpenTime-=2
      moveDelay-=3
      nailDelay-=8
      spikeDelay-=9
      rockDelay-=10
      backFadeInTime=7
      bossProgress+=1
    }
    else if lifePercent<=0.4 and lifePercent>=0.21 and bossProgress=3
    {
      mouthOpenTime-=2
      moveDelay-=3
      nailDelay-=8
      spikeDelay-=9
      rockDelay-=10
      moveUpProg=3
      backFadeInTime=7
      bossProgress+=1
    }
    else if lifePercent<=0.2 and lifePercent>=0 and bossProgress=4
    {
      mouthOpenTime-=2
      moveDelay-=3
      nailDelay-=8
      spikeDelay-=9
      rockDelay-=10
      backFadeInTime=7
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
      if global.bBossGallery=1
      {
        bossRoomTally(32)
        global.newMapX=1160; global.newMapY=784; room_goto(rBossGallery)
      }
    }
    else if deathAnim>=2
    {
      if deathAnim mod 6=0 {playSound(global.snd_EnemyDieMM,0,1,1)}
      if deathAnim mod 30=0 {playSound(global.snd_KraidRoarA,0,1,30000+random(30000))}
      if oGame.time mod 2=0
      {
        var tEffect;
        tEffect=instance_create(x-32+random(160),y-64+random(288),oEffect)
        tEffect.sprite_index=sSamusMissileHit; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }

      if redBack.image_alpha>0 {redBack.image_alpha-=0.01}
      segBody.y+=1
      if segBody.y>=room_height+96
      {
        oEvCh13MainA.sceneProgress=1
        instance_destroy()
      }
    }
  }
  x=segBody.x+15; y=segBody.y-28
  mouthHit.x=x+6; mouthHit.y=y-18
  segHead.x=segBody.x; segHead.y=segBody.y
  segArm.x=segBody.x+46; segArm.y=segBody.y+16
  segFoot.x=segBody.x+14; segFoot.y=segBody.y+186
  segHead.image_blend=image_blend
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
draw_sprite(sKraidTail,0,segBody.x-96,segBody.y+160)
draw_sprite(sKraidTail,0,segBody.x-128,segBody.y+160)
draw_sprite(sKraidTail,0,segBody.x-160,segBody.y+160)
draw_sprite(sKraidTail,0,segBody.x-192,segBody.y+160)
draw_sprite(sKraidTail,0,segBody.x-224,segBody.y+160)
draw_sprite(sKraidTail,0,segBody.x-256,segBody.y+160)
draw_sprite(sKraidTail,0,segBody.x-288,segBody.y+160)

//draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
