#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
eName="Sigma"
eLevel=19
maxLife=5600
life=maxLife
atkPower=6
resType[0]=2
resType[1]=2
resType[5]=4
stunResist=50
affiliation=4
bIsBoss=true
bNoBonus=true
hitSound=global.snd_EnemyHitMM
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
attackSequence=0
atkProg=0
fadeSeq=-1
greenFlash=make_color_rgb(150,255,150)

rayGunTime=-1
rayGunDelay=35
rayGunLength=45
rayGunTemp=0
rayGunBlend=255
rayAssistMod=28

bGroundGun=0
groundGunX=32

gridLaserAlpha=0
gridLaserX=0
gridLaserY=0
gridLaserDelay=0
checkGLDelay=0

iceAssistMod=36

//Misc Data
xCenter=240
yGround=288
roomSpan=208

deathAnim=0

sigParts[0]=instance_create(x+36,y+7,sSigmaBParts); sigParts[0].depth=25
sigParts[1]=instance_create(x+43,y+8,sSigmaBParts); sigParts[1].sprite_index=sSigmaB_LeftShoulder; sigParts[1].depth=26
sigParts[2]=instance_create(x+12,y-8,sSigmaBParts); sigParts[2].sprite_index=sSigmaB_Gun; sigParts[2].depth=27
sigParts[2].image_angle=20
sigParts[3]=instance_create(x-13,y-7,sSigmaBParts); sigParts[3].sprite_index=sSigmaB_RightArm; sigParts[3].depth=29
sigParts[4]=instance_create(x-18,y-24,sSigmaBParts); sigParts[4].sprite_index=sSigmaB_RightShoulder; sigParts[4].depth=30
sigParts[5]=instance_create(x+39,y+22,sSigmaBParts); sigParts[5].sprite_index=sSigmaB_Wires; sigParts[5].depth=31
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
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=0; showBossHP.lifeFill=1000
    jeremyText="You're in the Boss Gallery now it seems. I'm not telling you anything about this guy, you already know what he can do. Plus I'm feeling lazy, leave me alone."
    chaoText="There's so much data here... Okay, the behaviors you'll just have to observe for yourself. I did find something interesting about the Sigma Heads he summons. Apparently destroying those will damage Sigma himself, but I'm sure Sigma will eventually alter that loophole, so don't rely only on that completely. Oh yeah, stay out of the ray gun's blast area. You won't take knockback, but it'll continually drain your life."
    devText="Very fast paced is what I was going for with this encounter. I wanted something that was a mix of memory and twitch. Using fast projectiles would keep the player making precise movements and doesn't allow for a lot of wiggle room for mistakes. Like most bosses from the end of Gate 3 and up, there was a desperation attack planned, but if the boss flows well without it, it's cut."
    with oEnemyBase
    {
      jeremyText=oSigmaB.jeremyText
      chaoText=oSigmaB.chaoText
      devText=oSigmaB.devText
    }
    activateBoss=2
  }

  if bActive=true and life>0
  {
    //------------------ MAIN BEHAVIOR ------------------
    atkProg+=1
    if attackSequence=0 //Main - Ray Gun
    {
      if atkProg=1 {rayGunTime=0}
      else if atkProg=11
      {
        if bossProgress>=1
        {
          var tNewHead;
          tNewHead=instance_create(414,104,oSigmaB_BigHead)
          tNewHead.type=3; tNewHead.bMain=1; tNewHead.spikeType=0; tNewHead.assistMod=rayAssistMod
          tNewHead=instance_create(280,104,oSigmaB_BigHead)
          tNewHead.type=1; tNewHead.bMain=0; tNewHead.spikeType=1
          tNewHead=instance_create(350,248,oSigmaB_BigHead)
          tNewHead.type=2; tNewHead.bMain=0; tNewHead.spikeType=0
        }
      }
      else if atkProg>=10025
      {
        oSigmaB_BigHead.atkProg=100; oSigmaB_BigHead.atkTime=0
        fadeSeq=0
        attackSequence+=1
      }
    }
    else if attackSequence=2 //Side - Yellow Head
    {
      if atkProg=11
      {
        var tNewHead;
        tNewHead=instance_create(240,104,oSigmaB_BigHead)
        tNewHead.type=0; tNewHead.bMain=1; tNewHead.spikeType=0
        tNewHead=instance_create(65,248,oSigmaB_BigHead)
        tNewHead.type=1; tNewHead.bMain=0; tNewHead.spikeType=1
        tNewHead=instance_create(414,248,oSigmaB_BigHead)
        tNewHead.type=2; tNewHead.bMain=0; tNewHead.spikeType=1
      }
      else if atkProg>=140
      {
        oSigmaB_BigHead.atkProg=100; oSigmaB_BigHead.atkTime=0
        fadeSeq=10000
        attackSequence+=1
      }
    }
    else if attackSequence=4 //Main - Ground Blast
    {
      if atkProg=6
      {
        groundGunX=32
        var tNewHead;
        tNewHead=instance_create(65,104,oSigmaB_BigHead)
        tNewHead.type=0; tNewHead.bMain=0; tNewHead.spikeType=0
        tNewHead=instance_create(133,104,oSigmaB_BigHead)
        tNewHead.type=1; tNewHead.bMain=0; tNewHead.spikeType=1
        tNewHead=instance_create(414,200,oSigmaB_BigHead)
        tNewHead.type=2; tNewHead.bMain=0; tNewHead.spikeType=0
      }
      else if atkProg>=7 and atkProg<=30
      {
        if sigParts[2].image_angle<20 {sigParts[2].image_angle+=2}
      }
      else if atkProg=31
      {
        playSound(global.snd_CShotA,0,0.9,50000)
        bGroundGun=1
      }
      else if atkProg>=32 and atkProg<=99
      {
        groundGunX+=32
        if groundGunX>=xCenter+roomSpan
        {
          groundGunX=40
          bGroundGun=0
          atkProg=100
        }
      }
      else if atkProg=101 {playSound(global.snd_Flame1,0,1,1)}
      else if atkProg>=104 and atkProg<=199
      {
        var tNewExplode;
        for(i=0;i<2;i+=1)
        {
          tNewExplode=instance_create(groundGunX+(i*16),yGround,oDamageExplosion); tNewExplode.image_yscale=0.9
          tNewExplode.atkPower=atkPower-1; tNewExplode.sprite_index=sBTFirePillar; tNewExplode.decayTime=-100
        }
        groundGunX+=32
        if groundGunX>=xCenter+roomSpan-8 {atkProg=200}
      }
      else if atkProg>=140
      {
        oSigmaB_BigHead.atkProg=100; oSigmaB_BigHead.atkTime=0
        fadeSeq=0
        attackSequence+=1
      }
    }
    else if attackSequence=6 //Side - Red Head
    {
      if atkProg=11
      {
        var tNewHead;
        tNewHead=instance_create(414,248,oSigmaB_BigHead)
        tNewHead.type=0; tNewHead.bMain=0; tNewHead.spikeType=1
        tNewHead=instance_create(65,176,oSigmaB_BigHead)
        tNewHead.type=1; tNewHead.bMain=1; tNewHead.spikeType=2
        tNewHead=instance_create(414,104,oSigmaB_BigHead)
        tNewHead.type=2; tNewHead.bMain=0; tNewHead.spikeType=1
      }
      else if atkProg>=160
      {
        oSigmaB_BigHead.atkProg=100; oSigmaB_BigHead.atkTime=0
        fadeSeq=10000
        attackSequence+=1
      }
    }
    else if attackSequence=8 //Main - Grid laser
    {
      if atkProg=20
      {
        checkGLDelay=gridLaserDelay
        groundGunX=32
        var tNewHead,tEffect,tLaserPlacement;
        tNewHead=instance_create(414,176,oSigmaB_BigHead)
        tNewHead.type=0; tNewHead.bMain=0; tNewHead.spikeType=0
        tNewHead=instance_create(280,104,oSigmaB_BigHead)
        tNewHead.type=1; tNewHead.bMain=0; tNewHead.spikeType=1
        tNewHead=instance_create(343,104,oSigmaB_BigHead)
        tNewHead.type=2; tNewHead.bMain=0; tNewHead.spikeType=1
        instance_create(112,144,oStrikeChainPoint)
        instance_create(176,144,oStrikeChainPoint)
        instance_create(112,208,oStrikeChainPoint)
        instance_create(176,208,oStrikeChainPoint)
        tEffect=instance_create(112,144,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=2; tEffect.image_yscale=2
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        tEffect=instance_create(176,144,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=2; tEffect.image_yscale=2
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        tEffect=instance_create(112,208,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=2; tEffect.image_yscale=2
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        tEffect=instance_create(176,208,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=2; tEffect.image_yscale=2
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

        tLaserPlacement=irandom_range(1,4)
        if tLaserPlacement=1 {gridLaserX=176; gridLaserY=144}
        else if tLaserPlacement=2 {gridLaserX=112; gridLaserY=144}
        else if tLaserPlacement=3 {gridLaserX=176; gridLaserY=208}
        else if tLaserPlacement=4 {gridLaserX=112; gridLaserY=208}
      }
      else if atkProg>=21 and atkProg<=50 {gridLaserAlpha+=0.03}
      else if atkProg=90-checkGLDelay
      {
        playSound(global.snd_HardHit3,0,0.92,1)
        playSound(global.snd_LaserA,0,0.92,1)
        var tNewTrap;
        tNewTrap=instance_create(40,64,oZapTrapRed); tNewTrap.image_angle=270; tNewTrap.image_xscale=7
        tNewTrap=instance_create(56,64,oZapTrapRed); tNewTrap.image_angle=270; tNewTrap.image_xscale=7
        tNewTrap=instance_create(32,264,oZapTrapRed); tNewTrap.image_xscale=13
        tNewTrap=instance_create(32,280,oZapTrapRed); tNewTrap.image_xscale=13
        tNewTrap=instance_create(gridLaserX,64,oZapTrapRed); tNewTrap.image_angle=270; tNewTrap.image_xscale=7
        tNewTrap=instance_create(32,gridLaserY,oZapTrapRed); tNewTrap.image_xscale=13
      }
      else if atkProg>=130-checkGLDelay
      {
        tEffect=instance_create(112,144,oEffect)
        tEffect.sprite_index=sMMSmokeCloud; tEffect.image_xscale=2; tEffect.image_yscale=2
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        tEffect=instance_create(176,144,oEffect)
        tEffect.sprite_index=sMMSmokeCloud; tEffect.image_xscale=2; tEffect.image_yscale=2
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        tEffect=instance_create(112,208,oEffect)
        tEffect.sprite_index=sMMSmokeCloud; tEffect.image_xscale=2; tEffect.image_yscale=2
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        tEffect=instance_create(176,208,oEffect)
        tEffect.sprite_index=sMMSmokeCloud; tEffect.image_xscale=2; tEffect.image_yscale=2
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        gridLaserAlpha=0
        with oZapTrapRed {instance_destroy()}
        with oStrikeChainPoint {instance_destroy()}
        oSigmaB_BigHead.atkProg=100; oSigmaB_BigHead.atkTime=0
        fadeSeq=0
        attackSequence+=1
      }
    }
    else if attackSequence=10 //Side - Blue Head
    {
      if atkProg=11
      {
        var tNewHead;
        tNewHead=instance_create(65,104,oSigmaB_BigHead)
        if bossProgress>=2 {tNewHead.type=4; tNewHead.bMain=1; tNewHead.spikeType=0; tNewHead.assistMod=iceAssistMod}
        else {tNewHead.type=0; tNewHead.bMain=0; tNewHead.spikeType=1}

        tNewHead=instance_create(414,104,oSigmaB_BigHead)
        if bossProgress>=2 {tNewHead.type=5; tNewHead.bMain=1; tNewHead.spikeType=0; tNewHead.assistMod=iceAssistMod}
        else {tNewHead.type=1; tNewHead.bMain=0; tNewHead.spikeType=1}
        tNewHead=instance_create(414,176,oSigmaB_BigHead)

        tNewHead.type=2; tNewHead.bMain=1; tNewHead.spikeType=2
      }
      else if atkProg>=140
      {
        oSigmaB_BigHead.atkProg=100; oSigmaB_BigHead.atkTime=0
        fadeSeq=10000
        attackSequence+=1
      }
    }

    //------------------ NORMAL ATTACK: Ray Gun ------------------
    if rayGunTime>=0 {rayGunTime+=1}
    if rayGunTime>=rayGunDelay
    {
      if rayGunTime>=rayGunDelay and rayGunTime<=rayGunDelay+100
      {
        rayGunTime=10000
        if oPlayer1.y<=176 {rayGunTemp=0} //Point up
        else {rayGunTemp=1} //Point down
      }
      else if rayGunTime>=10001 and rayGunTime<=10020
      {
        if rayGunTemp=0
        {
          if sigParts[2].image_angle>-10 {sigParts[2].image_angle-=2}
        }
        else if rayGunTemp=1
        {
          if sigParts[2].image_angle<20 {sigParts[2].image_angle+=2}
        }
      }
      else if rayGunTime>=10021 and rayGunTime<=10040
      {
        rayGunBlend-=8
        sigParts[2].image_blend=make_color_rgb(255,rayGunBlend,rayGunBlend)
      }
      else if rayGunTime=10045
      {
        playSound(global.snd_LaserB,0,1,20000)
        var tNewRay;
        tNewRay=instance_create(x,y,oSigmaBRayGun)
        tNewRay.atkPower=2
      }
      else if rayGunTime>=10051 and rayGunTime<=10070
      {
        rayGunBlend+=8
        sigParts[2].image_blend=make_color_rgb(255,rayGunBlend,rayGunBlend)
      }
      else if rayGunTime>=10045+rayGunLength
      {
        oSigmaBRayGun.atkProg=3
        rayGunTime=-1
        atkProg=10000
      }
    }

    //------------------ UTILITY: DISAPPEAR ------------------
    if fadeSeq>=0 {fadeSeq+=1}
    if fadeSeq>=1 and fadeSeq<=9999
    {
      if fadeSeq=1 //Turn off damage flags
      {
        bCanTakeDamage=false
        bCanDealDamage=false
        for(i=0;i<6;i+=1) {sigParts[i].bCanDealDamage=false}
      }
      if fadeSeq mod 4=0 //Flash color
      {
        if image_blend=c_white
        {
          image_blend=greenFlash
          for(i=0;i<6;i+=1) {sigParts[i].image_blend=greenFlash}
        }
        else
        {
          image_blend=c_white
          for(i=0;i<6;i+=1) {sigParts[i].image_blend=c_white}
        }
      }
      image_alpha-=0.04 //Fade out
      for(i=0;i<6;i+=1) {sigParts[i].image_alpha-=0.04}
      if image_alpha<=0
      {
        x+=512
        fadeSeq=-1
        atkProg=0
        attackSequence+=1
      }
    }
    //------------------ UTILITY: REAPPEAR ------------------
    if fadeSeq>=10000
    {
      if fadeSeq=10001 {x-=512}
      if fadeSeq mod 4=0 //Flash color
      {
        if image_blend=c_white
        {
          image_blend=greenFlash
          for(i=0;i<6;i+=1) {sigParts[i].image_blend=greenFlash}
        }
        else
        {
          image_blend=c_white
          for(i=0;i<6;i+=1) {sigParts[i].image_blend=c_white}
        }
      }
      image_alpha+=0.04 //Fade in
      for(i=0;i<6;i+=1) {sigParts[i].image_alpha+=0.04}
      if image_alpha>=1
      {
        bCanTakeDamage=true
        bCanDealDamage=true
        for(i=0;i<6;i+=1) {sigParts[i].bCanDealDamage=true}
        image_blend=c_white
        for(i=0;i<6;i+=1) {sigParts[i].image_blend=c_white}
        fadeSeq=-1
        atkProg=0
        if attackSequence=11 {attackSequence=0}
        else {attackSequence+=1}
      }
    }

    //--------- Position Parts ---------
    sigParts[0].x=x+36; sigParts[0].y=y+7
    sigParts[1].x=x+43; sigParts[1].y=y+8
    sigParts[2].x=x+12; sigParts[2].y=y-8
    sigParts[3].x=x-13; sigParts[3].y=y-7
    sigParts[4].x=x-18; sigParts[4].y=y-24
    sigParts[5].x=x+39; sigParts[5].y=y+22

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.8 and lifePercent>=0.61 and bossProgress=0
    {
      gridLaserDelay+=2
      bossProgress+=1
    }
    else if lifePercent<=0.6 and lifePercent>=0.41 and bossProgress=1
    {
      rayAssistMod-=3
      gridLaserDelay+=3
      bossProgress+=1
    }
    else if lifePercent<=0.4 and lifePercent>=0.21 and bossProgress=2
    {
      rayAssistMod-=3
      gridLaserDelay+=3
      iceAssistMod-=4
      bossProgress+=1
    }
    else if lifePercent<=0.2 and lifePercent>=0 and bossProgress=3
    {
      rayAssistMod-=3
      gridLaserDelay+=2
      iceAssistMod-=10
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      for(i=0;i<6;i+=1) {sigParts[i].bCanDealDamage=false}
      with oStrikeChainPoint {instance_destroy()}
      with oEProjectileBase {instance_destroy()}
      with oTrapBase {instance_destroy()}
      with oSigmaB_BigHead {instance_destroy()}
      with oAttackBase {instance_destroy()}
    }
    else if deathAnim>=2 and deathAnim<=90
    {
      if deathAnim mod 10=0 {playSound(global.snd_EnemyDieMM,0,1,1)}
      if oGame.time mod 5=0
      {
        var tEffect;
        tEffect=instance_create(bbox_left+random(abs(sprite_width)),bbox_top+random(abs(sprite_height)),oEffect)
        tEffect.sprite_index=sMMExplosion; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim>=91
    {
      if global.bBossGallery=1
      {
        bossRoomTally(24)
        global.newMapX=1000; global.newMapY=1056; room_goto(rBossGallery)
      }
      else
      {
        for(i=0;i<6;i+=1)
        {
          with sigParts[i] {instance_destroy()}
        }
        instance_destroy()
      }
    }
  }
  enemyStepEvent()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bGroundGun=1
{
  draw_set_color(c_red)
  draw_set_alpha(1)
  draw_line_width(x-138,y+14,groundGunX,yGround,3)
}
if gridLaserAlpha>0
{
  draw_set_color(c_red)
  draw_set_alpha(gridLaserAlpha)
  draw_line_width(gridLaserX,-1,gridLaserX,room_height+1,2)
  draw_line_width(-1,gridLaserY,room_width+1,gridLaserY,2)

  draw_line_width(40,-1,40,room_height+1,2)
  draw_line_width(56,-1,56,room_height+1,2)
  draw_line_width(-1,264,room_width+1,264,2)
  draw_line_width(-1,280,room_width+1,280,2)
}
event_inherited()
