#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_xscale=-1
image_speed=0

//Enemy base statistics
eName="Sigma"
eLevel=19
maxLife=4600
life=maxLife
atkPower=7
resType[0]=2
resType[1]=2
stunResist=50
affiliation=4
bIsBoss=true
bNoBonus=true
hitSound=global.snd_EnemyHitMM
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
armSpr=sSigmaA_Arm1
armFrm=0
headFrm=0
blendCol=255
fadeAlpha=0

attackSequence=0
actionState=0
atkProg=0
roomSide=1 //0: Left, 1: Right
runAcc=0.25
walkMax=91

wallSpikes=0
wallPosX=0
wallSpd=3
setWallSpd=0
wallSeq=0
largeWaveSeq=0
largeWaveHP=350

//Misc Data
xCenter=240
yGround=288
roomSpan=208

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
    bShowHealthBar=true
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=1; showBossHP.lifeFill=1000
    jeremyText="You're in the Boss Gallery now it seems. I'm not telling you anything about this guy, you already know what he can do. Plus I'm feeling lazy, leave me alone."
    chaoText="I'm not quite as good as Jeremy on reading the behavior data, but I'll try my best. Like the Mavericks, Sigma follows a strict pattern, if you can learn that pattern, he's not too hard. Note that after what appears to be moving walls, he'll send out an undodgable attack. There's got to be something you can do to counter that one. As for his resistances, he seems to boost them when he's not taking any actions."
    devText="When planning the encounter against Sigma, I was originally going to go with a duel-like fight for this part. Due to story related shenanegans, I wanted Sigma to appear creepy and somewhat menacing. For this, using the X6 Sigma seemed perfect."
    activateBoss=2
  }

  if bActive=true and life>0
  {
    armFrm+=0.05

    if sprite_index=sSigmaA_Walk and armSpr=sSigmaA_Arm1
    {
      if bossProgress>=4 {resType[2]=1}
      else {resType[2]=2}
      resType[3]=2
      if bossProgress>=3 {resType[5]=1}
      else {resType[5]=2}
    }
    else
    {
      if bossProgress>=4 {resType[2]=2}
      else {resType[2]=3}
      resType[3]=3
      if bossProgress=3 or bossProgress=4 {resType[5]=2}
      else if bossProgress>=5 {resType[5]=1}
      else {resType[5]=3}
    }

    atkProg+=1
    if actionState=0 //--------- Walk forward ---------
    {
      if atkProg>=11 and atkProg<=walkMax
      {
        image_index+=0.08
        if roomSide=0 {x+=runAcc}
        else {x-=runAcc}
        if atkProg=40 and attackSequence=4
        {
          bCanTakeDamage=false
          bCanDealDamage=false
          attackSequence=0
          atkProg=0
          actionState=5
        }
      }
      else if atkProg>=walkMax+1
      {
        atkProg=0
        attackSequence+=1
        if attackSequence=1 or attackSequence=3 {actionState=1}
        else if attackSequence=2 or attackSequence=4 {actionState=3}
      }
    }
    else if actionState=1 //--------- Spew Scatter Shot ---------
    {
      if atkProg=1
      {
        sprite_index=sSigmaA_Lean
        armSpr=sSigmaA_Arm2
      }
      else if atkProg=15 {headFrm=1}
      else if atkProg>=20 and atkProg<=60
      {
        if atkProg mod 2=0
        {
          playSound(global.snd_SniperShot,0,0.94,29000)
          var tNewAttack,tAtkDir;
          tAtkDir=random_range(165,195)
          if image_xscale=1 {tAtkDir-=180}
          tNewAttack=instance_create(x+(20*image_xscale),y-40,oPassBullet)
          tNewAttack.sprite_index=sMMXbuster1
          tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=16; tNewAttack.decayTime=-100
          tNewAttack.direction=tAtkDir
        }
      }
      else if atkProg=65
      {
        sprite_index=sSigmaA_Walk
        armSpr=sSigmaA_Arm1
        headFrm=0
        atkProg=0
        actionState=2
      }
    }
    else if actionState=2 //--------- Throw Large Waves ---------
    {
      if atkProg=10
      {
        sprite_index=sSigmaA_Lean
        armSpr=sSigmaA_Arm3
      }
      else if atkProg=14
      {
        playSound(global.snd_ChargeStrike,0,0.94,19000)
        armSpr=sSigmaA_Arm4
        var tNewAttack;
        tNewAttack=instance_create(x+(29*image_xscale),y-26,oSigmaLargeWave)
        tNewAttack.atkPower=atkPower; tNewAttack.image_xscale=image_xscale
        if largeWaveSeq=0 {tNewAttack.yAtk=240}
        else if largeWaveSeq=1 {tNewAttack.yAtk=112}
        else if largeWaveSeq=2 {tNewAttack.yAtk=176}
        else if largeWaveSeq=3 {tNewAttack.yAtk=240}
        else if largeWaveSeq=4 {tNewAttack.yAtk=176}
        else if largeWaveSeq>=5 {tNewAttack.yAtk=112}
      }
      else if atkProg=18 {armSpr=sSigmaA_Arm3}
      else if atkProg=22
      {
        sprite_index=sSigmaA_Walk
        armSpr=sSigmaA_Arm1
      }
      else if atkProg=29
      {
        largeWaveSeq+=1
        if largeWaveSeq=5
        {
          largeWaveSeq=0
          atkProg=0
          actionState=0
        }
        else {atkProg=1}
      }
    }
    else if actionState=3 //--------- Send Push Walls ---------
    {
      if atkProg=1
      {
        playSound(global.snd_OrbThrow,0,0.98,11025)
        armSpr=sSigmaA_Arm3
      }
      else if atkProg=8
      {
        setWallSpd=wallSpd
        wallSpikes=1
      }
      else if atkProg=9
      {
        if image_xscale=1 {wallPosX=40}
        else {wallPosX=424}
      }
      else if atkProg=10
      {
        var tNewWall;
        tNewWall=instance_create(wallPosX,176,oSigmaPushWall)
        tNewWall.image_yscale=7; tNewWall.xMove=setWallSpd*image_xscale
      }
      else if atkProg=35
      {
        var tNewWall;
        tNewWall=instance_create(wallPosX,64,oSigmaPushWall)
        tNewWall.image_yscale=7; tNewWall.xMove=setWallSpd*image_xscale
      }
      else if atkProg=60
      {
        var tNewWall;
        tNewWall=instance_create(wallPosX,64,oSigmaPushWall)
        tNewWall.image_yscale=5; tNewWall.xMove=setWallSpd*image_xscale
        tNewWall=instance_create(wallPosX,208,oSigmaPushWall)
        tNewWall.image_yscale=5; tNewWall.xMove=setWallSpd*image_xscale
      }
      else if atkProg=85
      {
        var tNewWall;
        tNewWall=instance_create(wallPosX,144,oSigmaPushWall)
        tNewWall.image_yscale=4; tNewWall.xMove=setWallSpd*image_xscale
        if wallSeq=1
        {
          var tNewDmgWall;
          tNewDmgWall=instance_create(wallPosX,64,oSigmaTrapWall)
          tNewDmgWall.image_yscale=5; tNewDmgWall.xMove=setWallSpd*image_xscale
        }
        else if wallSeq=2
        {
          var tNewDmgWall;
          tNewDmgWall=instance_create(wallPosX,208,oSigmaTrapWall)
          tNewDmgWall.image_yscale=5; tNewDmgWall.xMove=setWallSpd*image_xscale
        }
      }
      else if atkProg=110
      {
        wallSeq+=1
        if wallSeq=3
        {
          wallSeq=0
          armSpr=sSigmaA_Arm1
          atkProg=0
          actionState=4
          wallSpikes=100
        }
        else {atkProg=9}
      }
    }
    else if actionState=4 //--------- Send Hit-back Wave ---------
    {
      if atkProg=30 {armSpr=sSigmaA_Arm3}
      else if atkProg=34
      {
        playSound(global.snd_ChargeStrike,0,0.94,11025)
        armSpr=sSigmaA_Arm4
        var tNewAttack;
        tNewAttack=instance_create(x+(29*image_xscale),y-26,oSigmaHitbackWave)
        tNewAttack.image_xscale=image_xscale
      }
      else if atkProg=38 {armSpr=sSigmaA_Arm3}
      else if atkProg=42 {armSpr=sSigmaA_Arm1}
      else if atkProg=65
      {
        atkProg=0
        actionState=0
      }
    }
    else if actionState=5 //--------- Disappear/Reappear ---------
    {
      if atkProg=1 or atkProg=31 {playSound(global.snd_Beam,0,0.94,16000)}

      if atkProg>=1 and atkProg<=20
      {
        blendCol-=12.75
        image_alpha-=0.05
        image_blend=make_color_rgb(blendCol,blendCol,blendCol)
      }
      else if atkProg=25
      {
        if roomSide=0
        {
          roomSide=1
          x=352
          image_xscale=-1
        }
        else
        {
          roomSide=0
          x=112
          image_xscale=1
        }
      }
      else if atkProg>=31 and atkProg<=50
      {
        blendCol+=12.75
        image_alpha+=0.05
        image_blend=make_color_rgb(blendCol,blendCol,blendCol)
      }
      else if atkProg=51
      {
        bCanTakeDamage=true
        bCanDealDamage=true
        atkProg=0
        actionState=0
      }
    }

    if actionState!=4 //--------- Sky Laser if behind Sigma ---------
    {
      if image_xscale=1 and oPlayer1.x<x+16
      {
        if oGame.time mod 3=0
        {
          var tSkyLaser;
          tSkyLaser=instance_create(oPlayer1.x,yGround,oFNSkyLaser)
          tSkyLaser.atkPower=atkPower; tSkyLaser.idleTime=30; tSkyLaser.bShake=0
        }
      }
      else if image_xscale=-1 and oPlayer1.x>x-16
      {
        if oGame.time mod 3=0
        {
          var tSkyLaser;
          tSkyLaser=instance_create(oPlayer1.x,yGround,oFNSkyLaser)
          tSkyLaser.atkPower=atkPower; tSkyLaser.idleTime=30; tSkyLaser.bShake=0
        }
      }
    }

    //-------------------- UTILITY: WALL SPIKES --------------------
    if wallSpikes>=1 and wallSpikes<=26
    {
      wallSpikes+=1
      if wallSpikes=2
      {
        for(i=0;i<14;i+=1)
        {
          leftSpikes[i]=instance_create(-16,64+(i*16),oStaticSpike)
          rightSpikes[i]=instance_create(room_width,64+(i*16),oStaticSpike)
        }
      }
      else if wallSpikes>=3 and wallSpikes<=26
      {
        for(i=0;i<14;i+=1)
        {
          leftSpikes[i].x+=2
          rightSpikes[i].x-=2

          if wallSpikes mod 3=0 //Spike smoke effect
          {
            var tEffect;
            tEffect=instance_create(leftSpikes[i].x+4,leftSpikes[i].y+2+random(12),oEffect)
            tEffect.sprite_index=sMMSmokeCloud
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
            tEffect=instance_create(rightSpikes[i].x+12,rightSpikes[i].y+2+random(12),oEffect)
            tEffect.sprite_index=sMMSmokeCloud
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          }
        }
      }
    }
    else if wallSpikes>=100
    {
      wallSpikes+=1
      if wallSpikes>=200
      {
        for(i=0;i<14;i+=1)
        {
          var tEffect;
          tEffect=instance_create(leftSpikes[i].x+8,leftSpikes[i].y+8,oEffect)
          tEffect.sprite_index=sMMExplosion
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          tEffect=instance_create(rightSpikes[i].x+8,rightSpikes[i].y+8,oEffect)
          tEffect.sprite_index=sMMExplosion
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
        with oStaticSpike {instance_destroy()}
        wallSpikes=0
      }
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.8 and lifePercent>=0.61 and bossProgress=0
    {
      walkMax-=7
      largeWaveHP+=20
      bossProgress+=1
    }
    else if lifePercent<=0.6 and lifePercent>=0.51 and bossProgress=1
    {
      walkMax-=7
      largeWaveHP+=20
      bossProgress+=1
    }
    else if lifePercent<=0.5 and lifePercent>=0.41 and bossProgress=2
    {
      var tAtkShield;
      tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
      tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=5; tAtkShield.atkUp=1
      resType[5]-=1
      bossProgress+=1
    }
    else if lifePercent<=0.4 and lifePercent>=0.21 and bossProgress=3
    {
      walkMax-=7
      wallSpd+=1
      largeWaveHP+=20
      var tAtkShield;
      tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
      tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=2; tAtkShield.atkUp=1
      resType[2]-=1
      bossProgress+=1
    }
    else if lifePercent<=0.2 and lifePercent>=0 and bossProgress=4
    {
      walkMax-=7
      largeWaveHP+=20
      var tAtkShield;
      tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
      tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=5; tAtkShield.atkUp=1
      resType[5]-=1
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      depth=19
      with oSigmaPushWall {instance_destroy()}
      with oSigmaTrapWall {instance_destroy()}
      with oSigmaHitbackWave {instance_destroy()}
      with oEProjectileBase {instance_destroy()}
      with oTrapBase {instance_destroy()}
      with oAttackBase {instance_destroy()}
    }
    else if deathAnim>=2
    {
      if deathAnim mod 10=0 {playSound(global.snd_EnemyDieMM,0,1,1)}
      if oGame.time mod 5=0
      {
        var tEffect;
        tEffect=instance_create(bbox_left+random(abs(sprite_width)),bbox_top+random(abs(sprite_height)),oEffect)
        tEffect.sprite_index=sMMExplosion; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }

      if deathAnim>=61 and deathAnim<=110
      {
        fadeAlpha+=0.02
        blendCol-=5.1
        image_blend=make_color_rgb(blendCol,blendCol,blendCol)
      }
      else if deathAnim>=130
      {
        if global.bBossGallery=1
        {
          bossRoomTally(23)
          global.newMapX=1144; global.newMapY=1056; room_goto(rBossGallery)
        }
        else
        {
          oEvCh8MainB.fadeColor=c_white
          oEvCh8MainB.fadeAlpha+=0.04
          if oEvCh8MainB.fadeAlpha>=1 {instance_destroy()}
        }
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
if fadeAlpha>0
{
  draw_set_alpha(fadeAlpha)
  draw_set_color(c_white)
  draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,0)
}

event_inherited()
if sprite_index=sSigmaA_Walk
  draw_sprite_ext(armSpr,armFrm,x-(11*image_xscale),y-59,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
else if sprite_index=sSigmaA_Lean
{
  draw_sprite_ext(sSigmaA_Head,headFrm,x+(17*image_xscale),y-41,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  draw_sprite_ext(armSpr,armFrm,x-(3*image_xscale),y-46,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}
